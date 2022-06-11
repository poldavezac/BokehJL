bokehfieldtype(𝑇::Type{<:Tuple}) = Tuple{(bokehfieldtype(T) for T ∈ 𝑇.parameters)...}

function bokehwrite(𝑇::Type{<:Tuple}, ν::Union{Vector, Tuple})
    return tuple((bokehwrite(T, i) for (i, T) ∈ zip(ν, 𝑇.parameters))...)
end

function bokehread(𝑇::Type{<:Tuple}, μ::iHasProps, σ::Symbol, ν::Tuple)
    return tuple((bokehread(T, μ, σ, i) for (i, T) ∈ zip(ν, 𝑇.parameters))...)
end

bokehfieldtype(𝑇::Type{<:NamedTuple}) = NamedTuple{
    𝑇.parameters[1], tuple((bokehfieldtype(T) for T ∈ 𝑇.parameters[2].parameters)...)
}

function bokehwrite(𝑇::Type{<:NamedTuple}, ν::NamedTuple)
    return (;(i => bokehwrite(T, ν[i]) for (i, T) ∈ zip(keys(𝑇), fieldtypes(𝑇)))...)
end

function bokehwrite(𝑇::Type{<:NamedTuple}, ν::AbstractDict{<:AbstractString})
    return (;(i => bokehwrite(T, ν[string(i)]) for (i, T) ∈ zip(keys(𝑇), fieldtypes(𝑇)))...)
end

function bokehread(𝑇::Type{<:NamedTuple}, μ::iHasProps, σ::Symbol, ν::NamedTuple)
    return (;(i => bokehread(T, μ, σ, ν[i]) for (i, T) ∈ zip(keys(𝑇), fieldtypes(𝑇)))...)
end

bokehwrite(::Type{Any}, ν) = ν
