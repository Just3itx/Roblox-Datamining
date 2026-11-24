-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailRodux = script:FindFirstAncestor("GameDetailRodux")
local GameDetailRoduxParent = GameDetailRodux.Parent

local Cryo = require(GameDetailRoduxParent.Cryo)
local SetAgeRecommendationHeaders = require(GameDetailRodux.AgeRecommendations.SetAgeRecommendationHeaders)

return function(arg1, arg2)
    arg1 = arg1 or {}

    if arg2.type == SetAgeRecommendationHeaders.name then
        arg1 = Cryo.Dictionary.join(
            arg1,
            {
                headerDisplayName = arg2.headerDisplayName,
                headerDisplayNameShort = arg2.headerDisplayNameShort
            }
        )
    end
    return arg1
end
