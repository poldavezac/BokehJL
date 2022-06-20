#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct BoxSelectTool <: iBoxSelectTool

    description :: Model.Nullable{String} = nothing

    dimensions :: Model.EnumType{(:width, :height, :both)} = :both

    mode :: Model.EnumType{(:replace, :append, :intersect, :subtract)} = :replace

    names :: Vector{String} = String[]

    origin :: Model.EnumType{(:corner, :center)} = :corner

    overlay :: iBoxAnnotation = BoxAnnotation()

    renderers :: Union{Model.EnumType{(:auto,)}, Vector{iDataRenderer}} = :auto

    select_every_mousemove :: Bool = false
end