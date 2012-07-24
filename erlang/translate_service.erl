-module(translate_service).
-export([loop/0, translate/2, monitor/0]).
-export([start_service/0, stop_service/0, start_translating/0, stop_translating/0, translate_d/2]).
-include_lib("eunit/include/eunit.hrl").

loop() ->
  receive
    {From, "casa"} ->
      From ! "house",
      loop();
    {From, "blanca"} ->
      From ! "white",
      loop();
    {From, stop} ->
      From ! "I'm dying",
      exit({translate_service,die,at,erlang:time()});
    {From, _} ->
      From ! "I don't understand",
      loop()
  end.

translate(To, Word) ->
  To ! {self(), Word},
  receive
    Translation -> Translation
  end.

monitor() ->
  process_flag(trap_exit, true),
  receive
    new ->
      io:format("Creating and monitoring process.~n"),
      register(translator, spawn_link(fun loop/0)),
      monitor();
    {'EXIT', From, Reason} ->
      io:format("The service ~p died with reason ~p.~n", [From, Reason]),
      self() ! new,
      monitor()
  end.

advanced_test_() ->
    {foreach, fun setup/0, fun teardown/1,
     [{"translator is ok", fun translator_test/0},
      {"monitor is ok", fun monitor_test/0}]}.

setup() -> Monitor = spawn(fun monitor/0), Monitor ! new.

teardown(X) -> X. %eunit:debugFmt("~w~n", [X]).

translator_test() ->
  [?_assert(translate(translator, "casa") =:= "house"),
   ?_assert(translate(translator, "blanca") =:= "white")].

monitor_test() ->
  translate(translator, stop),
  [?_assert(translate(translator, "blanca") =:= "white")].


%% Distributed %%
% t@server: start_service()
% x@client: start_translating(). translate ! {x@client, t@server, "casa"}.

service_loop() ->
  %io:format("The service_loop responding~n"),
  receive
    {From, Node, "casa"} ->
      {From, Node} ! "house",
      service_loop();
    {From, Node, "blanca"} ->
      {From, Node} ! "white",
      service_loop();
    {From, Node, stop} ->
      {From, Node} ! "I'm dying",
      exit({translate_service,die,at,erlang:time()});
    {From, Node, _} ->
      {From, Node} ! "I don't understand",
      service_loop()
  end.

start_service() -> register(translator, spawn(fun service_loop/0)).
stop_service() -> exit(whereis(translator), kill).

translate_loop() ->
  %io:format("The translate_loop responding~n"),
  receive
    Translation ->
      io:format("~p~n", [Translation]),
      translate_loop()
  end.

start_translating() -> register(translate, spawn(fun translate_loop/0)).
stop_translating() -> exit(whereis(translate), kill).

translate_d(Server, Word) -> {translator, Server} ! {translate, node(), Word}.
