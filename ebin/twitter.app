{application, twitter,
 [{vsn, "1.0.0"},
  {modules, [analytics, twitter, twitter_manager, log_manager, user_manager, log_handler, user_log, user_event, tweet_event, tweet_log]},
  {registered, [twitter]},
  {mod, {twitter_app, []}}
 ]}.


%start with gen servers, then event managers and after this the handlers. 