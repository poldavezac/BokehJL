#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

using ..ModelTypes: iFileInput, Bokeh.Models.CustomJS

@model mutable struct FileInput <: iFileInput

    syncable :: Bool = true

    filename :: Bokeh.Model.ReadOnly{Union{String, Vector{String}}} = ""

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

    subscribed_events :: Vector{Symbol}

    align :: Union{Tuple{Bokeh.Model.EnumType{(:start, :end, :center)}, Bokeh.Model.EnumType{(:start, :end, :center)}}, Bokeh.Model.EnumType{(:start, :center, :end)}} = :start

    max_width :: Bokeh.Model.Nullable{Bokeh.Model.NonNegativeInt} = nothing

    max_height :: Bokeh.Model.Nullable{Bokeh.Model.NonNegativeInt} = nothing

    default_size :: Int64 = 300

    name :: Bokeh.Model.Nullable{String} = nothing

    background :: Bokeh.Model.Nullable{Bokeh.Model.Color} = nothing

    multiple :: Bool = false

    aspect_ratio :: Union{Nothing, Float64, Bokeh.Model.EnumType{(:auto,)}} = nothing

    accept :: String = ""

    value :: Bokeh.Model.ReadOnly{Union{String, Vector{String}}} = ""

    margin :: Bokeh.Model.Nullable{NTuple{4, Int64}} = (0, 0, 0, 0)

    js_event_callbacks :: Dict{Symbol, Vector{<:iCustomJS}}

    mime_type :: Bokeh.Model.ReadOnly{Union{String, Vector{String}}} = ""

    width :: Bokeh.Model.Nullable{Bokeh.Model.NonNegativeInt} = nothing
end
