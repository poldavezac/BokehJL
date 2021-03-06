#- file generated by BokehServer's 'CodeCreator': edit at your own risk! -#

@model mutable struct EqHistColorMapper <: iEqHistColorMapper

    bins :: Int64 = 65536

    domain :: Vector{Tuple{iGlyphRenderer, Union{String, Vector{String}}}} = Tuple{iGlyphRenderer, Union{String, Vector{String}}}[]

    high :: Union{Nothing, Float64} = nothing

    high_color :: Union{Nothing, Model.Color} = nothing

    low :: Union{Nothing, Float64} = nothing

    low_color :: Union{Nothing, Model.Color} = nothing

    nan_color :: Model.Color = "#808080"

    palette :: Vector{Model.Color}

    rescale_discrete_levels :: Bool = false
end
export EqHistColorMapper
