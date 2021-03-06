%% This Source Code Form is subject to the terms of the Mozilla Public
%% License, v. 2.0. If a copy of the MPL was not distributed with this
%% file, You can obtain one at http://mozilla.org/MPL/2.0/.
-module(push).
-export([main/0]).

main() ->
    application:start(chumak),
    {ok, Socket} = chumak:socket(push),

    case chumak:connect(Socket, tcp, "localhost", 5555) of
        {ok, _BindPid} ->
            io:format("Binding OK with Pid: ~p\n", [Socket]);
        {error, Reason} ->
            io:format("Connection Failed for this reason: ~p\n", [Reason]);
        X ->
            io:format("Unhandled reply for bind ~p \n", [X])
    end,
    loop(Socket, 1).

loop(Socket, Pos) ->
    io:format("Send..."),
    ok = chumak:send(Socket, <<"Hello A">>),
    ok = chumak:send(Socket, <<"Hello B">>),
    timer:sleep(1000),
    loop(Socket, Pos + 1).
