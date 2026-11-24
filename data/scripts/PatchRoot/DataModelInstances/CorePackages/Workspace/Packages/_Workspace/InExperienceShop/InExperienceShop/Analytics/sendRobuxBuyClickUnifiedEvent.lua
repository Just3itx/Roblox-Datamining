-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local AvatarExperienceAnalytics = require(InExperienceShopParent.AvatarExperienceAnalytics)
local UnifiedEventLogEnums = AvatarExperienceAnalytics.UnifiedEventLogEnums

local sendUnifiedEventLogForInstance = AvatarExperienceAnalytics.sendUnifiedEventLogForInstance
local FFlagAllowCustomUnifiedEventFilter = AvatarExperienceAnalytics.Flags.FFlagAllowCustomUnifiedEventFilter
local UnifiedEventLogConstants = AvatarExperienceAnalytics.UnifiedEventLogConstants
local sendPassthroughUnifiedEventLogForInstance = AvatarExperienceAnalytics.sendPassthroughUnifiedEventLogForInstance
local FFlagAXUnifiedEventStrictPayloads = AvatarExperienceAnalytics.Flags.FFlagAXUnifiedEventStrictPayloads

local InExperienceShopUnifiedEventFilter = require(script.Parent.InExperienceShopUnifiedEventFilter)
local getShopUnifiedLoggingSurface = require(script.Parent.getShopUnifiedLoggingSurface)

local function sendRobuxBuyClickUnifiedEvent(arg1, str1: string?)
    local surface = getShopUnifiedLoggingSurface(str1)
    local filter = if FFlagAllowCustomUnifiedEventFilter then InExperienceShopUnifiedEventFilter.filter else nil

    if not FFlagAXUnifiedEventStrictPayloads then
        sendUnifiedEventLogForInstance(
            arg1,
            {
                action = UnifiedEventLogEnums.MarketplaceUnifiedAction.PURCHASE_ATTEMPT,
                surface = surface
            },
            { includeScreenSize = true, includeElementSizeAndPosition = true, filter = filter }
        )

        return
    end

    local attributePrefix = UnifiedEventLogConstants.ATTRIBUTE_PREFIX
    local attributes = arg1:GetAttributes()

    sendPassthroughUnifiedEventLogForInstance(
        arg1,
        {
            action = UnifiedEventLogEnums.MarketplaceUnifiedAction.PURCHASE_ATTEMPT,
            surface = surface,
            itemId = attributes[attributePrefix .. UnifiedEventLogConstants.FIELD_ITEM_ID],
            itemType = attributes[attributePrefix .. UnifiedEventLogConstants.FIELD_ITEM_TYPE]
        },
        { includeScreenSize = true, includeElementSizeAndPosition = true, filter = filter }
    )
end

return sendRobuxBuyClickUnifiedEvent
