-module(nxo_wiki).

-export([
         source/0
        ]).

source() ->
  Sources = application:get_env(nxo_wiki, md_source, []),
  compute_source_dirs(Sources, []).

compute_source_dirs([], Acc) ->
  Acc;
compute_source_dirs([H|T], Acc) ->
  Dir = case H of
          {priv_dir, App, SubDir} ->
            Priv = code:priv_dir(App),
            filename:join(Priv, SubDir);
          {path, Path} ->
            Path
        end,
  compute_source_dirs(T, [Dir, Acc]).
