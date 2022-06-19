#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

using ..ModelTypes: iBezier, Bokeh.Models.CustomJS

@model mutable struct Bezier <: iBezier

    syncable :: Bool = true

    line_color :: Bokeh.Model.Spec{Bokeh.Model.Color} = Bokeh.Model.Unknown()

    js_property_callbacks :: Dict{Symbol, Vector{<:iCustomJS}}

    cx0 :: Bokeh.Model.Spec{Float64} = (field = "cx0",)

    tags :: Vector{Any}

    line_alpha :: Bokeh.Model.AlphaSpec = (value = 1.0,)

    y0 :: Bokeh.Model.Spec{Float64} = (field = "y0",)

    subscribed_events :: Vector{Symbol}

    line_cap :: Bokeh.Model.EnumSpec{(:butt, :round, :square)} = (value = :butt,)

    cy0 :: Bokeh.Model.Spec{Float64} = (field = "cy0",)

    cx1 :: Bokeh.Model.Spec{Float64} = (field = "cx1",)

    line_join :: Bokeh.Model.EnumSpec{(:miter, :round, :bevel)} = (value = :bevel,)

    x0 :: Bokeh.Model.Spec{Float64} = (field = "x0",)

    name :: Bokeh.Model.Nullable{String} = nothing

    line_width :: Bokeh.Model.Spec{Float64} = (value = 1.0,)

    x1 :: Bokeh.Model.Spec{Float64} = (field = "x1",)

    line_dash_offset :: Bokeh.Model.Spec{Int64} = (value = 0,)

    y1 :: Bokeh.Model.Spec{Float64} = (field = "y1",)

    cy1 :: Bokeh.Model.Spec{Float64} = (field = "cy1",)

    js_event_callbacks :: Dict{Symbol, Vector{<:iCustomJS}}

    line_dash :: Bokeh.Model.Spec{Bokeh.Model.DashPattern}
end
