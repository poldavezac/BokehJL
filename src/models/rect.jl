#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct Rect <: iRect

    angle :: Model.AngleSpec = 0.0

    angle_units :: Model.EnumType{(:deg, :rad, :grad, :turn)} = :rad

    dilate :: Bool = false

    fill_alpha :: Model.AlphaSpec = 1.0

    fill_color :: Model.ColorSpec = "#808080"

    hatch_alpha :: Model.AlphaSpec = 1.0

    hatch_color :: Model.ColorSpec = "#000000"

    hatch_extra :: Dict{String, iTexture} = Dict{String, iTexture}()

    hatch_pattern :: Model.HatchPatternSpec = :blank

    hatch_scale :: Model.NumberSpec = 12.0

    hatch_weight :: Model.NumberSpec = 1.0

    height :: Model.NullDistanceSpec = "height"

    height_units :: Model.EnumType{(:screen, :data)} = :data

    line_alpha :: Model.AlphaSpec = 1.0

    line_cap :: Model.LineCapSpec = :butt

    line_color :: Model.ColorSpec = "#000000"

    line_dash :: Model.DashPatternSpec = Int64[]

    line_dash_offset :: Model.IntSpec = 0

    line_join :: Model.LineJoinSpec = :bevel

    line_width :: Model.NumberSpec = 1.0

    width :: Model.NullDistanceSpec = "width"

    width_units :: Model.EnumType{(:screen, :data)} = :data

    x :: Model.NumberSpec = "x"

    y :: Model.NumberSpec = "y"
end
glyphargs(::Type{Rect}) = (:x, :y, :width, :height, :angle, :dilate)
