#- file generated by BokehServer's 'CodeCreator': edit at your own risk! -#

@model mutable struct LegendItem <: iLegendItem

    index :: Union{Nothing, Int64} = nothing

    label :: Model.NullStringSpec = nothing

    renderers :: Vector{iGlyphRenderer} = iGlyphRenderer[]

    visible :: Bool = true
end
export LegendItem
