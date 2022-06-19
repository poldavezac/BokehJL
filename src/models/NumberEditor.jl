#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

using ..ModelTypes: iNumberEditor, Bokeh.Models.CustomJS

@model mutable struct NumberEditor <: iNumberEditor

    syncable :: Bool = true

    step :: Float64 = 0.01

    name :: Bokeh.Model.Nullable{String} = nothing

    subscribed_events :: Vector{Symbol}

    js_property_callbacks :: Dict{Symbol, Vector{<:iCustomJS}}

    js_event_callbacks :: Dict{Symbol, Vector{<:iCustomJS}}

    tags :: Vector{Any}
end
