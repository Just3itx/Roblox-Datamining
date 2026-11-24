-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailRodux = script:FindFirstAncestor("GameDetailRodux")
local GameDetailRoduxParent = GameDetailRodux.Parent

local Cryo = require(GameDetailRoduxParent.Cryo)
local SetAgeRecommendation = require(GameDetailRodux.AgeRecommendations.SetAgeRecommendation)

return function(arg1, arg2)
    arg1 = arg1 or {}

    if arg2.type == SetAgeRecommendation.name then
        local ageRecommendationDetails = arg2.ageRecommendationDetails
        arg1 = Cryo.Dictionary.join(arg1, { [arg2.universeId] = ageRecommendationDetails })
    end

    return arg1
end
