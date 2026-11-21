-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameVotesRodux = script:FindFirstAncestor("GameVotesRodux")
local GameVotesRoduxParent = GameVotesRodux.Parent
local Immutable = require(GameVotesRoduxParent.AppCommonLib).Immutable
local SetUserGameVotes = require(GameVotesRodux.UserGameVotes.SetUserGameVotes)
local ClearUserGameVotes = require(GameVotesRodux.UserGameVotes.ClearUserGameVotes)

return function(arg1, arg2)
    arg1 = arg1 or {}

    if arg2.type ~= SetUserGameVotes.name then
        if arg2.type == ClearUserGameVotes.name then
            arg1 = Immutable.Set(arg1, arg2.universeId, nil)
        end

        return arg1
    end

    local tbl1 = {
        canVote = arg2.canVote,
        userVote = arg2.userVote,
        reasonForNotVoteable = arg2.reasonForNotVoteable
    }

    return (Immutable.Set(arg1, arg2.universeId, tbl1))
end
