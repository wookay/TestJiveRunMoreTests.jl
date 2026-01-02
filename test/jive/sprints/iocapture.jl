module test_jive_sprints_iocapture

using Test
using Jive

@test @sprint_plain(print(get(stdout, :color, true))) == "false"
if stdout isa Base.TTY
    @test @sprint_colored(print(get(stdout, :color, false))) == "true"
end

@test Jive.IOCapture.capture(; color = false) do
    print(stdout, get(stdout, :color, true))
end.output == "false"

end # module test_jive_sprints_iocapture
