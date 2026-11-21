-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameVotesRoduxParent = script:FindFirstAncestor("GameVotesRodux").Parent
local Url = require(GameVotesRoduxParent.Http).Url

return function(arg1, str1: string)
    assert(type(str1) == "string", "GetGameVotes request expects universeId to be a string")

    return arg1(string.format("%sv1/games/%s/votes", Url.GAME_URL, str1), "GET")
end
