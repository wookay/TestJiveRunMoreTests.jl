module test_fails_for_loop

using Test

# julia 1.13.0-DEV.731
# commit 8567a3a10f4b746b91bf406bfe3171c3399aed8d

@testset "Foo" failfast=true begin
    @testset "\$x" for x in 1:2
        @test false
    end
    @testset "Bar" begin
        @test false
        @test true
    end
end

end # module test_fails_for_loop
