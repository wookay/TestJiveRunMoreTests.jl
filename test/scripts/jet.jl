# Preferences
# https://github.com/JuliaPackaging/Preferences.jl

# JET
# https://github.com/aviatesk/JET.jl

using Preferences
if Preferences.load_preference("JET", "JET_DEV_MODE") != true
    Preferences.set_preferences!("JET", "JET_DEV_MODE" => true)
end

# using InteractiveUtils: @time_imports
# @time_imports using JET

using JET: JET
using .JET: ReportConfig, @report_call

#=
using .JET: watch_file
using Revise
using Jive
jive_src_jivejl = String(Base.moduleloc(Jive).file)
watch_file(jive_src_jivejl, report_config=report_config)
=#

using Jive

@time_expr @report_call 1+2
println()

function detect_not_defined_code()
    blah_blah
end

report_config = ReportConfig(#=target_modules=#(@__MODULE__,), #=ignored_modules=#())
@time_expr report = @report_call report_config=report_config detect_not_defined_code()
show(report)
println()

function jive_runtests()
    runtests(@__DIR__)
    runtests(@__DIR__, failfast = true)
    runtests(@__DIR__, verbose = false)
end

using Distributed
report_config = ReportConfig(#=target_modules=#(Jive,), #=ignored_modules=#(Distributed,))
@time_expr report = @report_call report_config=report_config jive_runtests()
show(report)

if string(report) != "No errors detected\n"
    throw(ErrorException("`JET.@report_call runtests` found errors"))
end

# using .JET: CC, JuliaInterpreter
# @time_expr JET.test_package(Jive, report_config=report_config)
