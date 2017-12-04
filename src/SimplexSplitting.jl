module SimplexSplitting

include("tensordecomposition.jl")
include("complementary.jl")
include("simplex_split.jl")
include("simplex_subdivision.jl")
include("heaviside.jl")

export tensordecomposition, simplex_split, simplicial_subdivision_single,
    simplicial_subdivision
end # module
