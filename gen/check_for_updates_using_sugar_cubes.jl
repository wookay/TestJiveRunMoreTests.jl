# check_for_updates_using_sugar_cubes.jl
#
# ~/.julia/dev/Jive main✔   ln -s  JULIA_SOURCE_PATH  sources

using Test
using SugarCubes: code_block_with, has_diff
# https://github.com/wookay/SugarCubes.jl

function check_the_code_block_diff(src_path::String,
                                   src_signature::Union{Nothing, Expr},
                                   dest_path::String,
                                   dest_signature::Union{Nothing, Expr} ;
                                   skip_lines = (src = Int[], dest = Int[]))
    printstyled(stdout, "check_the_code_block_diff", color = :blue)
    print(stdout, " ", basename(src_path), " ")
    src_filepath = normpath(@__DIR__, "..", src_path)
    dest_filepath = normpath(@__DIR__, "..", dest_path)
    @test isfile(src_filepath)
    @test isfile(dest_filepath)
    src_block = code_block_with(; filepath = src_filepath, signature = src_signature)
    if src_block.signature !== nothing
        (depth, kind, sig) = src_block.signature.layers[end]
        printstyled(stdout, sig.args[1], color = :cyan)
    end
    dest_block = code_block_with(; filepath = dest_filepath, signature = dest_signature)
    @test has_diff(src_block, dest_block; skip_lines) === false
    println(stdout)
end

check_the_code_block_diff(
    "sources/stdlib/Test/test/runtests.jl",
    nothing,
    "test/stdlib_test/passes/runtests.jl",
    nothing,
    skip_lines = (src = vcat(1819, 2451:2454, 2457), dest = vcat(1819, 2451:2454, 2457))
)

check_the_code_block_diff(
    "sources/stdlib/Test/test/nothrow_testset.jl",
    nothing,
    "test/stdlib_test/passes/nothrow_testset.jl",
    nothing
)

check_the_code_block_diff(
    "sources/stdlib/Test/test/test_pop_testset_exec.jl",
    nothing,
    "test/stdlib_test/passes/test_pop_testset_exec.jl",
    nothing
)
