#- file generated by BokehJL's 'CodeCreator': edit at your own risk! -#

@model mutable struct FixedTicker <: iFixedTicker

    desired_num_ticks :: Int64 = 6

    minor_ticks :: Vector{Float64} = Float64[]

    num_minor_ticks :: Int64 = 5

    ticks :: Vector{Float64} = Float64[]
end
export FixedTicker
