#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct CDSView <: iCDSView

    filters :: Vector{iFilter} = iFilter[]

    source :: iColumnarDataSource
end
