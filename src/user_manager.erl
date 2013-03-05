-module(user_manager).
 
-export([init/0, notify/1]).


init() ->
	{ok, PidUserManager} = gen_event:start_link({local,user_manager}),
	%Moved into twitter_app.erl: gen_event:add_handler(PidUserManager, user_event, []),
	%Moved into twitter_app.erl: gen_event:add_handler(PidUserManager, user_log, []),
{ok, PidUserManager}.
 
 notify(Event) ->
 		gen_event:notify(user_manager, Event).