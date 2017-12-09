#using SimplexSplitting
#include("../src/plot_simplex.jl")

frac_orig_size = 0.2

@testset "Recursive splitting without images" begin
    @testset "E = $E" for E in 2:5
        @testset "k = $k" for k in 2:3
            canonical_simplex_vertices = zeros(E + 1, E)
            canonical_simplex_vertices[2:(E + 1), :] = eye(E)
            canonical_simplex_vol = abs(det(hcat(canonical_simplex_vertices, ones(E + 1))))

            # Refine the canonical simplex
            simplex_indices = zeros(Int, 1, E + 1)
            simplex_indices[1, :] = collect(1:E+1)

            centroids, radii1 = centroids_radii2(canonical_simplex_vertices, simplex_indices)

            # Generic splitting rules for this combination of dimension and splitting
            # factor.
            refined = refine_fraction(canonical_simplex_vertices, simplex_indices, maximum(radii1), maximum(radii1), 2, frac_orig_size)

        end
    end
end


#p = plot_triangulation(refined[1], refined[2])
#centroids, radii2 = centroids_radii2(refined[1], refined[2])

#refined2 = refine_fraction(refined[1], refined[2], maximum(radii1), mean(radii2), 2, 0.1)
#@show refined2

#vertices = refined[1]
#inds = refined[2]
