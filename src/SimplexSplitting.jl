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
include("refine_triangulation_with_images.jl")
include("invariantset.jl")
include("centroids_radii.jl")

export tensordecomposition, simplex_split, simplicial_subdivision_single,
    simplicial_subdivision, embed, triangulate, embedding_example, refine_triangulation,
    refine_triangulation_images, invariantset, centroids_radii2
end # module
