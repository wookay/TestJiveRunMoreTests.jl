module test_jive_runtests_verbose

using Test
using Jive

test_path = normpath(@__DIR__)

output = @sprint_plain(runtests(test_path, targets="target3", verbose=false, enable_distributed=false))
m = match(r"""
Starting testset: hello
""", output)
if m !== nothing
    @test VERSION >= v"1.14-DEV"
end

output = @sprint_plain(runtests(test_path, targets="target3", verbose=true, enable_distributed=false))
m = match(r"""
target3.jl
""", output)
@test m !== nothing

end # module test_jive_runtests_verbose
