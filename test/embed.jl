
@testset "Embedding" begin
    ex1 = embedding_example(10, 3, 1)

    @testset "Dimensions are correct" begin
        @test size(ex1)[1] == 8
        @test size(ex1)[2] == 3
    end

    @testset "Does embedding form invariant set?" begin
        @test isa(invariantset(ex1), Bool)
    end


end
