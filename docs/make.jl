using JuliaEuler
using Documenter

DocMeta.setdocmeta!(JuliaEuler, :DocTestSetup, :(using JuliaEuler); recursive=true)

makedocs(;
    modules=[JuliaEuler],
    authors="Brynjar Smári Bjarnason <binni@binnisb.com> and contributors",
    repo="https://github.com/binnisb/JuliaEuler.jl/blob/{commit}{path}#{line}",
    sitename="JuliaEuler.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://binnisb.github.io/JuliaEuler.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/binnisb/JuliaEuler.jl",
)
