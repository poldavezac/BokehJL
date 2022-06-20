#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct CrosshairTool <: iCrosshairTool

    description :: Model.Nullable{String} = nothing

    dimensions :: Model.EnumType{(:width, :height, :both)} = :both

    line_alpha :: Model.Percent = 1.0

    line_color :: Model.Color = "rgb(0,0,0)"

    line_width :: Float64 = 1.0

    toggleable :: Bool = true
end