-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local GameVotesRodux = script:FindFirstAncestor("GameVotesRodux")
local GameVotesRoduxParent = GameVotesRodux.Parent
local Url = require(GameVotesRoduxParent.Http).Url
local VoteStatus = require(GameVotesRodux.Enums.VoteStatus)

local tbl1 = {
    [VoteStatus.VotedUp] = true,
    [VoteStatus.VotedDown] = false,
    [VoteStatus.NotVoted] = "null"
}

return function(arg1, str1: string, arg2)
    assert(type(str1) == "string", "GamesPatchUserVotes request expects universeId to be a string")

    local vote = tbl1[arg2]
    assert(vote ~= nil, "GamesPatchUserVotes request expects a valid vote")

    return arg1(
        string.format("%sv1/games/%s/user-votes", Url.GAME_URL, str1),
        "PATCH",
        {
            postBody = HttpService:JSONEncode({ vote = vote })
        }
    )
end
