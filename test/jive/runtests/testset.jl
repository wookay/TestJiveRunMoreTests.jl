module test_jive_testset

using Test
using Jive

total = runtests(@__DIR__, targets=split("targets2 target3"), enable_distributed=false, verbose=false, testset_filter=nothing)
@test total isa Jive.Total
@test total.elapsed_time >= 0
@test total.n_passes == 2

total = runtests(@__DIR__, targets=["target3"], enable_distributed=false, verbose=false, testset_filter="hello")
@test total.n_passes == 1

total = runtests(@__DIR__, targets=["target3"], enable_distributed=false, verbose=false, testset_filter=["hello", "world"])
@test total.n_passes == 2

total = runtests(@__DIR__, targets=["target3"], enable_distributed=false, verbose=false, testset_filter=r"^hello")
@test total.n_passes == 1

total = runtests(@__DIR__, targets=["target3"], enable_distributed=false, verbose=false, testset_filter=startswith("he"))
@test total.n_passes == 1

total = runtests(@__DIR__, targets=["target3"], enable_distributed=false, verbose=false, testset_filter=endswith("llo"))
@test total.n_passes == 1

end # module test_jive_testset
