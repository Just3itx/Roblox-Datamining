-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalytics = script:FindFirstAncestor("AvatarExperienceAnalytics")

local UnifiedEventLogEnums = require(AvatarExperienceAnalytics.UnifiedEventLogEnums)
local UnifiedEventLoggingUtils = require(AvatarExperienceAnalytics.Utils.UnifiedEventLoggingUtils)

local function getMarketplaceUnifiedLookType(str1: string?)
    if str1 == nil then
        return nil
    end

    return UnifiedEventLogEnums.MarketplaceLookType[UnifiedEventLoggingUtils.formatLookTypeAttribute(str1)]
end

return getMarketplaceUnifiedLookType
