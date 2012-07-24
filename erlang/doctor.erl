-module (doctor).
-export ([loop/0, loop_mon/0]).

loop() ->
  process_flag(trap_exit, true),
  receive
    new ->
      io:format("Creating and monitoring process.~n"),
      register(revolver, spawn_link(fun roulette:loop/0)),
      loop();
    {'EXIT', From, Reason} ->
      case Reason of
        {_, die, at, _} ->
          io:format("The process ~p died with reason ~p~n", [From, Reason]),
          self() ! new,
          loop();
        _ ->
          io:format("Respawn process ~p~n", [spawn(fun doctor:loop/0)]),
          loop()
      end
  end.

loop_mon() ->
  process_flag(trap_exit, true),
  receive
    new ->
      Process = spawn_link(fun roulette:loop/0),
      register(revolver, Process),
      io:format("[Doc ~p] Creating and monitoring process ~p.~n", [self(), Process]),
      loop_mon();
    {monitor, Process} ->
      link(Process),
      io:format("[Doc ~p] Linking monitor ~p.~n", [self(), Process]),
      loop_mon();
    {'EXIT', From, Reason} ->
      io:format("[Doc ~p] The process died from ~p with reason ~p~n", [self(), From, Reason]),
      case Reason of
        {_, die, at, _} ->
          self() ! new,
          loop_mon();
        normal ->
          Process = spawn(fun monitor_doctor:loop/0),
          Process ! {monitor, self()},
          io:format("[Doc ~p] Spawn new monitor process ~p~n", [self(), Process]),
          loop_mon();
        _ -> io:format("[Doc ~p] See you later.~n", [self()])
      end
  end.