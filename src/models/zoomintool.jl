#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct ZoomInTool <: iZoomInTool

    description :: Model.Nullable{String} = nothing

    dimensions :: Model.EnumType{(:width, :height, :both)} = :both

    factor :: Model.Percent = 0.1
end