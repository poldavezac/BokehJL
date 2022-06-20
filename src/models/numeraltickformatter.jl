#- file created by '/home/pdavezac/code/Bokeh/deps/src/CodeCreator.jl': edit at your own risk! -#

@model mutable struct NumeralTickFormatter <: iNumeralTickFormatter

    format :: String = "0,0"

    language :: Model.EnumType{(Symbol("be-nl"), :chs, :cs, Symbol("da-dk"), Symbol("de-ch"), :de, :en, Symbol("en-gb"), Symbol("es-ES"), :es, :et, :fi, Symbol("fr-CA"), Symbol("fr-ch"), :fr, :hu, :it, :ja, Symbol("nl-nl"), :pl, Symbol("pt-br"), Symbol("pt-pt"), :ru, Symbol("ru-UA"), :sk, :th, :tr, Symbol("uk-UA"))} = :en

    rounding :: Model.EnumType{(:round, :nearest, :floor, :rounddown, :ceil, :roundup)} = :round
end