#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

using ..ModelTypes: iVArea, Bokeh.Models.Texture, Bokeh.Models.CustomJS

@model mutable struct VArea <: iVArea

    syncable :: Bool = true

    hatch_extra :: Dict{String, iTexture}

    hatch_scale :: Bokeh.Model.Spec{Float64} = (value = 12.0,)

    hatch_color :: Bokeh.Model.Spec{Bokeh.Model.Color} = Bokeh.Model.Unknown()

    js_property_callbacks :: Dict{Symbol, Vector{<:iCustomJS}}

    tags :: Vector{Any}

    fill_alpha :: Bokeh.Model.Percent = 1.0

    hatch_pattern :: Bokeh.Model.EnumSpec{(:blank, :dot, :ring, :horizontal_line, :vertical_line, :cross, :horizontal_dash, :vertical_dash, :spiral, :right_diagonal_line, :left_diagonal_line, :diagonal_cross, :right_diagonal_dash, :left_diagonal_dash, :horizontal_wave, :vertical_wave, :criss_cross)} = nothing

    subscribed_events :: Vector{Symbol}

    hatch_alpha :: Bokeh.Model.AlphaSpec = (value = 1.0,)

    x :: Bokeh.Model.Spec{Float64} = (field = "x",)

    name :: Bokeh.Model.Nullable{String} = nothing

    fill_color :: Bokeh.Model.Nullable{Bokeh.Model.Color} = "rgb(128,128,128)"

    hatch_weight :: Bokeh.Model.Spec{Float64} = (value = 1.0,)

    y1 :: Bokeh.Model.Spec{Float64} = (field = "y1",)

    js_event_callbacks :: Dict{Symbol, Vector{<:iCustomJS}}

    y2 :: Bokeh.Model.Spec{Float64} = (field = "y2",)
end
