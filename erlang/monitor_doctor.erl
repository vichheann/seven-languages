-module(monitor_doctor).
-export([loop/0]).
loop() ->
  process_flag(trap_exit, true),
  receive
    {monitor, Process} ->
      io:format("[Mon ~p] Linking doctor ~p.~n", [self(), Process]),
      link(Process),
      Process ! {monitor, self()},
      loop();
    {'EXIT', From, Reason} ->
      io:format("[Mon ~p] The process died from ~p with reason ~p.~n", [self(), From, Reason]),
      case Reason of
        normal -> % not very satisfying
          Process = spawn_link(fun doctor:loop_mon/0),
          io:format("[Mon ~p] Linking doctor ~p.~n", [self(), Process]),
          Process ! {monitor, self()},
          loop();
        _ -> io:format("[Mon ~p] See you later.~n", [self()])
      end
  end.


% c(doctor).
% c(monitor_doctor).
% Mon = spawn(fun monitor_doctor:loop/0).
% Doc = spawn(fun doctor:loop_mon/0).
% Mon ! {monitor, Doc}.
% Doc ! new.
% revolver ! 1.
% revolver ! 3.
% exit(Mon, "I'm dying").
