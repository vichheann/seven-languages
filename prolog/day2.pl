:- module(day2,[reverse/2, revert/2, mini/2, my_sort/2]).

concat([],List,List).
concat([H|T1],List,[H|T2]) :- concat(T1,List,T2).

reverse([X|T], R) :- reverse(T, R1), concat(R1, [X], R).
reverse([],[]).

revert([H|T], A, R) :- revert(T,[H|A],R).
revert([],X,X).
revert(X,R) :- revert(X, [], R).

mini([X], X).
mini([X|T], M) :- mini(T, M1), M is min(X,M1).

take(X, [X|T], T).
take(X, [H|T], [H|S]) :- take(X, T, S).

list_processor([],R) :- e(R).
list_processor([H|T],R) :- list_processor(T,TR), insert_sort(H,TR,R).

e([]).
insert_sort(X, [], [X]).
insert_sort(X, [Y|T], [X,Y|T]) :- X =< Y.
insert_sort(X, [Y|T], [Y|R]) :- X > Y, insert_sort(X, T, R).

my_sort(X,T) :- list_processor(X,T).

