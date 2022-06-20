#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct MercatorTickFormatter <: iMercatorTickFormatter

    dimension :: Model.Nullable{Model.EnumType{(:lat, :lon)}} = nothing

    power_limit_high :: Int64 = 5

    power_limit_low :: Int64 = -3

    precision :: Union{Int64, Model.EnumType{(:auto,)}} = :auto

    use_scientific :: Bool = true
end