using Dates

struct DataDictContainer <: iContainer{DataDict}
    parent :: WeakRef
    attr   :: Symbol
    values :: DataDict
end

Base.show(io::IO, ::Type{DataDict}) = print(io, "BokehServer.Model.DataDict")

Base.setindex!(ฮณ::DataDictContainer, ๐ฃ, ๐) = (update!(ฮณ, ๐ => ๐ฃ); ๐ฃ)
Base.size(ฮณ::DataDictContainer) = isempty(ฮณ.values) ? (0, 0) : (length(first(values(ฮณ.values))), length(ฮณ.values))
Base.size(ฮณ::DataDictContainer, i :: Int) = isempty(ฮณ.values) ? 0 : i โก 1 ? length(first(values(ฮณ.values))) : length(ฮณ.values)

bokehread(๐::Type{DataDict}, ยต::iHasProps, ฮฑ::Symbol, ฮฝ::DataDict) = DataDictContainer(WeakRef(ยต), ฮฑ, ฮฝ)

macro _๐๐ _trigger(T, args...)
    esc(quote
        let parent = ฮณ.parent.value
            if (dotrigger && !isnothing(parent) && (getfield(parent, ฮณ.attr) โก ฮณ.values))
                BokehServer.Events.trigger(BokehServer.Events.$T(parent, ฮณ.attr, $(args...)))
            end
        end
    end)
end

macro _๐๐ _merge_args(code)
    esc(quote
        isempty(๐s) && return ฮณ

        ๐tmp = if length(๐s) โก 1 && first(๐s) isa AbstractDict
            first(๐s)
        else
            out = Dict{String, Vector}()
            for ๐ โ ๐s, (i, j) โ (๐ isa Pair ? (๐,) : bokehunwrap(๐))
                out[i] = $code
            end
            out
        end
        isempty(๐tmp) && return ฮณ

        ๐ = DataDict(
            i => let arr = get(ฮณ.values, i, nothing)
                isnothing(arr) ? datadictarray(j) : datadictarray(eltype(arr), j)
            end
            for (i,j) โ ๐tmp
        )
    end)
end

function _๐๐ _check(data::DataDict, others::Vararg{AbstractVector})
    isempty(data) && isempty(others) && return
    sz = isempty(data) ? length(first(others)) : length(first(values(data)))
    if any(sz โข length(i) for i โ values(data)) || any(sz โข length(i) for i โ others)
        throw(ErrorException("The data source columns must have equal length"))
    end
end

"""
    datadictelement(::Type{T}, ๐) where {T}
    datadictelement(::Type{T}, ๐::AbstractArray) where {T}

Convert a `DataDict` array *element* to the correct type `T` or `<:AbstractArray{T}`
"""
datadictelement(::Type{Color},   @nospecialize(๐)) :: String = colorhex(๐)
datadictelement(::Type{String},  ๐::Color) :: String = colorhex(๐)
datadictelement(::Type{Float64}, @nospecialize(๐::Dates.AbstractTime)) :: Float64 =  bokehconvert(Float64, ๐)
datadictelement(::Type{String},  ::Missing) :: String = ""
datadictelement(::Type{Float64}, ::Missing) :: Float64 =  NaN64
datadictelement(::Type{Float32}, ::Missing) :: Float32 =  NaN32
datadictelement(::Type{T}, ๐::Union{T, AbstractArray{T}}) where {T} = ๐
datadictelement(@nospecialize(T::Type), @nospecialize(๐::Number)) = convert(T, ๐)
datadictelement(@nospecialize(T::Type), @nospecialize(๐::AbstractArray)) = datadictelement.(T, ๐)

"""
    datadictarray(::Type{T}, ๐) where {T}

Convert a `DataDict` *array*  to the correct type `Vector{T}`
"""
datadictarray(@nospecialize(T::Type), @nospecialize(๐::AbstractVector)) = datadictelement.(T, ๐)
datadictarray(T::Type, ๐::AbstractVector{<:AbstractArray}) = [datadictelement.(T, i) for i โ ๐]
datadictarray(::Type{T}, ๐::Union{AbstractVector{T}, AbstractVector{<:AbstractArray{T}}}) where {T} = ๐

