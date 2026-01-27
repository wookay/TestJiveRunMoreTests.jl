module test_pkgs_testextras

using Test
using TestExtras

f(x) = 2x

@testinferred f(1) constprop = true

end # module test_pkgs_testextras
