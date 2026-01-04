using Jive
runtests(@__DIR__; targets="testjive jive",
                   node1=[
                       "jive/runtests/verbose.jl",
                       "jive/sprints",
                   ],
                   skip=[
                       "jive/onlyonce/heavy.jl",
                       "jive/__END__/included.jl",
                       "jive/__REPL__",
                       "pkgs/testrunner/runtest.jl",
                   ])
