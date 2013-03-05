-module(tweet_log).
-behaviour(gen_event).
 
-export([init/1, handle_event/2, handle_call/2, handle_info/2, code_change/3,
terminate/2]).



init([]) ->
{ok, []}.

 
handle_event({tweet_added, NewTweet}, State) ->
	log_manager:add_tweet(NewTweet),
	{ok, State}.

 
 
handle_call(_, State) ->
{ok, ok, State}.
 
handle_info(_, State) ->
{ok, State}.
 
code_change(_OldVsn, State, _Extra) ->
{ok, State}.
 
terminate(_Reason, _State) ->
ok.