#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct Title <: iTitle

    align :: Model.EnumType{(:left, :right, :center)} = :left

    background_fill_alpha :: Model.Percent = 1.0

    background_fill_color :: Model.Nullable{Model.Color} = "rgb(128,128,128)"

    border_line_alpha :: Model.Percent = 1.0

    border_line_cap :: Model.EnumType{(:butt, :round, :square)} = :butt

    border_line_color :: Model.Nullable{Model.Color} = "rgb(0,0,0)"

    border_line_dash :: Model.DashPattern

    border_line_dash_offset :: Int64 = 0

    border_line_join :: Model.EnumType{(:miter, :round, :bevel)} = :bevel

    border_line_width :: Float64 = 1.0

    coordinates :: Model.Nullable{iCoordinateMapping} = nothing

    group :: Model.Nullable{iRendererGroup} = nothing

    level :: Model.EnumType{(:image, :underlay, :glyph, :guide, :annotation, :overlay)} = :image

    offset :: Float64 = 0.0

    render_mode :: Model.EnumType{(:canvas, :css)} = :canvas

    standoff :: Float64 = 10.0

    text :: String = ""

    text_alpha :: Model.Percent = 1.0

    text_color :: Model.Color = "rgb(68,68,68)"

    text_font :: String = "helvetica"

    text_font_size :: String = "13px"

    text_font_style :: Model.EnumType{(:normal, :italic, :bold, Symbol("bold italic"))} = :bold

    text_line_height :: Float64 = 1.0

    vertical_align :: Model.EnumType{(:top, :middle, :bottom)} = :bottom

    visible :: Bool = true

    x_range_name :: String = "default"

    y_range_name :: String = "default"
end