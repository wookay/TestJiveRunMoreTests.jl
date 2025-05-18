if isdefined(@__MODULE__, :context_variable)
    push!(context_variable, :target3)
end

using Test
@testset "hello" begin
    @test true
end
@testset "world" begin
    @test true
end
