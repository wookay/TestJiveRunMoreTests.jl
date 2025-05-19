expect_failures:
	JULIA_TEST_FAILFAST=1 JIVE_SKIP=x julia runtests.jl fails/test             && echo "🚨 success" || echo "🟢 failure"
	JULIA_TEST_FAILFAST=1 JIVE_SKIP=x julia runtests.jl errors/issue63.jl      && echo "🚨 success" || echo "🟢 failure"
	JULIA_TEST_FAILFAST=1 JIVE_SKIP=x julia runtests.jl errors/testset_let.jl  && echo "🚨 success" || echo "🟢 failure"
	JULIA_TEST_FAILFAST=1 JIVE_SKIP=x julia runtests.jl errors/error1.jl       && echo "🚨 success" || echo "🟢 failure"
	JULIA_TEST_FAILFAST=1 JIVE_SKIP=x julia runtests.jl errors/error2.jl       && echo "🚨 success" || echo "🟢 failure"
