module test_pkgs_pkg

using Pkg
Pkg.develop("Jive")
Pkg.test("Jive", test_args=`start=16`)

end # module test_pkgs_pkg
