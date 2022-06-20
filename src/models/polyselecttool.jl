#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct PolySelectTool <: iPolySelectTool

    description :: Model.Nullable{String} = nothing

    mode :: Model.EnumType{(:replace, :append, :intersect, :subtract)} = :replace

    names :: Vector{String} = String[]

    overlay :: iPolyAnnotation = PolyAnnotation()

    renderers :: Union{Model.EnumType{(:auto,)}, Vector{iDataRenderer}} = :auto
end