:- module(day3_bonus,[eight_queens/1]).
:- use_module(library(clpfd)).
:- use_module(library(lists)).

valid_queen((_,Y)) :- member(Y, [1,2,3,4,5,6,7,8]).

valid_board([]).
valid_board([H|T]) :- valid_queen(H), valid_board(T).

cols([], []).
cols([(_, Col)|QueensTail], [Col|ColsTail]) :- cols(QueensTail, ColsTail).

diags1([], []).
diags1([(Row, Col)|QueensTail], [Diagonal|DiagTail]) :-
  Diagonal is Col - Row, diags1(QueensTail, DiagTail).

diags2([], []).
diags2([(Row, Col)|QueensTail], [Diagonal|DiagTail]) :-
  Diagonal is Col + Row, diags2(QueensTail, DiagTail).

eight_queens(Board) :- Board = [(1, _), (2, _), (3, _), (4, _), (5, _), (6, _), (7, _), (8, _)],
                      valid_board(Board),
                      cols(Board, Cols),
                      diags1(Board, Diags1),
                      diags2(Board, Diags2),
                      all_different(Cols),
                      all_different(Diags1),
                      all_different(Diags2).
