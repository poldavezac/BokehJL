#- file generated by BokehServer's 'CodeCreator': edit at your own risk! -#

@model mutable struct Spinner <: iSpinner

    align :: Union{Tuple{Model.EnumType{(:start, :center, :end)}, Model.EnumType{(:start, :center, :end)}}, Model.EnumType{(:start, :center, :end)}} = :start

    aspect_ratio :: Union{Nothing, Float64, Model.EnumType{(:auto,)}} = nothing

    background :: Union{Nothing, Model.Color} = nothing

    css_classes :: Vector{String} = String[]

    default_size :: Int64 = 300

    disabled :: Bool = false

    format :: Union{Nothing, iTickFormatter, String} = nothing

    height :: Union{Nothing, Model.NonNegativeInt} = nothing

    height_policy :: Model.EnumType{(:auto, :fixed, :fit, :min, :max)} = :auto

    high :: Union{Nothing, Float64, Int64} = nothing

    low :: Union{Nothing, Float64, Int64} = nothing

    margin :: Union{Nothing, NTuple{4, Int64}} = (0, 0, 0, 0)

    max_height :: Union{Nothing, Model.NonNegativeInt} = nothing

    max_width :: Union{Nothing, Model.NonNegativeInt} = nothing

    min_height :: Union{Nothing, Model.NonNegativeInt} = nothing

    min_width :: Union{Nothing, Model.NonNegativeInt} = nothing

    mode :: Model.EnumType{(:int, :float)} = :float

    page_step_multiplier :: Model.Interval{0.0, Inf} = 10.0

    placeholder :: String = ""

    sizing_mode :: Union{Nothing, Model.EnumType{(:stretch_width, :stretch_height, :stretch_both, :scale_width, :scale_height, :scale_both, :fixed)}} = nothing

    step :: Model.Interval{1.0e-16, Inf} = 1.0

    title :: String = ""

    value :: Union{Nothing, Float64, Int64} = nothing

    value_throttled :: Model.ReadOnly{Union{Nothing, Float64, Int64}} = nothing

    visible :: Bool = true

    wheel_wait :: Union{Float64, Int64} = 100

    width :: Union{Nothing, Model.NonNegativeInt} = nothing

    width_policy :: Model.EnumType{(:auto, :fixed, :fit, :min, :max)} = :auto
end
export Spinner
