using Test
using Jive

context_variable = []

runtests(@__DIR__, targets=["target1"], enable_distributed=false, verbose=false) # default into=nothing
@test context_variable == []

runtests(@__DIR__, targets=["target1"], enable_distributed=false, into=nothing, verbose=false)
@test context_variable == []

runtests(@__DIR__, targets=["target1"], enable_distributed=false, into=Main, verbose=false)
@test context_variable == []

@test nameof(@__MODULE__()) === :anonymous
runtests(@__DIR__, targets=["target1"], enable_distributed=false, into=@__MODULE__, verbose=false)
@test context_variable == [:target1]

include("target2.jl")
@test context_variable == [:target1, :target2]


module test_jive_runtests_into

using Test
using Jive

context_variable = []

runtests(@__DIR__, targets="target1 target2", enable_distributed=false, into=@__MODULE__, verbose=false, failfast=true)
@test context_variable == [:target1, :target2]

runtests(@__DIR__, targets=["target3", "target2"], enable_distributed=false, into=@__MODULE__, verbose=false)
@test context_variable == [:target1, :target2, :target3, :target2]

runtests(@__DIR__, targets=["target1"], enable_distributed=false, into=Main, verbose=false)
@test context_variable == [:target1, :target2, :target3, :target2] # no changes

@test nameof(@__MODULE__()) === :test_jive_runtests_into
runtests(@__DIR__, targets=["target1"], enable_distributed=false, into=@__MODULE__, verbose=false)
@test context_variable == [:target1, :target2, :target3, :target2, :target1]

include("target2.jl")
@test context_variable == [:target1, :target2, :target3, :target2, :target1, :target2]

end # module test_jive_runtests_into
