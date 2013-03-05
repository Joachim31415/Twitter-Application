-module(twitter_sup).
-export([start_link/1, init/1]).
-behaviour(supervisor).

%start the supervisor from the application in the start callback

%Event managers will be started as children, but the handlers not (dont have any start link to begin with), they have to be registered elsewhere 
%The simple_one_for_one cannot take a list of children, its made dynamically.


-define(CHILD(Module, Args), {Module,
			{Module, start_link, Args},
			permanent, 5000, worker, [Module]})

start_link([]) ->
	supervisor:start_link(?MODULE, []).
 
init([]) ->
	MaxRestart = 5,
	MaxTime = 3600,
	{ok, {{one_for_one, MaxRestart, MaxTime},
		[?CHILD(gen_server, [{local, analytics}]), ?CHILD(gen_server, [{local, twitter}]), ?CHILD(gen_event, [{local,tweet_manager}]), ?CHILD(gen_event, [{local,user_manager}]), ?CHILD(gen_event, [{local,log_manager}])]}}.




