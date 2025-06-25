# Preferences
# https://github.com/JuliaPackaging/Preferences.jl

# JET
# https://github.com/aviatesk/JET.jl

using Preferences
if Preferences.load_preference("JET", "JET_DEV_MODE") != true
    Preferences.set_preferences!("JET", "JET_DEV_MODE" => true)
end

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
using Distributed
printstyled("JET.@report_call runtests\n", color = :cyan)
report_config = ReportConfig(#=target_modules=#(Jive,), #=ignored_modules=#(Distributed,))
@time report = @report_call report_config=report_config runtests(normpath(@__DIR__, ".."); targets="testjive jive")
show(report)
if string(report) != "No errors detected\n"
    throw(ErrorException("`JET.@report_call runtests` found errors"))
end
