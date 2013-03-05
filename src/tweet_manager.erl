-module(tweet_manager).
 
-export([init/0, add_tweet/1]).
 

init() ->
	%transform into child specification, in the application specification or in a separate module. 
	{ok, PidTweetManager} = gen_event:start_link({local,tweet_manager}),

	%Moved into twitter_app.erl: gen_event:add_handler(PidTweetManager, tweet_event, []),
	%Moved into twitter_app.erl: gen_event:add_handler(PidTweetManager, tweet_log, []),
{ok, PidTweetManager}.

add_tweet(NewTweet) ->
	Event = {tweet_added, NewTweet},
	gen_event:notify(tweet_manager, Event).


