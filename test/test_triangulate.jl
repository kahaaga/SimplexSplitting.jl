
@testset "Triangulation" begin
    # Create an 3D embedding to triangulate.
    embedding = embedding_example(10, 3, 1)

    # Triangulate the embedding
    triang_points, simplex_indices = triangulate(embedding)

    @test isa(triang_points, Array{Float64, 2})
    @test isa(simplex_indices, Array{Int, 2})

end
