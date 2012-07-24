:- module(day_find,[fibonacci/2, fib/2, factorial/2, fact/2]).

fib(0,0).
fib(1,1).
fib(X,F) :- X1 is X - 1, X2 is X1 - 1, fib(X1,F1), fib(X2,F2), F is F1 + F2.

fibonacci(0,0,A,A).
fibonacci(1,0,A,A).
fibonacci(2,A,B,F) :- F is A + B.
fibonacci(X,TwoBack,OneBack,F) :- X > 0,  X1 is X - 1, C is OneBack + TwoBack, fibonacci(X1,OneBack,C,F).
fibonacci(X,F) :- fibonacci(X,0,1,F).

fact(0,1).
fact(X, F) :- X > 0, N is X - 1, fact(N,Z), F is X * Z.

factorial(0,A,A).
factorial(X,A,F) :- X > 0, X1 is X - 1, A1 is X * A, factorial(X1,A1,F).
factorial(X,F):- factorial(X,1,F).