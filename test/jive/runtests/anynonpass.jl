module test_jive_runtests_anynonpass

using Test
using Jive

ts = @testset "empty" begin
end
@test !(@inferred Jive.anynonpass(ts))

end # module test_jive_runtests_anynonpass
