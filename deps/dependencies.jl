module JLDeps
using Bokeh
using PythonCall

function instancetype(cls)
    if cls ∉ names(Bokeh.Models; all = true)
        Bokeh.Models.eval(:(struct $cls end))
    end
    getfield(Bokeh.Models, cls)
end

propdependencies(::Val, _...) = Set{Type}()
propdependencies(::Val{:Dict}, prop) = propdependencies(prop.keys_type) ∪ propdependencies(prop.values_type)
propdependencies(::Union{(Val{i} for i ∈ (:List, :Seq, :Array))...}, prop) = propdependencies(prop.item_type)
propdependencies(::Union{(Val{i} for i ∈ (:Tuple, :Either))...}, prop) = ∪((propdependencies(i) for i ∈ prop._type_params)...)
propdependencies(::Val{:NamedTuple}, prop) = ∪((propdependencies(i) for i ∈ prop._fields.values())...)
propdependencies(::Union{(Val{i} for i ∈ (:NonNullable, :Readonly, :Nullable))...}) = propdependencies(prop.type_param)
propdependencies(::Val{:RestrictedDict}, prop) = propdependencies(prop.values_type)
propdependencies(::Val{:Instance}, prop) = let qual = if pyhasattr(prop._instance_type, "__name__")
        string(
            pyconvert(String, prop._instance_type.__module__),
            ".",
            pyconvert(String, prop._instance_type.__name__)
        )
    else
        pyconvert(String, prop._instance_type)
    end
    cls = Symbol((occursin(".dom.", qual) ? "Dom" : "") * (split(qual, '.')[end]))

    cls ∈ (:Model, :DOMNode) ? Set{Type}() : Set{Type}([instancetype(cls)])
end

propdependencies(prop::Py) = propdependencies(Val(pyconvert(Symbol, prop.__class__.__name__)), prop)

function jldependencies(mdl::Py)
    out =  ∪((
        propdependencies(getproperty(mdl, pyconvert(Symbol, i)).property)
        for i ∈ mdl.properties()
    )...)
    pop!(out, instancetype(pyconvert(Symbol, mdl.__name__)), nothing)
    out
end

export jldependencies
end

using .JLDeps
