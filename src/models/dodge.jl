#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct Dodge <: iDodge

    range :: Model.Nullable{iRange} = nothing

    value :: Float64 = 0.0
end