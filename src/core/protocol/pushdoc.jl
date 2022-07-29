function pushdoc(title :: AbstractString, roots, 𝑅::Serialize.iRules = Serialize.Rules())
    return Dict{String, Any}(
        "defs"    => Nothing[],
        "roots"   => Dict{String, Any}[serialize(i, 𝑅) for i ∈ values(bokehmodels(roots))],
        "title"   => "$title",
        "version" => "$(PROTOCOL_VERSION)",
    )
end

pushdoc(self::iDocument, 𝑅::Serialize.iRules = Serialize.Rules()) = (; doc = pushdoc(self.title, self, 𝑅))
pushdoc!(self::iDocument, μ::Dict{String}, 𝐵::Buffers) = deserialize!(self, μ, 𝐵)
