#- file generated by BokehJL's 'CodeCreator': edit at your own risk! -#

@model mutable struct MultiLine <: iMultiLine

    line_alpha :: Model.AlphaSpec = 1.0

    line_cap :: Model.LineCapSpec = :butt

    line_color :: Model.ColorSpec = "#000000"

    line_dash :: Model.DashPatternSpec = Int64[]

    line_dash_offset :: Model.IntSpec = 0

    line_join :: Model.LineJoinSpec = :bevel

    line_width :: Model.NumberSpec = 1.0

    xs :: Model.NumberSpec = "xs"

    ys :: Model.NumberSpec = "ys"
end
export MultiLine
glyphargs(::Type{MultiLine}) = (:xs, :ys)
