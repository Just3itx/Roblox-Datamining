-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalytics = script:FindFirstAncestor("AvatarExperienceAnalytics")
local AvatarExperienceAnalyticsParent = AvatarExperienceAnalytics.Parent

local _AvatarExperienceModel = require(AvatarExperienceAnalyticsParent.AvatarExperienceModel)
local UnifiedEventLogEnums = require(AvatarExperienceAnalytics.UnifiedEventLogEnums)

local function getMarketplaceUnifiedItemType(arg1)
    if arg1 == "Look" then
        return UnifiedEventLogEnums.MarketplaceUnifiedItemType.LOOK
    elseif arg1 == "Asset" then
        return UnifiedEventLogEnums.MarketplaceUnifiedItemType.ASSET
    elseif arg1 == "Bundle" then
        return UnifiedEventLogEnums.MarketplaceUnifiedItemType.BUNDLE
    end

    return nil
end

return getMarketplaceUnifiedItemType
