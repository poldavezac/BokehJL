#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct DaysTicker <: iDaysTicker

    days :: Vector{Int64} = Int64[]

    desired_num_ticks :: Int64 = 6

    interval :: Float64

    num_minor_ticks :: Int64 = 5
end