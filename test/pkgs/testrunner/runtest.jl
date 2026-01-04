module test_pkgs_testrunner_runtest

using Test
using TestRunner

result = @testset "run demo1" runtest("demo.jl", [r"demo1"])
@test sum(r -> r.n_passed, result.results) == 1

result = @testset "run demo*" runtest("demo.jl", [r"demo*"])
@test sum(r -> r.n_passed, result.results) == 3

end # module test_pkgs_testrunner_runtest
