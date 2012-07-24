-module(day2).
-export([getValue/2, totalPrice/1, tic_tac_toe/1]).
-include_lib("eunit/include/eunit.hrl").

% a function that accepts the list and a keyword and returns the associated value for the keyword

getValue([], _) -> [];
getValue(L, I) -> [V || {K,V} <- L, K =:= I].


getValue_with_empty_list_test_() -> ?_assert(getValue([], unknown) =:= []).

getValue_test_() ->
  Languages = [{erlang, "a functional language"},
               {ruby, "a OO language"},
               {cobol, "an old language"},
               {ruby, "a cool language"}],
  [?_assert(getValue(Languages, unknown) =:= []),
   ?_assert(getValue(Languages, ruby) =:= ["a OO language", "a cool language"])].


% a function that builds a list of items with total price
totalPrice([]) -> [];
totalPrice(Items) -> [ {Item, Quantity * Price} || {Item, Quantity, Price} <- Items ].

totalPrice_with_empty_list_test_() -> [?_assert(totalPrice([]) =:= [])].
totalPrice_test_() ->
  Shopping = [{pencil, 4, 0.25},
              {pen, 1, 1.20},
              {paper, 2, 0.2}],
  ?_assert(totalPrice(Shopping) =:= [{pencil, 1.0}, {pen, 1.2}, {paper, 0.4}]).

% read a tic-tac-toe, returns the winner(x or o) or cat if no possible move or no_winner

print_winner_is(X) -> lists:flatten(io_lib:format("winner is ~s", [X])).

tic_tac_toe(Board) ->
  case Board of
    [[X,X,X],
     [_,_,_],
     [_,_,_]] -> print_winner_is(X);

    [[_,_,_],
     [X,X,X],
     [_,_,_]] -> print_winner_is(X);

    [[_,_,_],
     [_,_,_],
     [X,X,X]] -> print_winner_is(X);

    [[X,_,_],
     [X,_,_],
     [X,_,_]] -> print_winner_is(X);

    [[_,X,_],
     [_,X,_],
     [_,X,_]] -> print_winner_is(X);

    [[_,_,X],
     [_,_,X],
     [_,_,X]] -> print_winner_is(X);

    [[X,_,_],
     [_,X,_],
     [_,_,X]] -> print_winner_is(X);

    [[_,_,X],
     [_,X,_],
     [X,_,_]] -> print_winner_is(X);

    _ -> case lists:any(fun(X) -> X == n end, lists:flatten(Board)) of
          true -> "cat";
          false -> "no winner"
        end
  end.

tic_tac_toe_horizontal_winner_test_() ->
  [?_assert(tic_tac_toe([[x,x,x],
                         [x,o,x],
                         [o,o,x]]) == "winner is x"),

   ?_assert(tic_tac_toe([[x,o,o],
                         [x,x,x],
                         [o,o,x]]) == "winner is x"),

   ?_assert(tic_tac_toe([[o,x,o],
                         [o,x,o],
                         [x,x,x]]) == "winner is x")].


tic_tac_toe_vertical_winner_test_() ->
  [?_assert(tic_tac_toe([[x,o,o],
                         [x,x,o],
                         [x,o,x]]) == "winner is x"),

   ?_assert(tic_tac_toe([[o,x,x],
                         [x,x,o],
                         [o,x,o]]) == "winner is x"),

   ?_assert(tic_tac_toe([[o,x,x],
                         [o,o,x],
                         [x,o,x]]) == "winner is x")].


tic_tac_toe_cross_test_() ->
  [?_assert(tic_tac_toe([[o,x,x],
                         [x,o,o],
                         [x,o,o]]) == "winner is o"),

   ?_assert(tic_tac_toe([[o,x,x],
                         [o,x,o],
                         [x,o,o]]) == "winner is x")].


tic_tac_toe_no_winner_test_() ->
  [?_assert(tic_tac_toe([[x,o,o],
                         [o,x,x],
                         [o,x,o]]) == "no winner"),

   ?_assert(tic_tac_toe([[o,x,o],
                         [o,x,x],
                         [x,o,o]]) == "no winner")].

tic_tac_toe_cat_test_() ->
  ?_assert(tic_tac_toe([[x,o,o],
                        [o,n,x],
                        [o,x,o]]) == "cat").

