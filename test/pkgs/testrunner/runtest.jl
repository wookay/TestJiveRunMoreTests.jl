module test_pkgs_testrunner_runtest

using Test
using TestRunner

function count_passes(result)
    tc = Test.get_test_counts(result)
    sum((tc.cumulative_passes, tc.passes))
end

result = @testset "run demo1" runtest(normpath(@__DIR__, "demo.jl"), [r"demo1"])
@test count_passes(result) == 1

result = @testset "run demo*" runtest(normpath(@__DIR__, "demo.jl"), [r"demo*"])
@test count_passes(result) == 3

end # module test_pkgs_testrunner_runtest
