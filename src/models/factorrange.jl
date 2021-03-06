#- file generated by BokehServer's 'CodeCreator': edit at your own risk! -#

@model mutable struct FactorRange <: iFactorRange

    bounds :: Union{Nothing, Model.MinMaxBounds} = nothing

    factor_padding :: Float64 = 0.0

    factors :: Union{Vector{String}, Vector{Tuple{String, String}}, Vector{Tuple{String, String, String}}} = String[]

    finish :: Model.ReadOnly{Float64} = 0.0

    group_padding :: Float64 = 1.4

    max_interval :: Union{Nothing, Float64} = nothing

    min_interval :: Union{Nothing, Float64} = nothing

    range_padding :: Float64 = 0.0

    range_padding_units :: Model.EnumType{(:percent, :absolute)} = :percent

    start :: Model.ReadOnly{Float64} = 0.0

    subgroup_padding :: Float64 = 0.8
end
export FactorRange
