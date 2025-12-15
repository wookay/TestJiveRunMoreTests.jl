script_fails_and_errors = """
JULIA_TEST_FAILFAST=1 JIVE_SKIP=x julia runtests.jl fails/test
JULIA_TEST_FAILFAST=1 JIVE_SKIP=x julia runtests.jl errors/issue63.jl
JULIA_TEST_FAILFAST=1 JIVE_SKIP=x julia runtests.jl errors/testset_let.jl
JULIA_TEST_FAILFAST=1 JIVE_SKIP=x julia runtests.jl errors/error1.jl
JULIA_TEST_FAILFAST=1 JIVE_SKIP=x julia runtests.jl errors/error2.jl
"""

script_failfast = """
                      julia -e 'using Jive; runtests(@__DIR__, targets="fails")'
                      julia -e 'using Jive; runtests(@__DIR__, targets="fails/test", failfast=true)'
JULIA_TEST_FAILFAST=1 julia -e 'using Jive; runtests(@__DIR__, targets="fails/test")'
JULIA_TEST_FAILFAST=0 julia -e 'using Jive; runtests(@__DIR__, targets="fails/test", failfast=true)'
"""


struct Report
    succ_count::Int
    error_count::Int
end

struct SuccessError <: Exception
    msg
end

function run_julia_scripts(cmds::String)::Report
    succ_count = 0
    error_count = 0
    for line in split(cmds, "\n")
        isempty(line) && continue
        if occursin("julia ", line)
            println()
            body = strip(line)
            println(repeat("-", length(body)))
            printstyled(body, color = :cyan, bold = true)
            println()

            (env_part, cmd_part) = split(line, "julia ")
            env_parts = filter(!isempty, split(env_part, " "))
            env_vars = map(env_parts) do env_part
                (k, v) = split(env_part, "=")
                k => v
            end
            if occursin("-e ", cmd_part)
                (_, e) = split(cmd_part, "-e ")
                p = replace(e, "'" => "")
                args = ["-e", p]
            else
                args = Vector{String}(split(cmd_part))
            end
            julia_cmd = Base.julia_cmd()
            cmd = Cmd([julia_cmd..., args...])
        else
            continue
        end
        try
            withenv(env_vars...) do
                if success(run(cmd))
                    succ_count += 1
                    Base.showerror(stdout, SuccessError("🚨 Expect failures but returned success without errors."))
                else
                    error_count += 1
                end
            end
        catch _e
            error_count += 1
        end
    end
    Report(succ_count, error_count)
end

function Base.showerror(io::IO, err::SuccessError)
    printstyled(io, "SuccessError:", color = :light_yellow, bold = true)
    println(io)
    print(io, err.msg)
end

function run_script(scripts::Vector{String})
    succ_count = 0
    error_count = 0
    for script in scripts
        report = run_julia_scripts(script)
        succ_count += report.succ_count
        error_count += report.error_count
    end
    if succ_count > 0
        throw(SuccessError("🚨 Expect failures but some commands returned success without errors."))
    else
        println("🟢 run scripts getting ", error_count, " expected failures.")
    end
end


if basename(pwd()) == "test" &&
   basename(PROGRAM_FILE) == basename(@__FILE__)
    run_script([script_fails_and_errors, script_failfast])
end
