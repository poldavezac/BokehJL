#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct Panel <: iPanel

    child :: iLayoutDOM

    closable :: Bool = false

    disabled :: Bool = false

    title :: String = ""
end