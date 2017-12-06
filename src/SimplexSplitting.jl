module SimplexSplitting

using SimplexIntersection

include("tensordecomposition.jl")
include("complementary.jl")
include("simplex_split.jl")
include("simplex_subdivision.jl")
include("heaviside.jl")
include("embed.jl")
include("triangulate.jl")
include("refine_triangulation.jl")

export tensordecomposition, simplex_split, simplicial_subdivision_single,
    simplicial_subdivision, embed, triangulate, embedding_example, refine_triangulation
end # module
