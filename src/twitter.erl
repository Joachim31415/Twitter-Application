-module(twitter).
-behaviour(gen_server).
-define(SERVER, ?MODULE).

%% ------------------------------------------------------------------
%% API Function Exports
%% ------------------------------------------------------------------

-export([start_link/0, create_user/1, login_user/1, create_tweet/2]).

%% ------------------------------------------------------------------
%% gen_server Function Exports
%% ------------------------------------------------------------------

-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

%% ------------------------------------------------------------------
%% API Function Definitions
%% ------------------------------------------------------------------

-record(state, {
	
				users = [] :: list(), 
				tweets = [] :: list()

				}).

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

create_user(Name) ->
    gen_server:call(?SERVER, {create_user, Name}).

login_user(Name) ->
	gen_server:call(?SERVER, {login_user, Name}).

create_tweet(Tweet, Name) ->
	gen_server:call(?SERVER, {create_tweet, Tweet, Name}).



%% ------------------------------------------------------------------
%% gen_server Function Definitions
%% ------------------------------------------------------------------


init([]) ->
    {ok, #state{}}.

handle_call({create_user, Name}, _From, State = #state{users = Users}) ->
	NewState = State#state{users = [{Name, not_logged_in} | Users]},
	user_manager:notify({new_user_created, Name}),
    {reply, ok, NewState};


handle_call({login_user, Name}, _From, State = #state{users = Users}) ->
	UpdatedUserlist = lists:keyreplace(Name, 1, Users, {Name, logged_in}),
	NewState = State#state{users = UpdatedUserlist},
    {reply, ok, NewState};

handle_call({create_tweet, Tweet, Name}, _From, State = #state{users = Users, tweets = Tweets}) ->
	LoginStatus = lists:keyfind(Name, 1, Users),
	case LoginStatus of
		{Name, logged_in} ->
			NewState = State#state{tweets = [{Name, Tweet} | Tweets]},
			tweet_manager:add_tweet(Name ++ ": " ++ Tweet);
		_Else ->
			NewState = State,
			io:format("User not logged in, call twitter:login_user/1 with a username")
	end,
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


