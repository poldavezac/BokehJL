#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct WheelZoomTool <: iWheelZoomTool

    description :: Model.Nullable{String} = nothing

    dimensions :: Model.EnumType{(:width, :height, :both)} = :both

    maintain_focus :: Bool = true

    speed :: Float64 = 0.0016666666666666668

    zoom_on_axis :: Bool = true
end