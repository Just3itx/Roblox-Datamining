-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameVotesRoduxParent = script:FindFirstAncestor("GameVotesRodux").Parent
return require(GameVotesRoduxParent.Rodux).makeActionCreator(script.Name, function(universeId: string)
    assert(type(universeId) == "string", "ClearUserGameVotes: universeId must be a string")

    return { universeId = universeId }
end)
