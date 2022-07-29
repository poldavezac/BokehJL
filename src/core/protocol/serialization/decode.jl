module Deserialize
using Base64
using ...Model
using ...AbstractTypes
using ..Protocol: Buffers

const JSDict       = Dict{String, Any}
const _MODEL_TYPES = Dict{Symbol, DataType}()
const _LOCK        = Threads.SpinLock()
const _𝑏_OPTS      = Union{JSDict, Vector}
const _END_PATT    = r"^end" => "finish"
const _👻Simple    = Union{AbstractString, Number, Nothing}

_fieldname(x::String) = Symbol(replace(x, _END_PATT))

getid(𝐼::JSDict) :: Int64 = parse(Int64, 𝐼["id"])

"""
Contains info needed for deserialization.
"""
struct Deserializer
    references  :: JSDict
    doc         :: iDocument
end

function Deserializer(doc::iDocument, b::Buffers)
    refs = JSDict(𝐵..., ("$i" => j for (i, j) ∈ Model.bokemodels(doc)))
    Deserializer(refs, doc)
end

"""
    deserialize!(𝐷::iDocument, 𝐶::JSDict, 𝐵::Buffers)

Uses data extracted from websocket communication to update a document.
"""
function deserialize!(𝐷::iDocument, 𝐶::JSDict, 𝐵::Buffers)
    if length(Model.MODEL_TYPES) ≢ length(_MODEL_TYPES)
        lock(_LOCK) do
            for cls ∈ Model.MODEL_TYPES
                _MODEL_TYPES[nameof(cls)] = cls
            end
        end
    end
    decode(𝐶, Deserializer(𝐷, 𝐵))
end

decodefield(::Type, ::Symbol, @nospecialize(η)) = η

function _𝑑𝑒𝑐_number(η::JSDict, ::Deserializer)
    val = η["value"]
    return val == "nan" ? NaN64 : val == "-inf" ? -Inf64 : Inf64
end

_𝑑𝑒𝑐_number(η::JSDict, 𝑅::Deserializer)       = 𝑅.references[parse(Int64, η["id"])]
_𝑑𝑒𝑐_value(η::JSDict, 𝑅::Deserializer)        = Dict{Symbol, Any}(Symbol(i) => decode(j, 𝑅) for (i, j) ∈ η)
_𝑑𝑒𝑐_field(η::JSDict, 𝑅::Deserializer)        = Dict{Symbol, Any}(Symbol(i) => decode(j, 𝑅) for (i, j) ∈ η)
_𝑑𝑒𝑐_expr(η::JSDict, 𝑅::Deserializer)         = Dict{Symbol, Any}(Symbol(i) => decode(j, 𝑅) for (i, j) ∈ η)
_𝑑𝑒𝑐_map(η::JSDict, 𝑅::Deserializer)          = JSDict(i => decode(j, 𝑅) for (i, j) ∈ η)
_𝑑𝑒𝑐_set(η::JSDict, 𝑅::Deserializer)          = Set(decode(j, 𝑅) for j ∈ η)
_𝑑𝑒𝑐_typed_array(η::JSDict, 𝑅::Deserializer)  = _reshape(decode(η["array"], 𝑅), η["dtype"], Any[], η["order"])
_𝑑𝑒𝑐_ndarray(η::JSDict, 𝑅::Deserializer)      = _reshape(decode(η["array"], 𝑅), η["dtype"], η["shape"], η["order"])
_𝑑𝑒𝑐_rootadded(η::JSDict, 𝑅::Deserializer)    = push!(𝑅.doc, decode(η["model"], 𝑅))
_𝑑𝑒𝑐_titlechanged(η::JSDict, 𝑅::Deserializer) = 𝑅.doc.title = η["title"]

