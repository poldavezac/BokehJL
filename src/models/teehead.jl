#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct TeeHead <: iTeeHead

    line_alpha :: Model.AlphaSpec = 1.0

    line_cap :: Model.LineCapSpec = :butt

    line_color :: Model.ColorSpec = "#000000"

    line_dash :: Model.DashPatternSpec = Int64[]

    line_dash_offset :: Model.IntSpec = 0

    line_join :: Model.LineJoinSpec = :bevel

    line_width :: Model.NumberSpec = 1.0

    size :: Model.NumberSpec = 25.0
end
