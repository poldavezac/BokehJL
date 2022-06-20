#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct ToolbarPanel <: iToolbarPanel

    coordinates :: Model.Nullable{iCoordinateMapping} = nothing

    group :: Model.Nullable{iRendererGroup} = nothing

    level :: Model.EnumType{(:image, :underlay, :glyph, :guide, :annotation, :overlay)} = :image

    toolbar :: iToolbar

    visible :: Bool = true

    x_range_name :: String = "default"

    y_range_name :: String = "default"
end