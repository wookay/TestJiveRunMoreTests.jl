module test_pkgs_testrunner_runtest

using Test
using TestRunner

result = @testset "run demo1" runtest("demo.jl", [r"demo1"])
if result isa Test.DefaultTestSet
    @test sum(r -> r.n_passed, result.results) == 1
end

result = @testset "run demo*" runtest("demo.jl", [r"demo*"])
if result isa Test.DefaultTestSet
    @test sum(r -> r.n_passed, result.results) == 3
end

end # module test_pkgs_testrunner_runtest
