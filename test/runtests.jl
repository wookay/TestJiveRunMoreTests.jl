using Jive
runtests(@__DIR__; targets="testjive jive pkgs",
                   node1=[
                       "jive/runtests/verbose.jl",
                       "jive/sprints",
                   ],
                   skip=[
                       "jive/onlyonce/heavy.jl",
                       "jive/__END__/included.jl",
                       "jive/__REPL__",
                       "test/nothrow_testset.jl",
                       "test/runtests.jl",
                       "test/test_pop_testset_exec.jl",
                   ])
