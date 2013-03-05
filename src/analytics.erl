-module(analytics).
-behaviour(gen_server).
-define(SERVER, ?MODULE).

-record(state, {
	
				user_count = 0 :: integer(), 
				tweet_count = 0 :: integer() 

				}).

%% ------------------------------------------------------------------
%% API Function Exports
%% ------------------------------------------------------------------

-export([start_link/0, add_user/0, add_tweet/0]).

%% ------------------------------------------------------------------
%% gen_server Function Exports
%% ------------------------------------------------------------------

-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).



%% ------------------------------------------------------------------
%% API Function Definitions
%% ------------------------------------------------------------------

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

add_user() ->
	gen_server:call(?SERVER, increment_user).

add_tweet() ->
	gen_server:call(?SERVER, increment_tweet).


%% ------------------------------------------------------------------
%% gen_server Function Definitions
%% ------------------------------------------------------------------



init([]) ->
    {ok, #state{}}.


handle_call(increment_user, _From, State = #state{user_count = UserCount}) ->
	NewState = State#state{user_count = UserCount +1},
    {reply, ok, NewState};

handle_call(increment_tweet, _From, State = #state{tweet_count = TweetCount}) ->
	NewState = State#state{tweet_count = TweetCount +1},
    {reply, ok, NewState}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% ------------------------------------------------------------------
%% Internal Function Definitions
%% ------------------------------------------------------------------