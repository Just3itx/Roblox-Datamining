-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlayabilityRoduxParent = script:FindFirstAncestor("PlayabilityRodux").Parent

return require(PlayabilityRoduxParent.Rodux).makeActionCreator(script.Name, function(playabilityStatus)
    assert(type(playabilityStatus) == "table", "SetPlayabilityStatus action expects playabilityStatus to be a table")

    return { playabilityStatus = playabilityStatus }
end)
