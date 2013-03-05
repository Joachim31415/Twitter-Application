-module(twitter_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).


%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    {ok, PID} = twitter_sup:start_link([]),
    register_handlers(),
    {ok, PID}.

stop(_State) ->
    ok.


%% ===================================================================
%% Private Functions
%% ===================================================================

register_handlers() -> 
gen_event:add_handler(log_manager, log_handler, []),
gen_event:add_handler(user_manager, user_event, []),
gen_event:add_handler(user_manager, user_log, []),
gen_event:add_handler(tweet_manager, tweet_event, []),
gen_event:add_handler(tweet_manager, tweet_log, []).
