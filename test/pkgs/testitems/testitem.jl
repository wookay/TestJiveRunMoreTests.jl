module test_pkgs_testitems_testitem

using Test
using TestItems

@testset "TestItems" begin
    x = @testitem "Name of the test item" begin
        @test false
    end
    @test x === nothing
end

end # module test_pkgs_testitems_testitem
