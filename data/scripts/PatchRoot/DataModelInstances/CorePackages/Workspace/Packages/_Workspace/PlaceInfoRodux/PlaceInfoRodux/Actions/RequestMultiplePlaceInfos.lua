-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlaceInfoRoduxParent = script:FindFirstAncestor("PlaceInfoRodux").Parent

return require(PlaceInfoRoduxParent.Rodux).makeActionCreator(script.Name, function(placeIds)
    return { placeIds = placeIds }
end)
