# Preferences
# JET

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
report_config = ReportConfig(#=target_modules=#(Jive,), #=ignored_modules=#(Distributed,))
report = @report_call report_config=report_config runtests(normpath(@__DIR__, ".."); targets="testjive jive")
show(report)
