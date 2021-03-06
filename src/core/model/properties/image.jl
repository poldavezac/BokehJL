struct Image <: iProperty end

bokehstoragetype(::Type{Image}) = String

const IMAGE_PATTERN = r"^data:image/(PNG|JPG);base64,[a-zA-Z0-9+_/=]*$"

const _FORMATS = (
    r"\.png"i                  => :png,
    r"\.(p*?jpe*?g|jfif|pjp)"i => :jpeg,
    r"\.svg"i                  => Symbol("svg+xml"),
)

function bokehconvert(::Type{Image}, ν::AbstractString)
    if isfile(ν)
        ind = findfirst(!isnothing∘Base.Fix2(match, splitext(ν)[end])∘first, _FORMATS)

        isnothing(ind) && return Unknown()

        return "data:image/$(_FORMATS[ind][end]);base64,$(base64encode(read(ν)))"
    end
    
    isnothing(match(IMAGE_PATTERN, ν)) && return Unknown()
    return ν
end
