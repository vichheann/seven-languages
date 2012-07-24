-module(day1).
-export([wc/1, count_to_ten/0, print/1]).
-include_lib("eunit/include/eunit.hrl").

% use recursion to count words
wc(S) -> wc(S, 0).
wc([], Acc) -> Acc;
wc([_], Acc) -> Acc + 1;
wc([32|R], Acc) -> wc(R, Acc + 1);
wc([_|R], Acc) -> wc(R, Acc).

wc_test_() ->
  [?_assert(wc("") =:= 0),
   ?_assert(wc("one") =:= 1),
   ?_assert(wc("Let it crash") =:= 3)].


% use recursion to count to ten
count_to_ten() -> count_to(10, []).
count_to(0, Acc) -> Acc;
count_to(X, Acc) -> count_to(X-1, [X|Acc]).

count_to_ten_test_() -> ?_assert(count_to_ten() =:= [1,2,3,4,5,6,7,8,9,10]).

% use matching to selectively print "success" or error:Message given {error, Message} or success
print({error, Message}) -> string:concat("error: ", Message);
print(success) -> "success".

print_test_() ->
  [?_assert(print({error, "An error has occured"}) =:= "error: An error has occured"),
   ?_assert(print(success) =:= "success")].
