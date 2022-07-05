module Layouts
using ...Model
using ...Models
const SizingModeType  = Model.EnumType{(:stretch_width, :stretch_height, :stretch_both, :scale_width, :scale_height, :scale_both, :fixed)}
const LocationType    = Model.EnumType{(:above, :left, :right, :below)}
const LayoutEntry     = Tuple{<:T, Int, Int, Int, Int} where {T}
const LayoutDOMEntry  = LayoutEntry{Models.iLayoutDOM}
const LayoutPlotEntry = LayoutEntry{Models.iPlot}

Base.adjoint(x::Models.iLayoutDOM) = x

"""
    layout(
        children::AbstractVector{<:Models.iLayoutDOM};
        nrow  :: Union{Int, Nothing} = nothing,
        ncols :: Union{Int, Nothing} = nothing,
        kwa...
    )
Conveniently create a grid of layoutable objects.

Grids are created by using ``GridBox`` model. This gives the most control over
the layout of a grid, but is also tedious and may result in unreadable code in
practical applications. ``grid()`` function remedies this by reducing the level
of control, but in turn providing a more convenient API.

Supported patterns:

1. Nested arrays of layoutable objects. Assumes vectors are for rows, 1xN
   matrixes, are for columns. NxM matrixes are viewed as
   a vector of rows.

   julia> grid([p1, [[p2, p3]', p4]'])
   GridBox(children=[
       (p1, 0, 0, 1, 2),
       (p2, 1, 0, 1, 1),
       (p3, 2, 0, 1, 1),
       (p4, 1, 1, 2, 1),
   ])

   ** warning ** The adjoint operator `'` is recursive. A non-recursive code
   would be `[p1, permutedims([[p2, p3], p4])]`.
   

3. Flat list of layoutable objects. This requires ``nrows`` and/or ``ncols`` to
   be set. The input list will be rearranged into a 2D array accordingly. One
   can use ``None`` for padding purpose.

   julia> grid([p1, p2, p3, p4], ncols=2)
   GridBox(children=[
       (p1, 0, 0, 1, 1),
       (p2, 0, 1, 1, 1),
       (p3, 1, 0, 1, 1),
       (p4, 1, 1, 1, 1),
   ])

"""
function layout(
        children::AbstractVector{<:Union{Nothing, Models.iLayoutDOM}};
        nrows :: Union{Int, Nothing} = nothing,
        ncols :: Union{Int, Nothing} = nothing,
        kwa...
)
    return if isnothing(nrows) && isnothing(ncols)
        invoke(layout, Tuple{AbstractArray}, children; kwa...)
    else
        N = length(children)
        isnothing(ncols) && (ncols = convert(Int, ceil(N/nrows)))
        layout([(@view children[i:min(N, i+ncols-1)])' for i ∈ 1:ncols:N]; kwa...)
    end
end

layout(child::Models.iLayoutDOM) = child

function layout(items::AbstractArray; kwa...)
    entries  = let children = filter!(!isnothing∘first, _👻flatten(items).items)
        T = all(i.layout isa Models.iPlot for i ∈ children) ? LayoutPlotEntry : LayoutDOMEntry
        T[(i.layout, i.r0, i.c0, i.r1 - i.r0, i.c1 - i.c0) for i ∈ children]
    end
    return layout(entries; kwa...)
end


"""
    layout(
        children         :: AbstractVector{<:LayoutPlotEntry};
        sizing_mode      :: Union{Nothing, SizingModeType} = :fixed,
        toolbar_location :: Union{Nothing, LocationType}   = :above,
        width            :: Union{Nothing, Int}            = nothing,
        height           :: Union{Nothing, Int}            = nothing,
        toolbar_options  :: Any                            = (;)
    )

Create a plot layout.

Keywords:

* sizing_mode: the sizing mode for each child, which is left untouched if `nothing` is given.
* toolbar_location: the merged toolbar position. Use `nothing` to remove it
* width: each plot width,
* height: each plot height,
* toolbar_options: toolbar options to use for creating the merged toolbar
"""
function layout(
        children::AbstractVector{<:LayoutPlotEntry};
        sizing_mode      :: Union{Nothing, Symbol} = :fixed,
        toolbar_location :: Union{Nothing, Symbol} = :above,
        width            :: Union{Nothing, Int}    = nothing,
        height           :: Union{Nothing, Int}    = nothing,
        toolbar_options  :: Any                    = (;),
        dotrigger        :: Bool                   = true,
)
    grid = invoke(layout, Tuple{AbstractVector{<:LayoutDOMEntry}}, children; sizing_mode, width, height, dotrigger)
    isnothing(toolbar_location) && return grid

    @assert toolbar_location ∈ LocationType

    for itm ∈ children
        setproperty!(first(itm), :toolbar_location, nothing; dotrigger)
    end

    toolbar  = let toolbars = getproperty.(first.(children), :toolbar)
        tools = collect(Iterators.flatten(i.tools for i ∈ toolbars))
        proxy = Models.ProxyToolbar(; toolbars, tools, toolbar_options...)
        Models.ToolbarBox(; toolbar = proxy, toolbar_location)
    end

    return (toolbar_location ∈ (:above, :below) ? Models.Column : Models.Row)(;
        children = (toolbar_location ∈ (:left, :above) ? [toolbar, grid] : [grid, toolbar]),
        sizing_mode
    )
end

"""
    layout(
        children    :: AbstractVector{<:LayoutDOMEntry};
        sizing_mode :: Union{Nothing, SizingModeType} = nothing,
        width       :: Union{Nothing, Int}            = nothing,
        height      :: Union{Nothing, Int}            = nothing,
    )

create a layout

Keywords:

* sizing_mode: the sizing mode for each child, which is left untouched if `nothing` is given.
* width: each item width,
* height: each item height,
"""
function layout(
        children    :: AbstractVector{<:LayoutDOMEntry};
        sizing_mode :: Union{Nothing, Symbol} = nothing,
        width       :: Union{Nothing, Int}    = nothing,
        height      :: Union{Nothing, Int}    = nothing,
        dotrigger   :: Bool                   = true,
)
    @assert isnothing(sizing_mode) || sizing_mode ∈ SizingModeType
    for entry ∈ children
        itm = first(entry)
        isnothing(width)  || setproperty(itm, :width, width; dotrigger)
        isnothing(height) || setproperty(itm, :height, height; dotrigger)
        (
            isnothing(sizing_mode)      ||
            !isnothing(itm.sizing_mode) ||
            itm.width_policy != :auto   ||
            itm.height_policy != :auto
        ) && setproperty!(itm, :sizing_mode, sizing_mode; dotrigger)
    end
    return Models.GridBox(; children, sizing_mode)
end

function layout(children::AbstractVector{<:Tuple{<:Models.iLayoutDOM, Int, Int}}; kwa)
    T = all(Base.Fix2(isa, Models.iPlot)∘first, children) ? Models.iPlot : Models.iLayoutDOM
    return layout(LayoutEntry{T}[(i..., 1, 1) for i ∈ items]; kwa...)
end

const _👻Item = @NamedTuple{layout::Union{Nothing, Models.iLayoutDOM}, r0::Int, c0::Int, r1::Int, c1::Int}
const _👻Grid = @NamedTuple{nrows::Int, ncols::Int, items::Vector{_👻Item}}

_👻nonempty(child::_👻Grid) = child.nrows != 0 && child.ncols != 0

_👻flatten(λ::Models.iLayoutDOM) = _👻Grid((1, 1, [_👻Item((λ, 0, 0, 1, 1))]))

function _👻flatten(λ::AbstractVector)
    children = filter!(_👻nonempty, _👻flatten.(λ))
    return if isempty(children)
        _👻Grid((0, 0, _👻Item[]))
    elseif length(children) ≡ 1
        _👻Grid((1, 1, _👻Item[_👻Item((children[1], 0, 0, 1, 1))]))
    else
        nrows = sum(child.nrows for child in children)
        ncols = lcm((child.ncols for child in children)...)

        items  = _👻Item[]
        offset = 0
        for child in children
            factor = ncols÷child.ncols

            for i in child.items
                push!(items, _👻Item((i.layout, i.r0 + offset, factor*i.c0, i.r1 + offset, factor*i.c1)))
            end

            offset += child.nrows
        end

        return _👻Grid((nrows, ncols, items))
    end
end

function _👻flatten(λ::AbstractArray{T, 2} where {T})
    return if isempty(λ)
        _👻Grid((0, 0, _👻Item[]))
    elseif length(λ) ≡ 1
        _👻Grid((1, 1, _👻Item[_👻Item((first(λ), 0, 0, 1, 1))]))
    elseif size(λ, 1) ≡ 1
        grid = _👻flatten(λ')
        _👻Grid((grid.ncols, grid.nrows, _👻Item[_👻Item((i.layout, i.c0, i.r0, i.c1, i.r1)) for i ∈ grid.items]))
    elseif size(λ, 2) ≡ 1
        _👻flatten(@view λ[:,1])
    else
        _👻flatten([@view λ[i:i,:] for i ∈ axes(λ, 1)])
    end
end

end
using .Layouts: layout
export layout
