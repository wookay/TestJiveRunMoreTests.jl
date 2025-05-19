module test_errors_error1

using Test

@testset "error testset" begin

@test true

g() = must_be_an_error
f() = g()
f()

end

end # module test_errors_error1
