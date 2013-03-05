-module(init_twitter).
-author('joachim joachim@inakanetworks.com').
-export([init/0]).

init() -> 



	twitter:start_link(),



	%
	analytics:start_link(),
	tweet_manager:init(),
	log_manager:init(),
	user_manager:init(),
	log_handler:init([]),
	user_log:init([]),
	user_event:init([]),
	tweet_event:init([]),
	tweet_log:init([]).