#- file generated by BokehJL's 'CodeCreator': edit at your own risk! -#

@model mutable struct Line <: iLine

    line_alpha :: Model.Percent = 1.0

    line_cap :: Model.LineCap = :butt

    line_color :: Union{Nothing, Model.Color} = "#000000"

    line_dash :: Model.DashPattern = Int64[]

    line_dash_offset :: Int64 = 0

    line_join :: Model.LineJoin = :bevel

    line_width :: Float64 = 1.0

    x :: Model.NumberSpec = "x"

    y :: Model.NumberSpec = "y"
end
export Line
glyphargs(::Type{Line}) = (:x, :y)
