module Protocol
using ..Bokeh
using ..AbstractTypes
using ..Events
using ..Model
using ..Documents
using JSON

const Buffers = Dict{String, Vector{Int8}}

include("protocol/messages.jl")
include("protocol/serialize.jl")
include("protocol/patchdoc/send.jl")
include("protocol/patchdoc/receive.jl")
include("protocol/pushdoc.jl")

for (tpe, func) ∈ (msg"PULL-DOC-REPLY,PUSH-DOC" => :pushdoc!, msg"PATCH-DOC" => :patchdoc!)
    @eval function onreceive!(μ::$tpe, 𝐷::iDocument, λ::Events.iEventList, a...)
        patchdoc(()->$func(𝐷, μ.contents), 𝐷, λ, a...)
    end
end
end

using .Protocol
