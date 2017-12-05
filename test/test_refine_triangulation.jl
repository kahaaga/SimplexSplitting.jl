n_points = 10
tau = 1

@testset "Refining triangulation" begin
    embedding = embedding_example(n_points, 3, tau)

    triang_points, simplex_indices = triangulate(embedding)

    # How many simplices are there in the triangulation?
    n_orig = size(simplex_indices, 1)
    simplices = [triang_points[simplex_indices[i, :], :] for i in 1:n_orig]

    @testset "Triangulation" begin
        # Create an 3D embedding to triangulate.
        @test isa(triang_points, Array{Float64, 2})
        @test isa(simplex_indices, Array{Int, 2})
    end

    # Rules for splitting simplices in 3D with size reducing factor 2
    splitting_rules = simplicial_subdivision(2, 3)

    @testset "Simplex division rules" begin
        @test isa(splitting_rules[1], Array{Int64, 2})
        @test isa(splitting_rules[2], Array{Int64, 2})
    end


    @testset "Refine triangulation" begin
        @testset "E = $E" for E in 2:7
            @testset "k = $k" for k in 1:3
                splitting_rules = simplicial_subdivision(k, E)
                embedding = embedding_example(n_points, E, 1)
                triang_points, simplex_indices = triangulate(embedding)

                # How many simplices did we get?
                n_orig = size(simplex_indices, 1)

                simplices = [triang_points[simplex_indices[i, :], :] for i in 1:n_orig]
                refined_triangulation = refine_triangulation(triang_points, simplex_indices,
                                    splitting_rules, split_indices = collect(1:n_orig))

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

    @testset "Simplex volumes are split by factor of k" begin

        @testset "k = $k" for k in 1:3
            @testset "E = $E" for E in 2:7
                canonical_simplex_vertices = zeros(E + 1, E)
                canonical_simplex_vertices[2:(E + 1), :] = eye(E)

                # Refine the canonical simplex
                simplex_indices = zeros(Int, 1, E + 1)
                simplex_indices[1, :] = collect(1:E+1)

                # Generic splitting rules for this combination of dimension and splitting
                # factor.
                splitting_rules = simplicial_subdivision(k, E)

                refined = refine_triangulation(canonical_simplex_vertices, simplex_indices,
                                                splitting_rules, split_indices = [1])

                # How many new simplices did we get?
                n = size(refined[2], 1)
                refined_simplices = [refined[1][refined[2][i, :], :] for i in 1:n]

                canonical_simplex_vol = abs(det(
                    hcat(canonical_simplex_vertices, ones(E + 1))
                    ))

                volumes_subsimplices = [abs(det(hcat(refined_simplices[i], ones(E + 1))))
                                                                            for i in 1:n]

                @test canonical_simplex_vol ≈ sum(volumes_subsimplices) atol = 1/10^7
            end
        end
    end
end
