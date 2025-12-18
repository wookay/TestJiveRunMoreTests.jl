module test_pkgs_testitems_testitemrunner

using Test
using TestItems
using TestItemRunner

# julia pkgs/testitems/testitemrunner.jl
@run_package_tests verbose=true

@testitem "default_imports true" default_imports=true begin
    @test true
end

@testitem "default_imports false" default_imports=false begin
    using Test
    @test true
end

end # module test_pkgs_testitems_testitemrunner
