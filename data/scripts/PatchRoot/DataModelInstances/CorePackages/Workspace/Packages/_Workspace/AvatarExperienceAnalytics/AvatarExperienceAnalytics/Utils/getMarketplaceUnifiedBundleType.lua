-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local BundleTypeIdStrings = require(AvatarExperienceAnalyticsParent.AvatarExperienceModel).Constants.BundleTypeIdStrings

local function getMarketplaceUnifiedBundleType(str1: string?)
    if str1 == nil then
        return nil
    end
    return tonumber(str1) or tonumber(BundleTypeIdStrings[str1])
end

return getMarketplaceUnifiedBundleType
