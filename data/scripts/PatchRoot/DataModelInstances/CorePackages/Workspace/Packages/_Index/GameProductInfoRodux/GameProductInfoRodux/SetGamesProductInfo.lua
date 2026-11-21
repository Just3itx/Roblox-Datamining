-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T21:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameProductInfoRoduxParent = script:FindFirstAncestor("GameProductInfoRodux").Parent
return require(GameProductInfoRoduxParent.Rodux).makeActionCreator(script.Name, function(gamesProductInfo)
    return { gamesProductInfo = gamesProductInfo }
end)
