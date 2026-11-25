-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local RoactUtils = require(VirtualEvents.Parent.RoactUtils)
local LuaSocialLibrariesDeps = require(VirtualEvents.Parent.LuaSocialLibrariesDeps)
local useLocalization = require(VirtualEvents.Parent.Localization).Hooks.useLocalization
local getDeepValue = LuaSocialLibrariesDeps.SocialLibraries.config({}).Dictionary.getDeepValue
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local function useExperienceSubtitle(str1: string)
    local var1 = useSelector(function(arg1)
        local deepValue = getDeepValue(arg1, "GameVotes." .. str1 .. ".upVotes")
        local deepValue2 = getDeepValue(arg1, "GameVotes." .. str1 .. ".downVotes")

        if not (deepValue and deepValue2) then
            return nil
        end

        return math.round(100 * deepValue / (deepValue + deepValue2))
    end)

    if var1 == var1 and var1 then
        return useLocalization({ ratingPercentage = { "Feature.VirtualEvents.Label.Rating", rating = tostring(var1) } }).ratingPercentage
    end

    local var2 = useSelector(function(arg1)
        return arg1.AgeRecommendations and arg1.AgeRecommendations[str1]
    end)
    local ageRecommendation = var2 and var2.summary and var2.summary.ageRecommendation
    return ageRecommendation and ageRecommendation.displayNameWithHeaderShort
end

return useExperienceSubtitle
