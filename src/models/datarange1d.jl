#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct DataRange1d <: iDataRange1d

    bounds :: Model.Nullable{Model.MinMaxBounds} = nothing

    default_span :: Union{Float64, Dates.Period} = 2.0

    finish :: Union{Nothing, Float64, Dates.DateTime, Dates.Period} = nothing

    flipped :: Bool = false

    follow :: Model.Nullable{Model.EnumType{(:start, :end)}} = nothing

    follow_interval :: Model.Nullable{Union{Float64, Dates.Period}} = nothing

    max_interval :: Union{Nothing, Float64, Dates.Period} = nothing

    min_interval :: Union{Nothing, Float64, Dates.Period} = nothing

    names :: Vector{String} = String[]

    only_visible :: Bool = false

    range_padding :: Union{Float64, Dates.Period} = 0.1

    range_padding_units :: Model.EnumType{(:percent, :absolute)} = :percent

    renderers :: Union{Model.EnumType{(:auto,)}, Vector{iModel}}

    start :: Union{Nothing, Float64, Dates.DateTime, Dates.Period} = nothing
end