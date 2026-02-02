using Test

@testset "some testset" verbose = true begin
    @test true
    @testset "more testset" verbose = true begin
        @test true
    end
end
