using Jive
runtests(@__DIR__; skip=["Example", "errors", "fails", "jive/onlyonce/heavy.jl", "jive/__END__/included.jl", "jive/__REPL__"])
