#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct PolyAnnotation <: iPolyAnnotation

    coordinates :: Model.Nullable{iCoordinateMapping} = nothing

    fill_alpha :: Model.Percent = 0.4

    fill_color :: Model.Nullable{Model.Color} = "#FFF9BA"

    group :: Model.Nullable{iRendererGroup} = nothing

    hatch_alpha :: Model.Percent = 1.0

    hatch_color :: Model.Nullable{Model.Color} = "#000000"

    hatch_extra :: Dict{String, iTexture} = Dict{String, iTexture}()

    hatch_pattern :: Model.Nullable{String} = nothing

    hatch_scale :: Model.Size = 12.0

    hatch_weight :: Model.Size = 1.0

    level :: Model.EnumType{(:image, :underlay, :glyph, :guide, :annotation, :overlay)} = :image

    line_alpha :: Model.Percent = 0.3

    line_cap :: Model.LineCap = :butt

    line_color :: Model.Nullable{Model.Color} = "#CCCCCC"

    line_dash :: Model.DashPattern = Int64[]

    line_dash_offset :: Int64 = 0

    line_join :: Model.LineJoin = :bevel

    line_width :: Float64 = 1.0

    visible :: Bool = true

    x_range_name :: String = "default"

    xs :: Vector{Float64} = Float64[]

    xs_units :: Model.EnumType{(:screen, :data)} = :data

    y_range_name :: String = "default"

    ys :: Vector{Float64} = Float64[]

    ys_units :: Model.EnumType{(:screen, :data)} = :data
end
