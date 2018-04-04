using SimplexSplitting
using Base.Test

# Only run these if the refinement tests fail
include("embed.jl")
include("triangulate.jl")

# If these succeed, then the above doesn't need testing
include("refine_triangulation.jl")
include("refine_triangulation_with_images.jl")
include("refine_recursive.jl")
include("refine_recursive_with_images.jl")
include("refine_variable_k.jl")
