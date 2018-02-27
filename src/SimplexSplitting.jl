module SimplexSplitting

using SimplexIntersection

include("tensordecomposition.jl")
include("complementary.jl")
include("simplex_split.jl")
include("simplex_subdivision.jl")
include("simplex_subdivision_single.jl")
include("heaviside.jl")
include("embed.jl")
include("triangulate.jl")
include("refine_triangulation.jl")
include("refine_triangulation_with_images.jl")
include("invariantset.jl")
include("centroids_radii.jl")
include("simplexvolumes.jl")
include("refine_recursive.jl")
include("refine_recursive_withimages.jl")
include("refine_t.jl")
include("refine_variable_k_new.jl")

function __init__()
    # E = 3
    # k = 1
    #
    # println("Running test refinement ...")
    # println("----------------------------")
    # # Run naive simplex refinement examples to trigger precompilation
    # embedding = embedding_example(10, E, 1)
    #
    # # Triangulate all but the last point
    # points, simplex_inds = triangulate(embedding[1:size(embedding, 1), :])
    #
    # # Take the images of the simplices in the triangulation as the forward projections
    # # in time of the original simplices. Append first point of triangulation to
    # # 'fake' an invariant set where the last point falls within the convex hull
    # # of the triangulation
    # image_indices = simplex_inds + 1
    # image_points = vcat(points[2:end, :], embedding[1, :].')
    #
    # centroids, radii = centroids_radii2(points, simplex_inds)
    # centroids_im, radii_im = centroids_radii2(image_points, simplex_inds)
    #
    # volumes_before = simplex_volumes(points, simplex_inds)
    # imagevolumes_before = simplex_volumes(image_points, simplex_inds)
    #
    # radiusmax = max(maximum(radii), maximum(radii_im))
    # maxradius_allowed = radiusmax * 0.9
    # #println("EXCLUDING IMAGE SIMPLICES")
    # refine_recursive(points, simplex_inds, maxradius_allowed, k)
    # println("INCLUDING IMAGE SIMPLICES")
    # refine_recursive_images(points, image_points, simplex_inds, maxradius_allowed, k)
    # println("Done.")
end

export tensordecomposition, simplex_split, simplicial_subdivision_single,
    simplicial_subdivision, embed, Embedding, embedding, embedding_ex, triangulate, Triangulation, triang_from_embedding, embedding_example, refine_triangulation, simplex_volumes,
    refine_triangulation_images, invariantset, centroids_radii2, refine_recursive, refine_recursive_images, refine_variable_k!, refine_variable_k_new, refine_variable_k_newnew, query_refinement,
    refine_t!,
    gaussian_embedding, centroids_radii2, example_triangulation,
    gaussian_embedding_arr
end # module
