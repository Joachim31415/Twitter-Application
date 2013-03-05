-module(log_manager).
 
-export([init/0, add_user/1, add_tweet/1]).
 

 init() ->
	{ok, PidLogManager} = gen_event:start_link({local,log_manager}),
	%Moved into twitter_app.erl: gen_event:add_handler(PidLogManager, log_handler, []),
{ok, PidLogManager}.
 
 add_user(NewUser) ->
 	DateStamp = calendar:local_time(),
 	Event = {user_added, NewUser, DateStamp},
 	gen_event:notify(log_manager, Event).

 add_tweet(NewTweet) ->
  	DateStamp = calendar:local_time(),
 	Event = {tweet_added, NewTweet, DateStamp},
 	gen_event:notify(log_manager, Event).