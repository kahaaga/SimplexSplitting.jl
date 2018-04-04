frac_orig_size = 0.2

@testset "Recursive splitting" begin
    @testset "E = $E" for E in 2:4
        @testset "k = $k" for k in 2:3
            canonical_simplex_vertices = zeros(E + 1, E)
            canonical_simplex_vertices[2:(E + 1), :] = eye(E)
            canonical_simplex_vol = abs(det(hcat(canonical_simplex_vertices, ones(E + 1))))

            # Refine the canonical simplex
            simplex_indices = zeros(Int, 1, E + 1)
            simplex_indices[1, :] = collect(1:E+1)

            centroids, radii = centroids_radii2(canonical_simplex_vertices, simplex_indices)
            volumes_before = simplex_volumes(canonical_simplex_vertices, simplex_indices)

            # Generic splitting rules for this combination of dimension and splitting
            # factor.
            radiusmax = maximum(radii)

            maxradius_allowed = radiusmax * 0.4
            refined = refine_recursive(canonical_simplex_vertices, simplex_indices, maxradius_allowed, 2)

            radiusmax_after_refinement = maximum(refined[4])
            volumes_after_refinement = refined[5]

            @testset "Desired refinement level reached" begin
                @test radiusmax_after_refinement < maxradius_allowed
            end

            @testset "Triangulation volumes are preserved" begin
                @test sum(volumes_before) ≈ sum(volumes_after_refinement)
            end
        end
    end
end
