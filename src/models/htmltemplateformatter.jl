#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct HTMLTemplateFormatter <: iHTMLTemplateFormatter

    template :: String = "<%= value %>"
end