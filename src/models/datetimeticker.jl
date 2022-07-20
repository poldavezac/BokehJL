#- file generated by BokehJL's 'CodeCreator': edit at your own risk! -#

@model mutable struct DatetimeTicker <: iDatetimeTicker

    desired_num_ticks :: Int64 = 6

    num_minor_ticks :: Int64 = 0

    tickers :: Vector{iTicker} = [AdaptiveTicker(; max_interval = 500.0, mantissas = Any[1, 2, 5], num_minor_ticks = 0), AdaptiveTicker(; base = 60, min_interval = 1000.0, max_interval = 1.8e6, mantissas = Any[1, 2, 5, 10, 15, 20, 30], num_minor_ticks = 0), AdaptiveTicker(; base = 24, min_interval = 3.6e6, max_interval = 4.32e7, mantissas = Any[1, 2, 4, 6, 8, 12], num_minor_ticks = 0), DaysTicker(; days = Any[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31]), DaysTicker(; days = Any[1, 4, 7, 10, 13, 16, 19, 22, 25, 28]), DaysTicker(; days = Any[1, 8, 15, 22]), DaysTicker(; days = Any[1, 15]), MonthsTicker(; months = Any[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]), MonthsTicker(; months = Any[0, 2, 4, 6, 8, 10]), MonthsTicker(; months = Any[0, 4, 8]), MonthsTicker(; months = Any[0, 6]), YearsTicker()]
end
export DatetimeTicker
