#- file generated by BokehServer's 'CodeCreator': edit at your own risk! -#

@model mutable struct DOMDiv <: iDOMDiv

    children :: Vector{Union{iDOMNode, iLayoutDOM, String}} = Union{iDOMNode, iLayoutDOM, String}[]

    style :: Union{Nothing, iStyles, Dict{String, String}} = nothing
end
export DOMDiv
