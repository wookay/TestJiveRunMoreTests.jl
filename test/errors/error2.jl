module test_errors_error2

using Test

@testset "error testset 2" begin

throw(ErrorException("throw_error2"))

end

end # module test_errors_error2
