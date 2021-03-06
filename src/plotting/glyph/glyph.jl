function glyph(๐::Symbol, args...; kwargs...)
    opts = filter((x -> "$x"[1] โ 'A':'Z'), names(Models; all = true))
    if ๐ โ opts
        ๐ = only(i for i โ opts if lowercase("$๐") == lowercase("$i"))
    end
    return glyph(getfield(Models, ๐), args...; kwargs...)
end

"""
    glyph(๐::Union{Symbol, Type{<:Models.iGlyph}}; kwargs...)

Create a glyph renderer given a glyph type or its name.
The kwargs should include all `glyphargs(๐)` at a minimum
"""
function glyph(๐::Type{<:Models.iGlyph}, args...; trait_color = missing, runchecks::Bool = true, kwa...)
    @nospecialize ๐ args
    kwargs = Dict{Symbol, Any}(kwa...)
    if length(args) โก 1 && Models.glyphargs(๐)[1:2] == (:x, :y)
        # Allows plotting `f(x) = y` with a single positional arg
        # the `else` clause would plot `f(y) = x`
        haskey(kwargs, :y) && throw(ErrorException("`:y` is both in args and kwargs"))
        kwargs[:y] = args[1]
    else
        # provides python-like positional keywords.
        for (i, j) โ zip(Models.glyphargs(๐), args)
            haskey(kwargs, i) && throw(ErrorException("`:$i` is both in args and kwargs"))
            kwargs[i] = j
        end
    end

    out    = Dict{Symbol, Any}(
       (i => pop!(kwargs, i) for i โ _๐ปRENDERER if i โ keys(kwargs))...,
       :data_source =>  _๐ปdatasource!(kwargs, get(kwargs, :source, missing), ๐)
    )

    defaults = _๐ปvisuals!(kwargs, ๐, false, trait_color, "")
    nonsel   = _๐ปvisuals!(kwargs, ๐, false, trait_color, "nonselection_", defaults, Dict{Symbol, Any}(:alpha => _๐ปNSEL_ALPHA))
    sel      = _๐ปvisuals!(kwargs, ๐, true,  trait_color, "selection_",    defaults)
    hover    = _๐ปvisuals!(kwargs, ๐, true,  trait_color, "hover_",        defaults)
    muted    = _๐ปvisuals!(kwargs, ๐, false, trait_color, "muted_",        defaults, Dict{Symbol, Any}(:alpha => _๐ปMUTED_ALPHA))

    create(x, d = :auto) = ismissing(x) ? d : ๐(; kwargs..., out..., x...)

    outp = Models.GlyphRenderer(;
        glyph              = create(defaults),
        nonselection_glyph = create(nonsel),
        selection_glyph    = create(sel),
        hover_glyph        = create(hover, nothing),
        muted_glyph        = create(muted),
        out...,
    )
    runchecks && _๐ปrunchecks(outp)
    return outp
end

"""
    glyph!(fig::Models.Plot, rend::Models.GlyphRenderer; dotrigger :: Bool = true, kwa...)
    glyph!(fig::Models.Plot, ๐::Union{Symbol, Type{<:Models.iGlyph}}; dotrigger :: Bool = true, kwa...)

Create a glyph renderer given a glyph type or its name and add it to the plot.
The kwargs should include all `glyphargs(๐)` at a minimum
"""
function glyph!(fig::Models.Plot, rend::Models.GlyphRenderer; dotrigger :: Bool = true, kwa...)
    push!(fig.renderers, rend; dotrigger)
    _๐ปlegend!(fig, rend, kwa; dotrigger)
    return rend
end

function glyph!(
        fig       :: Models.Plot,
        ๐         :: Union{Symbol, Type{<:Models.iGlyph}},
        args...;
        dotrigger :: Bool = true,
        kwa...
)
    trait_color = let cnt = count(Base.Fix2(isa, Models.iGlyphRenderer), fig.renderers)
        _๐ปCOLORS[min(length(_๐ปCOLORS), 1+cnt)]
    end
    return glyph!(fig, glyph(๐, args...; trait_color, kwa...); dotrigger, kwa...)
end

using Printf
using ..Plotting

for meth โ methods(Models.glyphargs)
    cls = meth.sig.parameters[2].parameters[1]
    (cls <: Models.iGlyph) || continue

    let ๐น = Symbol(lowercase("$(nameof(cls))")), ๐น! = Symbol("$(๐น)!")
        fargs = (
            Model.bokehproperties(Models.FigureOptions)...,
            Model.bokehproperties(Models.Plot)...,
        )
        @eval function $๐น!(fig::Models.Plot, args...; kwa...)
            @nospecialize fig args
            glyph!(fig, $cls, args...; kwa...)
        end
        @eval function $๐น(args...; kwa...)
            @nospecialize args
            fig = Plotting.figure(; (i for i โ kwa if first(i) โ $fargs)...)
            glyph!(fig, $cls, args...; (i for i โ kwa if first(i) โ $fargs)..., dotrigger = false)
            fig
        end
        @eval export $๐น!, $๐น

        for n โ (๐น, ๐น!)
            doc = let io = IOBuffer()
                println(io)
                if ("$n")[end] โก '!'
                    println(io, "    $n(")
                    println(io, "        $(@sprintf "%-10s" :plot) :: Models.Plot,")
                else
                    println(io, "    $n(")
                end

                gargs = Models.glyphargs(cls)
                for i โ gargs
                    p๐ = @sprintf "%-50s" Union{AbstractArray, Model.bokehfieldtype(cls, i)}
                    print(io, "        $(@sprintf "%-10s" i) :: $p๐ = $(repr(something(Model.themevalue(cls, i))))")
                    println(io, i โก gargs[end] ? ';' : ',')
                end
                println(io, "        kwa...")
                println(io, "    )")
                println(io, "")
                if ("$n")[end] โก '!'
                    println(io, "Adds a `$(nameof(cls))` glyph to the `Plot`")
                else
                    println(io, "Creates a `Plot` with a `$(nameof(cls))` glyph")
                end
                String(take!(io))
            end

            eval(:(@doc($doc, $n)))
        end
    end
end

export glyph!, glyph
