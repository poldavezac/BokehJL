#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct Slider <: iSlider

    align :: Union{Tuple{Model.EnumType{(:start, :center, :end)}, Model.EnumType{(:start, :center, :end)}}, Model.EnumType{(:start, :center, :end)}} = :start

    aspect_ratio :: Union{Nothing, Float64, Model.EnumType{(:auto,)}} = nothing

    background :: Model.Nullable{Model.Color} = nothing

    bar_color :: Model.Color = "#E6E6E6"

    css_classes :: Vector{String} = String[]

    default_size :: Int64 = 300

    direction :: Model.EnumType{(:ltr, :rtl)} = :ltr

    disabled :: Bool = false

    finish :: Float64

    format :: Union{iTickFormatter, String} = "0[.]00"

    height :: Model.Nullable{Model.NonNegativeInt} = nothing

    height_policy :: Model.EnumType{(:auto, :fixed, :fit, :min, :max)} = :auto

    margin :: Model.Nullable{NTuple{4, Int64}} = (0, 0, 0, 0)

    max_height :: Model.Nullable{Model.NonNegativeInt} = nothing

    max_width :: Model.Nullable{Model.NonNegativeInt} = nothing

    min_height :: Model.Nullable{Model.NonNegativeInt} = nothing

    min_width :: Model.Nullable{Model.NonNegativeInt} = nothing

    orientation :: Model.EnumType{(:horizontal, :vertical)} = :horizontal

    show_value :: Bool = true

    sizing_mode :: Model.Nullable{Model.EnumType{(:stretch_width, :stretch_height, :stretch_both, :scale_width, :scale_height, :scale_both, :fixed)}} = nothing

    start :: Float64

    step :: Float64 = 1.0

    title :: Model.Nullable{String} = ""

    tooltips :: Bool = true

    value :: Float64

    value_throttled :: Model.ReadOnly{Float64}

    visible :: Bool = true

    width :: Model.Nullable{Model.NonNegativeInt} = nothing

    width_policy :: Model.EnumType{(:auto, :fixed, :fit, :min, :max)} = :auto
end
