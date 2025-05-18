using Test
using Jive

context_variable = []

runtests(@__DIR__, targets=["target1"], enable_distributed=false, verbose=false) # default context=nothing
@test context_variable == []

runtests(@__DIR__, targets=["target1"], enable_distributed=false, context=nothing, verbose=false)
@test context_variable == []

runtests(@__DIR__, targets=["target1"], enable_distributed=false, context=Main, verbose=false)
@test context_variable == []

@test nameof(@__MODULE__()) === :anonymous
runtests(@__DIR__, targets=["target1"], enable_distributed=false, context=@__MODULE__, verbose=false)
@test context_variable == [:target1]

include("target2.jl")
@test context_variable == [:target1, :target2]


module test_jive_runtests_context

using Test
using Jive

context_variable = []

runtests(@__DIR__, targets="target1 target2", enable_distributed=false, context=@__MODULE__, verbose=false) # default context=nothing
@test context_variable == [:target1, :target2]

runtests(@__DIR__, targets=["target3", "target2"], enable_distributed=false, context=@__MODULE__, verbose=false)
@test context_variable == [:target1, :target2, :target3, :target2]

runtests(@__DIR__, targets=["target1"], enable_distributed=false, context=Main, verbose=false)
@test context_variable == [:target1, :target2, :target3, :target2] # no changes

@test nameof(@__MODULE__()) === :test_jive_runtests_context
runtests(@__DIR__, targets=["target1"], enable_distributed=false, context=@__MODULE__, verbose=false)
@test context_variable == [:target1, :target2, :target3, :target2, :target1]

include("target2.jl")
@test context_variable == [:target1, :target2, :target3, :target2, :target1, :target2]

end # module test_jive_runtests_context
