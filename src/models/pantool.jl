#- file generated by BokehServer's 'CodeCreator': edit at your own risk! -#

@model mutable struct PanTool <: iPanTool

    description :: Union{Nothing, String} = nothing

    dimensions :: Model.EnumType{(:width, :height, :both)} = :both
end
export PanTool
