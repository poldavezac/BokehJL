struct Size end
const Distance = Size
@inline bokehwrite(::Type{Size}, ν) = max(ν, 0.)
@inline bokehfieldtype(::Type{Size}) = Float64

struct Percent end
@inline bokehwrite(::Type{Percent}, ν) = clamp(ν, 0., 1.)
@inline bokehfieldtype(::Type{Percent}) = Float64

struct Interval{L,H} end
@inline bokehwrite(::Type{Interval{L,H}}, ν) where {L, H} = clamp(ν, L, H)
@inline bokehfieldtype(::Type{<:Interval}) = Float64

const Alpha = Percent
const Angle = Float64

struct PositiveInt end
@inline bokehwrite(::Type{PositiveInt}, ν) = max(ν, 0)
@inline bokehfieldtype(::Type{PositiveInt}) = Int64
