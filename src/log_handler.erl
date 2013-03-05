-module(log_handler).
-behaviour(gen_event).
 
-export([init/1, handle_event/2, handle_call/2, handle_info/2, code_change/3,
terminate/2]).


-record(state, {

				logs = [] :: list(), 
				file_id :: pid() 

				}).

init([]) ->
{ok, IoDevice} = file:open("twitter.log", [write]),
{ok, #state{file_id = IoDevice}}.


handle_event({EventType, EventDesc, DateStamp}, State = #state{logs = Logs, file_id = FileId}) ->
	NewState = State#state{logs = [{EventType, EventDesc, DateStamp} | Logs]},
	io:format("[~p] ~p: ~p ~n ~n current state: ~n ~p", [DateStamp, EventType, EventDesc, NewState]),
	ListEventType = atom_to_list(EventType),
	file:write(FileId, list_to_binary(ListEventType ++ ": " ++ EventDesc ++ "\n")),
	{ok, NewState}.
 

% Ask Brujo why this does not work when State is a list
%handle_event({tweet_added, NewTweet, DateStamp}, State) ->
% 	NewState = [{tweet_added, NewTweet, DateStamp} | State],
%	{ok, NewState}.
 
handle_call(_, State) ->
{ok, ok, State}.
 
handle_info(_, State) ->
{ok, State}.
 
code_change(_OldVsn, State, _Extra) ->
{ok, State}.
 
terminate(_Reason, _State) ->
ok.