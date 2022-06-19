#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

using ..ModelTypes: iPolySelectTool, Bokeh.Models.PolyAnnotation, Bokeh.Models.DataRenderer, Bokeh.Models.CustomJS

@model mutable struct PolySelectTool <: iPolySelectTool

    syncable :: Bool = true

    description :: Bokeh.Model.Nullable{String} = nothing

    renderers :: Union{Bokeh.Model.EnumType{(:auto,)}, Vector{<:iDataRenderer}} = :auto

    js_property_callbacks :: Dict{Symbol, Vector{<:iCustomJS}}

    tags :: Vector{Any}

    overlay :: iPolyAnnotation = PolyAnnotation()

    subscribed_events :: Vector{Symbol}

    mode :: Bokeh.Model.EnumType{(:append, :replace, :subtract, :intersect)} = :replace

    name :: Bokeh.Model.Nullable{String} = nothing

    names :: Vector{String} = String[]

    js_event_callbacks :: Dict{Symbol, Vector{<:iCustomJS}}
end