"""
    datadictarray(::Type{ColorSpec},  ๐::AbstractVector)
    datadictarray(::Type{NumberSpec}, ๐::AbstractVector)
    datadictarray(::Type{IntSpec},    ๐::AbstractVector)

Convert a `DataDict` *array*  to the correct type `Vector{T}`
"""
datadictarray(::Type{ColorSpec}, @nospecialize(๐::AbstractVector{<:AbstractString})) = ๐
datadictarray(::Type{ColorSpec}, @nospecialize(๐::AbstractVector)) = colorhex.(๐)
function datadictarray(๐::Type{<:iSpec}, ๐::AbstractVector)
    @nospecialize ๐ ๐
    e๐ = bokehstoragetype(speceltype(๐))
    return e๐ โก eltype(๐) ? ๐ : datadictelement.(e๐, ๐)
end
datadictarray(๐::Type{NullDistanceSpec}, @nospecialize(๐::AbstractVector)) = Float64 โก eltype(๐) ? ๐ : Float64.(๐)
datadictarray(๐::Type{NullStringSpec}, @nospecialize(๐::AbstractVector))   = datadictarray(StringSpec, ๐)
datadictarray(๐::Type{StringSpec}, @nospecialize(๐::AbstractVector))       = eltype(๐) <: AbstractString ? ๐ : string.(๐)

for (๐1, ๐2) โ (Dates.AbstractTime => Float64, Int64 => Int32)
    @eval datadictarray(@nospecialize(๐::AbstractVector{<:$๐1}))                             = datadictarray($๐2, ๐)
    @eval datadictarray(@nospecialize(๐::AbstractVector{<:AbstractArray{<:$๐1}}))            = datadictarray($๐2, ๐)
    @eval datadictarray(@nospecialize(๐::AbstractVector{Union{Missing, T}} where {T <: $๐1}))= datadictarray(Float64, ๐)
end

for (๐, ๐น) โ (:Missing => :ismissing, :Nothing => :isnothing)
    @eval function datadictarray(๐::AbstractVector{Union{$๐, T}}) where {T <: AbstractString}
        nan = T()
        return T[ifelse($๐น(i), nan, i) for i โ ๐]
    end

    for (๐, ๐) โ (Float64 => NaN64, Float32 => NaN32)
        @eval function datadictarray(๐::AbstractVector{Union{$๐, $๐}}) :: Vector{$๐}
            return $๐[ifelse($๐น(i), $๐, i) for i โ ๐]
        end
    end

    @eval function datadictarray(๐::AbstractVector{Union{$๐, Int64}}) :: Vector{Float64}
        return Float64[$๐น(i) ? NaN64 : convert(Float64, i) for i โ ๐]
    end

    @eval function datadictarray(๐::AbstractVector{Union{$๐, T}} where {T <: Number}) :: Vector{Float32}
        return Float64[$๐น(i) ? NaN32 : convert(Float32, i) for i โ ๐]
    end
end

datadictarray(@nospecialize(๐::AbstractVector{<:Union{iHasProps, AbstractTypes.ElTypeDataDict...}})) = ๐
datadictarray(@nospecialize(๐::AbstractVector{<:AbstractArray{<:Union{iHasProps, AbstractTypes.ElTypeDataDict...}}})) = ๐
datadictarray(@nospecialize(๐::AbstractRange)) = datadictarray(collect(๐))

bokehstoragetype(::Type{DataDict}) = DataDict
bokehconvert(::Type{DataDict}, x::DataDict) = copy(x)

for cls โ (
        AbstractDict{<:AbstractString},
        AbstractVector{<:Pair{<:AbstractString}},
        DataDictContainer
)
    @eval bokehconvert(::Type{DataDict}, x::$cls) = DataDict(("$i" => datadictarray(j) for (i, j) โ x)...)
end

bokehchildren(x::DataDict) = Iterators.flatten(Iterators.filter(Base.Fix2(<:, iHasProps) โ eltype, values(x)))
