#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

using ..ModelTypes: iColorPicker, Bokeh.Models.CustomJS

@model mutable struct ColorPicker <: iColorPicker

    syncable :: Bool = true

    min_height :: Bokeh.Model.Nullable{Bokeh.Model.NonNegativeInt} = nothing

    css_classes :: Vector{String} = String[]

    visible :: Bool = true

    height :: Bokeh.Model.Nullable{Bokeh.Model.NonNegativeInt} = nothing

    height_policy :: Bokeh.Model.EnumType{(:auto, :fixed, :fit, :min, :max)} = :auto

    js_property_callbacks :: Dict{Symbol, Vector{<:iCustomJS}}

    width_policy :: Bokeh.Model.EnumType{(:auto, :fixed, :fit, :min, :max)} = :auto

    disabled :: Bool = false

    tags :: Vector{Any}

    min_width :: Bokeh.Model.Nullable{Bokeh.Model.NonNegativeInt} = nothing

    sizing_mode :: Bokeh.Model.Nullable{Bokeh.Model.EnumType{(:stretch_width, :scale_both, :scale_width, :stretch_height, :stretch_both, :fixed, :scale_height)}} = nothing

    title :: String = ""

    subscribed_events :: Vector{Symbol}

    align :: Union{Tuple{Bokeh.Model.EnumType{(:start, :end, :center)}, Bokeh.Model.EnumType{(:start, :end, :center)}}, Bokeh.Model.EnumType{(:start, :center, :end)}} = :start

    max_width :: Bokeh.Model.Nullable{Bokeh.Model.NonNegativeInt} = nothing

    max_height :: Bokeh.Model.Nullable{Bokeh.Model.NonNegativeInt} = nothing

    default_size :: Int64 = 300

    name :: Bokeh.Model.Nullable{String} = nothing

    background :: Bokeh.Model.Nullable{Bokeh.Model.Color} = nothing

    aspect_ratio :: Union{Nothing, Float64, Bokeh.Model.EnumType{(:auto,)}} = nothing

    color :: Bokeh.Model.ColorHex = Bokeh.Model.Unknown()

    margin :: Bokeh.Model.Nullable{NTuple{4, Int64}} = (0, 0, 0, 0)

    js_event_callbacks :: Dict{Symbol, Vector{<:iCustomJS}}

    width :: Bokeh.Model.Nullable{Bokeh.Model.NonNegativeInt} = nothing
end
