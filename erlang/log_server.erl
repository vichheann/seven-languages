-module (log_server).
-export ([start_link/0]).
-export ([sendMessage_sync/1, sendMessage_async/1, shutdown/0]).
-export ([init/1, handle_call/3, handle_cast/2, terminate/2]).
-behaviour (gen_server).

start_link() -> gen_server:start_link({local, logger}, log_server, [], []).

init([]) -> {ok, []}.

handle_call({log, Message}, From, State) -> log(Message), {reply, "logged", ok}.

handle_cast(Request, State) ->
  case Request of
    {log, Message} -> log(Message), {noreply, ok};
    stop -> {stop, normal, State}
  end.

terminate(normal, State) -> "Bye, bye", ok.

% private server side

log(Message) ->
  file:write_file(server.log, format(Message), [append]).

format(Message) -> lists:flatten(io_lib:format("[~p]: ~p~n", [erlang:time(), Message])).

%%%%%%%%%%%%%%%%%%%%%%%%%
% Synchronous call
sendMessage_sync(Message) -> gen_server:call(logger, {log, Message}).

% Asynchronous call
sendMessage_async(Message) ->gen_server:cast(logger, {log,Message}).

shutdown() -> gen_server:cast(logger, stop).