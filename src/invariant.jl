# This file defines `Invariant`, a default invariant that should be used
# in most cases to construct invariants.


"""
    struct Invariant(fn, title; kwargs...) <: AbstractInvariant

Default invariant type. Use [`invariant`](#) to construct invariants.
"""
Base.@kwdef struct Invariant <: AbstractInvariant
    fn
    title::String
    description::Union{Nothing, String} = nothing
    inputfn = identity
    format = default_format()
end


function Invariant(fn, title::String; description = nothing, inputfn = identity,
                   format = default_format())
    Invariant(; fn, title, description, inputfn, format)
end

(inv::Invariant)(args...) = check(inv, args...)

title(inv::Invariant) = inv.format(inv.title)
description(inv::Invariant) =
    isnothing(inv.description) ? nothing : inv.format(inv.description)
satisfies(inv::Invariant, input) = inv.fn(inv.inputfn(input))
