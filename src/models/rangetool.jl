#- file generated by BokehJL's 'CodeCreator': edit at your own risk! -#

@model mutable struct RangeTool <: iRangeTool

    description :: Union{Nothing, String} = nothing

    overlay :: iBoxAnnotation = BoxAnnotation()

    x_interaction :: Bool = true

    x_range :: Union{Nothing, iRange1d} = nothing

    y_interaction :: Bool = true

    y_range :: Union{Nothing, iRange1d} = nothing
end
export RangeTool
