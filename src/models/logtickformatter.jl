#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct LogTickFormatter <: iLogTickFormatter

    min_exponent :: Int64 = 0

    ticker :: Model.Nullable{iTicker} = nothing
end