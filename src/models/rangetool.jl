#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct RangeTool <: iRangeTool

    description :: Model.Nullable{String} = nothing

    overlay :: iBoxAnnotation = BoxAnnotation()

    x_interaction :: Bool = true

    x_range :: Model.Nullable{iRange1d} = nothing

    y_interaction :: Bool = true

    y_range :: Model.Nullable{iRange1d} = nothing
end