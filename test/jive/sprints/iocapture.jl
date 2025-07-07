module test_jive_sprints_iocapture

using Test
using Jive

@test @sprint_plain(print(get(stdout, :color, true))) == "false"
@test @sprint_colored(print(get(stdout, :color, false))) == "true"

@test Jive.IOCapture.capture(; color = false) do
    print(stdout, get(stdout, :color, true))
end.output == "false"

end # module test_jive_sprints_iocapture
