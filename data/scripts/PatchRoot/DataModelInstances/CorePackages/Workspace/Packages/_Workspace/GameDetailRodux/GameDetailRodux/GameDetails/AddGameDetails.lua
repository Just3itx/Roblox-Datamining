-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailRoduxParent = script:FindFirstAncestor("GameDetailRodux").Parent

return require(GameDetailRoduxParent.Rodux).makeActionCreator(script.Name, function(gameDetails)
    return { gameDetails = gameDetails }
end)
