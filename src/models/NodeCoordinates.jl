#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

using ..ModelTypes: iNodeCoordinates, Bokeh.Models.LayoutProvider, Bokeh.Models.CustomJS

@model mutable struct NodeCoordinates <: iNodeCoordinates

    syncable :: Bool = true

    name :: Bokeh.Model.Nullable{String} = nothing

    subscribed_events :: Vector{Symbol}

    layout :: iLayoutProvider

    js_property_callbacks :: Dict{Symbol, Vector{<:iCustomJS}}

    js_event_callbacks :: Dict{Symbol, Vector{<:iCustomJS}}

    tags :: Vector{Any}
end
