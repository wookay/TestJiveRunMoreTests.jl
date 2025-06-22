module test_jive_runtests_verbose

using Test
using Jive

test_path = normpath(@__DIR__)
output = @sprint_plain(runtests(test_path, targets="target3", verbose=true, enable_distributed=false))
@test !isempty(output)

output = @sprint_plain(runtests(test_path, targets="target3", verbose=false, enable_distributed=false))
@test isempty(output)

end # module test_jive_runtests_verbose
