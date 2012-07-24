:- use_module(library(plunit)).
:- begin_tests(day2).

:- use_module(day2).
test(reverse) :- reverse([a,b,c,d], [d,c,b,a]).
test(revert) :- revert([a,b,c,d], [d,c,b,a]).
% [nondet] to avoid warning
test(mini, [nondet]) :- mini([2,3,1,6], 1).
test(my_sort, [nondet]) :- my_sort([5,2,3,1,6,4], [1,2,3,4,5,6]).

:- end_tests(day2).