#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

using ..ModelTypes: iImage, Bokeh.Models.ColorMapper, Bokeh.Models.CustomJS

@model mutable struct Image <: iImage

    syncable :: Bool = true

    global_alpha :: Bokeh.Model.Spec{Float64} = (value = 1.0,)

    js_property_callbacks :: Dict{Symbol, Vector{<:iCustomJS}}

    dw :: Bokeh.Model.DistanceSpec = (field = "dw",)

    tags :: Vector{Any}

    subscribed_events :: Vector{Symbol}

    x :: Bokeh.Model.Spec{Float64} = (field = "x",)

    dilate :: Bool = false

    name :: Bokeh.Model.Nullable{String} = nothing

    dh_units :: Bokeh.Model.EnumType{(:screen, :data)} = :data

    image :: Bokeh.Model.Spec{Float64} = (field = "image",)

    color_mapper :: iColorMapper = LinearColorMapper()

    dw_units :: Bokeh.Model.EnumType{(:screen, :data)} = :data

    dh :: Bokeh.Model.DistanceSpec = (field = "dh",)

    y :: Bokeh.Model.Spec{Float64} = (field = "y",)

    js_event_callbacks :: Dict{Symbol, Vector{<:iCustomJS}}
end
