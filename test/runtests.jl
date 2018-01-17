using SimplexSplitting
using Base.Test

# Only run these if the refinement tests fail
#include("test_tensordecomposition.jl")
#include("test_embed.jl")
#include("test_triangulate.jl")

# If these succeed, then the above doesn't need testing
include("test_refine_triangulation.jl")
include("test_refine_triangulation_with_images.jl")
include("test_refine_recursive.jl")
include("test_refine_recursive_with_images.jl")
