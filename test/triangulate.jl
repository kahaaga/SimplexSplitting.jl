using SimplexSplitting


@testset "Triangulation" begin
    @testset "From embedding" begin
        npts = 15; cov = 0.4; emb = gaussian_embedding(npts, cov)
        t = triang_from_embedding(emb)

        # Verify that triangulation is created
        @test typeof(t) == Triangulation

        # Check functions to extract parts of the triangulation
        n_simplices = size(t.simplex_inds, 1)
        @test length(get_simplices(t)) == n_simplices
        @test length(get_imagesimplices(t)) == n_simplices
        @test typeof(find_simplex(t, 1)) == Simplex
        @test typeof(find_imsimplex(t, 1)) == Simplex
    end
end
