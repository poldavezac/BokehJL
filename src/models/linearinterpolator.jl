#- file generated by BokehJL's 'CodeCreator': edit at your own risk! -#

@model mutable struct LinearInterpolator <: iLinearInterpolator

    clip :: Bool = true

    data :: Model.Nullable{iColumnarDataSource} = nothing

    x :: Union{String, Vector{Float64}}

    y :: Union{String, Vector{Float64}}
end
