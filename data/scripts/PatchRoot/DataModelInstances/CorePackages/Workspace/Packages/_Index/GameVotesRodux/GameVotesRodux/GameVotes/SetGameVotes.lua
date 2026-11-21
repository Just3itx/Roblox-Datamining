-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:00:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameVotesRoduxParent = script:FindFirstAncestor("GameVotesRodux").Parent
return require(GameVotesRoduxParent.Rodux).makeActionCreator(script.Name, function(universeId: string, upVotes: number, downVotes: number)
    assert(type(universeId) == "string", "SetGameVotes: universeId must be a string")
    assert(type(upVotes) == "number", "SetGameVotes: upVotes must be a number")
    assert(type(downVotes) == "number", "SetGameVotes: downVotes must be a number")

    return { universeId = universeId, upVotes = upVotes, downVotes = downVotes }
end)
