#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct FuncTickFormatter <: iFuncTickFormatter

    args :: Dict{String, Any}

    code :: String = ""
end