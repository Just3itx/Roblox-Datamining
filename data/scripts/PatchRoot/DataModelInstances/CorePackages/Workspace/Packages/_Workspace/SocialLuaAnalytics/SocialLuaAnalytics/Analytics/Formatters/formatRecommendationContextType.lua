-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local RecommendationContextTypes = require(scriptParentParentParent.Analytics.Enums).RecommendationContextTypes

local FFlagSocialCarouselMigrateRecommendations = require(scriptParentParentParentParent.SharedFlags).FFlagSocialCarouselMigrateRecommendations

return function(arg1)
    if arg1 == nil then
        return nil
    elseif FFlagSocialCarouselMigrateRecommendations then
        if type(arg1) ~= "string" then
            arg1 = arg1.rawValue()
        end

        local var1 = RecommendationContextTypes[arg1]

        if var1 then
            return (var1.rawValue())
        end

        return nil
    else
        return RecommendationContextTypes[arg1.rawValue()].rawValue()
    end
end
