#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

using ..ModelTypes: iSelectEditor, Bokeh.Models.CustomJS

@model mutable struct SelectEditor <: iSelectEditor

    syncable :: Bool = true

    name :: Bokeh.Model.Nullable{String} = nothing

    options :: Vector{String} = String[]

    subscribed_events :: Vector{Symbol}

    js_property_callbacks :: Dict{Symbol, Vector{<:iCustomJS}}

    js_event_callbacks :: Dict{Symbol, Vector{<:iCustomJS}}

    tags :: Vector{Any}
end
