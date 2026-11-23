-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AchievementsParent = script:FindFirstAncestor("Achievements").Parent
local Cryo = require(AchievementsParent.Cryo)
local var1 = require(AchievementsParent.Rodux).createReducer(
    {
        gameVoteStatus = {},
        voteCountSinceAppStart = 0,
        lastUniverseId = -1
    },
    {
        SetUserGameVotes = function(tbl1, tbl2)
            local universeId = tbl2.universeId
            local userVote = tbl2.userVote
            local canVote = tbl2.canVote

            local gameVoteStatus = tbl1.gameVoteStatus
            local voteCountSinceAppStart = tbl1.voteCountSinceAppStart
            local lastUniverseId = tbl1.lastUniverseId

            if canVote and gameVoteStatus[universeId] and gameVoteStatus[universeId] ~= userVote and userVote ~= "NotVoted" then
                voteCountSinceAppStart += 1
                lastUniverseId = universeId
            end

            local var1 = Cryo.Dictionary.join(gameVoteStatus, { [universeId] = userVote })
            return Cryo.Dictionary.join(
                tbl1,
                {
                    gameVoteStatus = var1,
                    voteCountSinceAppStart = voteCountSinceAppStart,
                    lastUniverseId = lastUniverseId
                }
            )
        end
    }
)

return function(arg1, arg2)
    return var1(arg1, arg2)
end
