-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalytics = script:FindFirstAncestor("AvatarExperienceAnalytics")
local AvatarExperienceAnalyticsParent = AvatarExperienceAnalytics.Parent

local UnifiedLoggingSurface = require(AvatarExperienceAnalyticsParent.AvatarExperienceNavigation).Enums.UnifiedLoggingSurface

local MarketplaceSurfaceType = require(AvatarExperienceAnalytics.Enums.ImpressionEnums).MarketplaceSurfaceType

local tbl1 = {
    [MarketplaceSurfaceType.HOMEPAGE] = UnifiedLoggingSurface.CATALOG,
    [MarketplaceSurfaceType.SEARCH] = UnifiedLoggingSurface.SEARCH_RESULTS,
    [MarketplaceSurfaceType.ITEM_DETAIL] = UnifiedLoggingSurface.ITEM_DETAILS,
    [MarketplaceSurfaceType.COMMUNITY_PROFILE] = UnifiedLoggingSurface.COMMUNITY_PROFILE,
    [MarketplaceSurfaceType.USER_PROFILE] = UnifiedLoggingSurface.USER_PROFILE,
    [MarketplaceSurfaceType.DISCOVERY_HOMEPAGE] = UnifiedLoggingSurface.DISCOVERY_HOMEPAGE,
    [MarketplaceSurfaceType.DISCOVERY_SEARCH_RESULTS] = UnifiedLoggingSurface.DISCOVERY_SEARCH_RESULTS
}

local tbl2 = ({})
for _, value in MarketplaceSurfaceType do
    tbl2[value] = true
end
local tbl3 = ({})
for _, value in UnifiedLoggingSurface do
    if not tbl2[value] then
        tbl3[value] = true
    end
end

local function mapMarketplaceSurfaceToUnifiedLoggingSurface(num1: number?)
    if num1 == nil then
        return nil
    end
    local var1 = tbl1[num1]
    return if var1 == nil then if tbl3[num1] then num1 else nil else var1
end

return mapMarketplaceSurfaceToUnifiedLoggingSurface
