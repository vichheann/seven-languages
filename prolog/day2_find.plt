:- use_module(library(plunit)).
:- begin_tests(day2_find).

:- use_module(day2_find).
% use assertion just for fun
test(fibonacci, [nondet]) :- fibonacci(10, N), assertion(N == 55).
test(fib, [nondet]) :- fib(10, N), assertion(N == 55).
test(factorial, [nondet]) :- factorial(5, N), assertion(N == 120).
test(fact, [nondet]) :- factorial(5, N), assertion(N == 120).

:- end_tests(day2_find).