module test_pkgs_safetestsets_safetestset

using SafeTestsets, Test

@safetestset "SafeTestsets Tests" begin
    @test true
end

end # module test_pkgs_safetestsets_safetestset
