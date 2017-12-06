n_points = 10
tau = 1

@testset "Refine triangulation with images" begin
    @testset "E = $E" for E in 3:5
        @testset "k = $k" for k in 1:4
            splitting_rules = simplicial_subdivision(k, E)
            embedding = embedding_example(n_points, E, 1)

            # Triangulate all but the last point
            triang_points, simplex_indices = triangulate(embedding[1:size(embedding, 1), :])

            # Take the images of the simplices in the triangulation as the forward projections
            # in time of the original simplices.
            image_indices = simplex_indices + 1
            image_vertices = vcat(triang_points[2:end, :], embedding[1, :].')
            @show E, k, triang_points, simplex_indices, image_vertices
            println()
            # How many simplices did we get?
            n_orig = size(simplex_indices, 1)

            simplices = [triang_points[simplex_indices[i, :], :] for i in 1:n_orig]
            refined_triangulation = refine_triangulation_images(triang_points, simplex_indices,
                                    splitting_rules, image_vertices, collect(1:3), k)

            # How many new simplices did we get?
            n_refined = size(refined_triangulation[2], 1)
            refined_simplices = [refined_triangulation[1][refined_triangulation[2][i, :], :]
                                    for i in 1:n_refined]

            refined_vertices = refined_triangulation[1]
            refined_simplex_indices = refined_triangulation[2]

            @testset "Arrays are of right dimensions and types" begin
                @test isa(refined_vertices, Array{Float64, 2})
                @test isa(refined_simplex_indices, Array{Int, 2})
            end
            # Compare volume of original triangulation with the refined triangulation

            @testset "Volume is preserved" begin
                triang_vols = [abs(det(hcat(simplices[i], ones(E + 1)))) for i in 1:n_orig]
                refined_triang_vols = [abs(det(hcat(refined_simplices[i], ones(E + 1)))) for i in 1:n_refined]
                @test sum(triang_vols) ≈ sum(refined_triang_vols) atol = 1/10^7
            end
        end
    end
end
