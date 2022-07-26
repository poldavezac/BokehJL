module Deserialize
using Base64
using ...Model
using ...AbstractTypes
using ..Serialize
using ..Protocol: Buffers

const JSDict       = Dict{String, Any}
const ModelDict    = Dict{Int64, iHasProps}
const _MODEL_TYPES = Dict{Symbol, DataType}()
const _LOCK        = Threads.SpinLock()
const _𝑏_OPTS      = Union{JSDict, Vector}
const _END_PATT    = r"^end" => "finish"

_fieldname(x::String) = Symbol(replace(x, _END_PATT))

getid(𝐼::JSDict) :: Int64 = parse(Int64, 𝐼["id"])

"""
Contains info needed for deserialization.
"""
struct Workbench
    models   :: ModelDict
    contents :: Vector
    buffers  :: Buffers
end

function createreference!(𝑀::Workbench, id::Int, 𝐼::JSDict)
    get!(𝑀.models, id) do
        𝑇 = _MODEL_TYPES[Symbol(𝐼["type"])]
        return 𝑇(;
            id,
            ((
                _fieldname(i) => deserialize(𝑇, _fieldname(i), j, 𝑀)
                for (i, j) ∈ get(𝐼, "attributes", ())
            )...)
        )
    end
end

_knownconversion(_...) = nothing

function _knownconversion(ν::JSDict, 𝑀::Workbench)
    return if length(ν) ≡ 1 && first(keys(ν)) == "id"
        deserialize(iHasProps, ν, 𝑀)
    elseif haskey(ν, _𝐵𝐾) ||  haskey(ν, _𝑁𝐾)
        deserialize(Vector, ν, 𝑀)
    else
        nothing
    end
end

function deserialize(𝑇::Type, attr::Symbol, val, 𝑀::Workbench)
    @nospecialize 𝑇 val
    out = _knownconversion(val, 𝑀)
    if isnothing(out)
        deserialize(Model.bokehfieldtype(𝑇, attr), val, 𝑀)
    else
        out
    end
end

function deserialize(@nospecialize(𝑇::Type), val::JSDict, 𝑀::Workbench)
    out = _knownconversion(val, 𝑀)
    return if isnothing(out)
        cnv = Dict((i => deserialize(Any, j, 𝑀) for (i, j) ∈ val)...)
        out = Model.bokehconvert(𝑇, cnv)
        out isa Model.Unknown ? val : out
    else
        out
    end
end

deserialize(::Type, @nospecialize(val::Union{Nothing, String, Number}), ::Workbench) = val
deserialize(::Type, @nospecialize(val::Vector), 𝑀::Workbench) = [deserialize(Any, i, 𝑀) for i ∈ val]

function deserialize(::Type{<:iHasProps}, val::JSDict, 𝑀::Workbench)
    key  = val["id"]
    bkid = parse(Int64, key)
    itm  = get(𝑀.models, bkid, nothing)
    if isnothing(itm)
        createreference!(𝑀, bkid, only(j for j ∈ 𝑀.contents if j["id"] == key))
    else
        itm
    end
end

function deserialize(@nospecialize(𝑇::Type{<:Pair}), val::JSDict, 𝑀::Workbench)
    @assert length(val) == 1
    (k, v) = first(val)
    return deserialize(𝑇.parameters[1], k, 𝑀) => deserialize(𝑇.parameters[2], v, 𝑀)
end

function deserialize(@nospecialize(𝑇::Type{<:AbstractDict}), ν::JSDict, 𝑀::Workbench)
    p𝑇 = eltype(𝑇)
    Dict((Pair(deserialize(p𝑇.parameters[1], i, 𝑀), deserialize(p𝑇.parameters[2], j, 𝑀)) for (i, j) ∈ ν)...)
end

function deserialize(@nospecialize(𝑇::Type{<:AbstractVector}), ν::JSDict, 𝑀::Workbench)
    return if haskey(ν, _𝐵𝐾)
        _reshape(𝑀.buffers[ν[_𝐵𝐾]], ν["dtype"], ν["shape"], ν["order"])
    elseif haskey(ν, _𝑁𝐾)
        _reshape(base64decode(ν[_𝑁𝐾]), ν["dtype"], ν["shape"], ν["order"])
    else
        throw(ErrorException("Unknown message format $𝑇 <= $ν"))
    end
end

function deserialize(𝑇::Type{<:AbstractVector}, ν::Vector, 𝑀::Workbench)
    v𝑇 = eltype(𝑇)
    return [deserialize(v𝑇, i, 𝑀) for i ∈ ν]
end

function deserialize(𝑇::Type{<:AbstractSet}, ν::Vector, 𝑀::Workbench)
    v𝑇 = eltype(𝑇)
    return Set([deserialize(v𝑇, i, 𝑀) for i ∈ ν])
end

function deserialize(::Type{DataDict}, ν::JSDict, 𝑀::Workbench)
    out = DataDict()
    for (i, j) ∈ ν
        arr = Model.datadictarray(deserialize(Vector, j, 𝑀))
        push!(out, i => arr)
    end
    out
end

for (name, action) ∈ (:RootAdded => :push!, :RootRemoved => :delete!)
    @eval function apply(::Val{$(Meta.quot(name))}, 𝐷::iDocument, 𝐼::JSDict, 𝑀::Workbench)
        $action(𝐷, deserialize(iHasProps, 𝐼["model"], 𝑀))
    end
