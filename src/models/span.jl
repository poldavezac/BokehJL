#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct Span <: iSpan

    coordinates :: Model.Nullable{iCoordinateMapping} = nothing

    dimension :: Model.EnumType{(:width, :height)} = :width

    group :: Model.Nullable{iRendererGroup} = nothing

    level :: Model.EnumType{(:image, :underlay, :glyph, :guide, :annotation, :overlay)} = :image

    line_alpha :: Model.Percent = 1.0

    line_cap :: Model.LineCap = :butt

    line_color :: Model.Nullable{Model.Color} = "#000000"

    line_dash :: Model.DashPattern = Int64[]

    line_dash_offset :: Int64 = 0

    line_join :: Model.LineJoin = :bevel

    line_width :: Float64 = 1.0

    location :: Model.Nullable{Float64} = nothing

    location_units :: Model.EnumType{(:screen, :data)} = :data

    render_mode :: Model.EnumType{(:canvas, :css)} = :canvas

    visible :: Bool = true

    x_range_name :: String = "default"

    y_range_name :: String = "default"
end
