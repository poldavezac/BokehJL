#- file generated by BokehServer's 'CodeCreator': edit at your own risk! -#

@model mutable struct ProxyToolbar <: iProxyToolbar

    autohide :: Bool = false

    logo :: Union{Nothing, Model.EnumType{(:normal, :grey)}} = :normal

    toolbars :: Vector{iToolbar} = iToolbar[]

    tools :: Vector{iTool} = iTool[]
end
export ProxyToolbar