end

function apply(::Val{:TitleChanged}, 𝐷::iDocument, 𝐼 :: JSDict, ::Workbench)
    𝐷.title = 𝐼["title"]
end

function apply(::Val{:ModelChanged}, 𝐷::iDocument, 𝐼::JSDict, 𝑀::Workbench)
    mdl  = deserialize(iHasProps, 𝐼["model"], 𝑀)
    attr = _fieldname(𝐼["attr"])
    val  = deserialize(typeof(mdl), attr, 𝐼["new"], 𝑀)
    setproperty!(mdl, attr, val; patchdoc = true)
end

function apply(::Val{:ColumnDataChanged}, 𝐷::iDocument, 𝐼::JSDict, 𝑀::Workbench)
    obj  = deserialize(iHasProps, 𝐼["column_source"], 𝑀)
    data = deserialize(DataDict, 𝐼["new"], 𝑀)
    Model.update!(obj.data, data)
end

function apply(::Val{:ColumnsStreamed}, 𝐷::iDocument, 𝐼::JSDict, 𝑀::Workbench)
    obj  = deserialize(iHasProps, 𝐼["column_source"], 𝑀)
    data = deserialize(DataDict, 𝐼["data"], 𝑀)
    Model.stream!(obj.data, data; rollover = 𝐼["rollover"])
end

function apply(::Val{:ColumnsPatched}, 𝐷::iDocument, 𝐼::JSDict, 𝑀::Workbench)
    obj  = deserialize(iHasProps, 𝐼["column_source"], 𝑀)
    data = Dict{String, Vector{Pair}}(
        col => Pair[_𝑐𝑝_key(x) => _𝑐𝑝_value(y) for (x, y) ∈ lst]
        for (col, lst) ∈ 𝐼["patches"]
    )
    Model.patch!(obj.data, data)
end

function deserialize!(𝑀::ModelDict, @nospecialize(𝐶::Vector), 𝐵::Buffers)
    if length(Model.MODEL_TYPES) ≢ length(_MODEL_TYPES)
        𝑅 = Serialize.Rules()
        lock(_LOCK) do
            for cls ∈ Model.MODEL_TYPES
                _MODEL_TYPES[nameof(cls)] = cls
            end
        end
    end

    info = Workbench(𝑀, 𝐶, 𝐵)
    for new ∈ 𝐶
        createreference!(info, getid(new), new)
    end
    𝑀
end

"""
    deserialize!(𝐷::iDocument, 𝐶::JSDict, 𝐵::Buffers)

Uses data extracted from websocket communication to update a document.
"""
function deserialize!(𝐷::iDocument, 𝐶::JSDict, 𝐵::Buffers)
    𝑀    = deserialize!(bokehmodels(𝐷), 𝐶["references"], 𝐵)
    info = Workbench(𝑀, 𝐶["events"], 𝐵)
    for msg ∈ 𝐶["events"]
        apply(Val(Symbol(msg["kind"])), 𝐷, msg, info)
    end
end


function _reshape(data::Union{Vector{Int8}, Vector{UInt8}}, dtype::String, shape::Vector{Any}, order::String)
    arr = reinterpret(
        let tpe = dtype
            tpe == "uint8"   ? UInt8   : tpe == "uint16"  ? UInt16  : tpe == "uint32" ? UInt32 :
            tpe == "int8"    ? Int8    : tpe == "int16"   ? Int16   : tpe == "int32"  ? Int32  :
            tpe == "float32" ? Float32 : tpe == "float64" ? Float64 : throw(ErrorException("Unknown type $tpe"))
        end,
        data
    )
    if order ≡ "little" && Base.ENDIAN_BOM ≡ 0x01020304
        arr = ltoh.(arr)
    elseif order ≡ "big" && Base.ENDIAN_BOM ≡ 0x04030201
        arr = htol.(arr)
    end
    return if length(shape) == 1
        arr
    else
        sz  = tuple(shape[2:end]...)
        len = prod(sz)
        [
            reshape(view(arr, i:i+len-1), sz)
            for i ∈ 1:len:length(arr)
        ]
    end
end

const _𝐵𝐾       = "__buffer__"
const _𝑁𝐾       = "__ndarray__"
const _𝑐𝑝_SLICE = AbstractDict{<:AbstractString, <:Union{Nothing, Integer}}

_𝑐𝑝_key(𝑥::Integer)   = 𝑥+1
_𝑐𝑝_key(@nospecialize(𝑥::Vector)) = (𝑥[1]+1, _𝑐𝑝_fro(𝑥[2]), _𝑐𝑝_fro(𝑥[3]))
_𝑐𝑝_key(𝑥::_𝑐𝑝_SLICE) =  (;
    start = let x = get(𝑥, "start", nothing)
        isnothing(x) ? 1 : x + 1
    end,
    step = let x = get(𝑥, "step", nothing)
        isnothing(x) ? 1 : x
    end,
    stop = get(𝑥, "stop", nothing)
)

_𝑐𝑝_value(@nospecialize(x::Union{Number, String, iHasProps, AbstractVector{<:Number}})) = x
_𝑐𝑝_value(@nospecialize(x::AbstractVector{Int64})) = collect(Int32, x)
_𝑐𝑝_value(x::Vector{Any}) = collect((i for i ∈ x))

export deserialize!
end
using .Deserialize