function _𝑑𝑒𝑐_object(η::JSDict, 𝑅::Deserializer)
    if haskey(η, "id")
        get!(𝑅.models, parse(Int64, η["id"])) do
            return _MODEL_TYPES[Symbol(𝐼["name"])](;
                id,
                ((
                    _fieldname(i) => decodefield(𝑇, _fieldname(i), decode(η, 𝑅))
                    for (i, j) ∈ get(𝐼, "attributes", ())
                )...)
            )
        end
    else
        throw(ErrorException("Not implemented"))
    end
end

function _𝑑𝑒𝑐_bytes(η::JSDict, 𝑅::Deserializer)
    data = η["data"]
    data isa String ? base64decode(data) : data isa Vector ? collect(data) : 𝑅.refrences[data["id"]]
end

function _𝑑𝑒𝑐_slice(η::JSDict)
    start = let x = get(η, "start", nothing)
        isnothing(x) ? 1 : x + 1
    end,
    step = let x = get(η, "step", nothing)
        isnothing(x) ? 1 : x
    end,
    stop = get(η, "stop", nothing)
    return step ≡ 1 ? (start:stop) :  (start:step:stop)
end

function _𝑑𝑒𝑐_rootremoved(η::JSDict, 𝑅::Deserializer)
    id = parse(Int64, η["model"]["id"])
    if 𝑅.doc[end].id ≡ id
        pop!(𝑅.doc)
    else
        throw(ErrorException("Incorrect id in RootRemoved"))
    end
end

function _𝑑𝑒𝑐_modelchanged(η::JSDict, 𝑅::Deserializer)
    mdl  = decode(η["model"], 𝑅)
    attr = _fieldname(η["attr"])
    val  = decodefield(typeof(mdl), attr, η["new"], 𝑅)
    setproperty!(mdl, attr, val; patchdoc = true)
    nothing
end

function _𝑑𝑒𝑐_columnspatched(η::JSDict, 𝑅::Deserializer)
    obj  = decode(η["column_source"], 𝑅)
    data = Dict{String, Vector{Pair}}(
        col => Pair[_𝑐𝑝_key(x) => _𝑐𝑝_value(y) for (x, y) ∈ lst]
        for (col, lst) ∈ η["patches"]
    )
    Model.patch!(obj.data, data)
end

function _𝑑𝑒𝑐_columnsstreamed(η::JSDict, 𝑅::Deserializer)
    mdl  = getproperty(decode(η["model"], 𝑅), η["attr"])
    data = decode(η["data"], 𝑅)
    Model.update!(mdl, data)
end

function _𝑑𝑒𝑐_columnschanged(η::JSDict, 𝑅::Deserializer)
    mdl  = getproperty(decode(η["model"], 𝑅), η["attr"])
    data = decode(η["data"], 𝑅)
    Model.stream!(mdl, data; η["rollover"])
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
    return if isempty(shape) || length(shape) == 1
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

@eval function decode(@nospecialize(η), 𝑅::Deserializer)
    if η isa _👻Simple
        return η
    elseif η isa Vector{Any}
        return [decode(i, 𝑅) for i ∈ η]
    elseif η isa JSDict
        tpe = let x = pop!(η, "type", missing)
            ismissing(x) && (x = pop!(η, "kind", missing))
            ismissing(x) ? missing : lowercase(x)
        end

        $(let expr = :(if ismissing(tpe)
                haskey(η, "id") ? _𝑑𝑒𝑐_object(η, 𝑅) : JSDict(i => decode(j, 𝑅) for (i, j) ∈ η)
            else
                decode(Val(Symbol(tpe)), η, 𝑅)
            end)
            last = expr
            for name ∈ names(@__MODULE__; all = true)
                key  = "$name"
                startswith(key, "_𝑑𝑒𝑐_") || continue
                last = last.args[end] = Expr(:elseif, :(tpe == $(key[6:end])), :($name(η, 𝑅)), last.args[end])
            end
            expr
        end)
    end
end

export deserialize!
end
using .Deserialize
