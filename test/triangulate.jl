using SimplexSplitting


@testset "Triangulation" begin
    npts = 15; cov = 0.4; emb = gaussian_embedding(npts, cov)
    @test typeof(Triangulation()) == Triangulation

    @testset "From embedding" begin
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

    t = triang_from_embedding(emb)
	@testset "Find potentially intersecting simplices" begin
        @test length(maybeintersecting_simplices(t, 1)) > 0
        @test length(maybeintersecting_imsimplices(t, 1)) > 0
    end

    @testset "todict" begin
        d = todict(t)
        @test "simplex_inds" in keys(d)
    end

    @testset "allocations" begin
        triang_malloc(100, 3, 40)
    end
end
