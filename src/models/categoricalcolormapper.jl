#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct CategoricalColorMapper <: iCategoricalColorMapper

    factors :: Union{Vector{String}, Vector{Tuple{String, String}}, Vector{Tuple{String, String, String}}}

    finish :: Model.Nullable{Int64} = nothing

    nan_color :: Model.Color = "rgb(128,128,128)"

    palette :: Vector{Model.Color}

    start :: Int64 = 0
end