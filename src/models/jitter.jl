#- file generated by BokehServer's 'CodeCreator': edit at your own risk! -#

@model mutable struct Jitter <: iJitter

    distribution :: Model.EnumType{(:uniform, :normal)} = :uniform

    mean :: Float64 = 0.0

    range :: Union{Nothing, iRange} = nothing

    width :: Float64 = 1.0
end
export Jitter
