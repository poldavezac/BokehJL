#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct HexTile <: iHexTile

    aspect_scale :: Float64 = 1.0

    fill_alpha :: Model.AlphaSpec = 1.0

    fill_color :: Model.ColorSpec = "#808080"

    hatch_alpha :: Model.AlphaSpec = 1.0

    hatch_color :: Model.ColorSpec = "#000000"

    hatch_extra :: Dict{String, iTexture} = Dict{String, iTexture}()

    hatch_pattern :: Model.HatchPatternSpec = :blank

    hatch_scale :: Model.NumberSpec = 12.0

    hatch_weight :: Model.NumberSpec = 1.0

    line_alpha :: Model.AlphaSpec = 1.0

    line_cap :: Model.LineCapSpec = :butt

    line_color :: Model.ColorSpec = nothing

    line_dash :: Model.DashPatternSpec = Int64[]

    line_dash_offset :: Model.IntSpec = 0

    line_join :: Model.LineJoinSpec = :bevel

    line_width :: Model.NumberSpec = 1.0

    orientation :: String = "pointytop"

    q :: Model.NumberSpec = "q"

    r :: Model.NumberSpec = "r"

    scale :: Model.NumberSpec = 1.0

    size :: Float64 = 1.0
end
glyphargs(::Type{HexTile}) = (:q, :r)
