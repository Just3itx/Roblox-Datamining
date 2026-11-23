-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local UnifiedEventLogEnums = require(script.Parent.UnifiedEventLogEnums)
local UnifiedLoggingSurface = require(AvatarExperienceAnalyticsParent.AvatarExperienceNavigation).Enums.UnifiedLoggingSurface
local mutedError = require(AvatarExperienceAnalyticsParent.Loggers).mutedError
local sendAXCounterV2 = require(script.Parent.sendAXCounterV2)
local _UnifiedEventTypes = require(script.Parent.Generated.UnifiedEventTypes)
local FFlagAXUnifiedEventStrictPayloads = require(AvatarExperienceAnalyticsParent.AvatarExperienceFlags).FFlagAXUnifiedEventStrictPayloads

local function buildDiscoveryPurchaseAttempt(tbl1)
    local surface = tbl1.surface
    if surface ~= UnifiedLoggingSurface.DISCOVERY_HOMEPAGE and surface ~= UnifiedLoggingSurface.DISCOVERY_SEARCH_RESULTS
        or tbl1.hasWidgetAttribution
    then
        return nil
    end

    if tbl1.itemId == nil then
        local tbl2 = {
            reason = "missingItemId",
            surface = tostring(surface),
            itemType = tostring(tbl1.itemType),
            assetType = tostring(tbl1.assetType),
            bundleType = tostring(tbl1.bundleType),
            hasItemPrice = tostring(tbl1.itemPrice ~= nil)
        }
        mutedError("buildDiscoveryPurchaseAttempt: dropped discovery PURCHASE_ATTEMPT with no itemId", tbl2)
        sendAXCounterV2("DiscoveryPurchaseAttemptDropped", tbl2)
        return nil
    end

    local tbl2 = {
        action = UnifiedEventLogEnums.MarketplaceUnifiedAction.PURCHASE_ATTEMPT,
        itemId = if FFlagAXUnifiedEventStrictPayloads then tostring(tbl1.itemId) else tbl1.itemId,
        itemType = tbl1.itemType,
        surface = 0,
        organicItemPrice = 0,
        assetType = 0,
        bundleType = 0,
        cartId = 0
    }

    if FFlagAXUnifiedEventStrictPayloads and not surface then
        surface = UnifiedLoggingSurface.UNDEFINED_SURFACE
    end

    tbl2.surface = surface

    tbl2.organicItemPrice = tbl1.itemPrice
    tbl2.assetType = tbl1.assetType
    tbl2.bundleType = tbl1.bundleType
    tbl2.cartId = tbl1.cartId
    return tbl2
end

return buildDiscoveryPurchaseAttempt
