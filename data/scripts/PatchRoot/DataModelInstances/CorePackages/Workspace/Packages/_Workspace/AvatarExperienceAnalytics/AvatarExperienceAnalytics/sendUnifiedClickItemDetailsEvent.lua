-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local SharedFlags = require(AvatarExperienceAnalyticsParent.SharedFlags)
local _AvatarExperienceNavigation = require(AvatarExperienceAnalyticsParent.AvatarExperienceNavigation)
local _AvatarExperienceModel = require(AvatarExperienceAnalyticsParent.AvatarExperienceModel)

local sendUnifiedEventForDeferredAction = require(script.Parent.sendUnifiedEventForDeferredAction)
local getMarketplaceUnifiedItemType = require(script.Parent.Utils.getMarketplaceUnifiedItemType)
local getUnifiedLoggingSurface = require(script.Parent.Utils.getUnifiedLoggingSurface)
local UnifiedEventLogEnums = require(script.Parent.UnifiedEventLogEnums)

local FFlagAXFixClickItemDetailsSurfaceLogging = SharedFlags.FFlagAXFixClickItemDetailsSurfaceLogging

local function sendUnifiedClickItemDetailsEvent(tbl1)
    sendUnifiedEventForDeferredAction({
        action = UnifiedEventLogEnums.MarketplaceUnifiedAction.UI_ELEMENT_CLICK,
        elementName = "CLICK_ITEM_DETAILS",
        itemId = tbl1.itemId,
        itemType = getMarketplaceUnifiedItemType(tbl1.itemType),
        surface = if FFlagAXFixClickItemDetailsSurfaceLogging then getUnifiedLoggingSurface(tbl1.avatarRoute) else nil
    })
end

return sendUnifiedClickItemDetailsEvent
