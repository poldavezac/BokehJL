const CONTAINERS = Union{AbstractArray, AbstractDict, AbstractSet}

abstract type iContainer{T} <: iProperty end

struct Container{T, K} <: iContainer{T}
    parent::WeakRef
    attr  ::Symbol
    values::K
end

containertype(::Type{<:iContainer{T}}) where {T} = T

function bokehread(๐::Type{<:CONTAINERS}, ยต::iHasProps, ฮฑ::Symbol, ฮฝ::CONTAINERS)
    Container{๐, bokehstoragetype(๐)}(WeakRef(ยต), ฮฑ, ฮฝ)
end

bokehunwrap(ฮฝ::iContainer) = ฮฝ.values

# WARNING: we need explicit template args to make sure `bokehstoragetype(::Union)` will be called when needed
bokehstoragetype(๐::Type{<:AbstractDict{K, V}})  where {K, V} = ๐.name.wrapper{bokehstoragetype(K), bokehstoragetype(V)}
bokehstoragetype(๐::Type{<:AbstractSet{T}})      where {T}    = ๐.name.wrapper{bokehstoragetype(T)}
bokehstoragetype(๐::Type{<:AbstractArray{T, N}}) where {T, N} = ๐.name.wrapper{bokehstoragetype(T), N}

function bokehconvert(๐::Type{<:AbstractDict{๐พ, ๐}}, ฮฝ::AbstractDict) where {๐พ, ๐}
    params = ๐.parameters
    outp   = bokehstoragetype(๐)()
    for (i,j) โ ฮฝ
        iv = bokehconvert(๐พ, i)
        (iv isa Unknown) && return Unknown()

        jv = bokehconvert(๐, j)
        (jv isa Unknown) && return Unknown()

        push!(outp, iv => jv)
    end
    return outp
end

for cls โ (AbstractSet, AbstractVector)
    @eval function bokehconvert(๐::Type{<:$cls{๐ผ}}, ฮฝ::$cls) where {๐ผ}
        outp = bokehstoragetype(๐)()
        for i โ ฮฝ
            iv = bokehconvert(๐ผ, i)
            (iv isa Unknown) && return Unknown()
            push!(outp, iv)
        end
        return outp
    end
end

bokehconvert(๐::Type{<:Pair}, ฮฝ::Pair) = bokehconvert(๐.parameters[1], first(ฮฝ)) => bokehconvert(๐.parameters[2], last(ฮฝ))

for (๐น, (๐, code)) โ (
        :push!      => Container => :((bokehconvert(eltype(containertype(T)), i) for i โ x)),
        :setindex!  => Container{<:AbstractDict}   => :((bokehconvert(eltype(containertype(T)).parameters[2], x[1]), x[2])),
        :setindex!  => Container{<:AbstractArray}  => :((bokehconvert(eltype(containertype(T)), x[1]), x[2:end]...)),
        :pop!       => Container => :x,
        :empty!     => Container => :x,
        :append!    => iContainer{<:AbstractArray} => :((bokehconvert(containertype(T), i) for i โ x)),
        :deleteat!  => iContainer{<:AbstractArray} => :x,
        :popat!     => iContainer{<:AbstractArray} => :x,
        :popfirst!  => iContainer{<:AbstractArray} => :x,
        :insert!    => iContainer{<:AbstractArray} => :((bokehconvert(eltype(containertype(T)), i) for i โ x)),
        :delete!    => iContainer{<:Union{AbstractDict, AbstractSet}}  => :x,
        :merge!     => iContainer{<:AbstractDict} => :((bokehconvert(containertype(T), i) for i โ x)),
)
    @eval function Base.$๐น(ฮณ::T, x...; dotrigger::Bool = true) where {T <: $๐}
        parent = ฮณ.parent.value
        if isnothing(parent) || getfield(parent, ฮณ.attr) โข ฮณ.values
            $๐น(ฮณ.values, $code...)
        else
            out = $๐น(copy(ฮณ.values), $code...)
            setproperty!(parent, ฮณ.attr, out; dotrigger)
            out โก ฮณ.values ? ฮณ : out
        end
    end
end

function Base.filter!(๐น::Function, ฮณ::Container; dotrigger::Bool = true)
    parent = ฮณ.parent.value
    if isnothing(parent) || getfield(parent, ฮณ.attr) โข ฮณ.values
        filter!(๐น, ฮณ.values)
    else
        out = filter!(๐น, copy(ฮณ.values))
        setproperty!(parent, ฮณ.attr, out; dotrigger)
        out โก ฮณ.values ? ฮณ : out
    end
end

Base.get!(ฮณ::iContainer{<:AbstractDict}, x, y) = haskey(ฮณ, x) ? ฮณ[x] : (ฮณ[x] = y; y)
Base.get!(๐น::Function, ฮณ::iContainer{<:AbstractDict}, x) = haskey(ฮณ, x) ? ฮณ[x] : (y = ๐น(); ฮณ[x] = y; y)

for (๐น, ๐) โ (
        :length     => iContainer,
        :iterate    => iContainer,
        :size       => iContainer{<:AbstractArray},
        :eachindex  => iContainer{<:AbstractArray},
        :lastindex  => iContainer{<:AbstractArray},
        :firstindex => iContainer{<:AbstractArray},
        :get        => iContainer{<:AbstractDict},
        :haskey     => iContainer{<:AbstractDict},
        :keys       => iContainer{<:AbstractDict},
        :values     => iContainer{<:AbstractDict},
)
    @eval Base.$๐น(ฮณ::$๐, x...)  = $๐น(ฮณ.values, x...)
end

Base.isempty(ฮณ::iContainer)     = isempty(ฮณ.values)
Base.getindex(ฮณ::iContainer, x) = ฮณ.values[x]
Base.getindex(ฮณ::iContainer)    = ฮณ.values[]

for ๐น โ (:in, :any, :all, :filter)
    @eval Base.$๐น(ฮฝ, ฮณ::iContainer) = $๐น(ฮฝ, ฮณ.values)
end
Base.eltype(::Type{<:iContainer{T}}) where {T}  = eltype(T)

struct RestrictedKey{T} <: iProperty end

bokehstoragetype(::Type{<:RestrictedKey}) = Symbol
bokehconvert(๐::Type{<:RestrictedKey}, ฮฝ::AbstractString) = bokehconvert(๐, Symbol(ฮฝ))
function bokehconvert(::Type{RestrictedKey{T}}, ฮฝ::Symbol) where {T}
    (ฮฝ โ T) && throw(KeyError("Key $ฮฝ is not allowed"))
    return ฮฝ
end
