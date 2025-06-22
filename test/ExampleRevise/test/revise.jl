# julia -i -q --project=. revise.jl example

using Revise, Jive
using ExampleRevise

trigger = function (path)
    printstyled("changed ", color=:cyan)
    println(path)
    revise()
    runtests(@__DIR__, skip=["revise.jl"])
end

watch(trigger, @__DIR__, sources=[pathof(ExampleRevise)])
trigger("")

Base.JLOptions().isinteractive==0 && wait()
