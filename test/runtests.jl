using Jive

targets = split("""
    testjive
    jive
""")

node1 = split("""
    jive/runtests/verbose.jl
    jive/sprints
""")

skip = split("""
    jive/onlyonce/heavy.jl
    jive/__END__/included.jl
    jive/__REPL__
    pkgs/testrunner/runtest.jl
    stdlib_test/passes/nothrow_testset.jl
    stdlib_test/passes/test_pop_testset_exec.jl
    stdlib_test/fails/
""")
if VERSION < v"1.14-DEV"
    push!(skip, "stdlib_test/passes/")
end

runtests(@__DIR__; targets, node1, skip)
