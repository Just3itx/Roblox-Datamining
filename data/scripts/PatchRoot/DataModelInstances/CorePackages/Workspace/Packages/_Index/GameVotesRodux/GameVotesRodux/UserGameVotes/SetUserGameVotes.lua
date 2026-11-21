-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameVotesRoduxParent = script:FindFirstAncestor("GameVotesRodux").Parent
return require(GameVotesRoduxParent.Rodux).makeActionCreator(script.Name, function(universeId: string, canVote: boolean, userVote: string, reasonForNotVoteable: string)
    assert(type(universeId) == "string", "SetUserGameVotes: universeId must be a string")
    assert(type(canVote) == "boolean", "SetUserGameVotes: canVote must be a boolean")
    assert(type(userVote) == "string", "SetUserGameVotes: userVote must be a string")
    assert(type(reasonForNotVoteable) == "string", "SetUserGameVotes: reasonForNotVoteable must be a string")

    return {
        universeId = universeId,
        canVote = canVote,
        userVote = userVote,
        reasonForNotVoteable = reasonForNotVoteable
    }
end)
