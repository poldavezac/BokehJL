#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct DOMDiv <: iDOMDiv

    children :: Vector{Union{iDOMNode, iLayoutDOM, String}}

    style :: Model.Nullable{Union{iStyles, Dict{String, String}}} = nothing
end