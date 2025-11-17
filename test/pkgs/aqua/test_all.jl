module test_pkgs_aqua_test_all

using Jive
using Aqua
Aqua.test_all(Jive; stale_deps = false, piracies = false)
Aqua.test_stale_deps(Jive; ignore = [:Pkg])

end # module test_pkgs_aqua_test_all
