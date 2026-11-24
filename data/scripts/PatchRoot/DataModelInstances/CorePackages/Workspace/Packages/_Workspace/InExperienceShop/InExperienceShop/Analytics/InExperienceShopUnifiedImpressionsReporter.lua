-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:51:19Z
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

local function InExperienceShopUnifiedImpressionsReporter(str1: string)
    return function(tbl1)
        local visibleInstance = tbl1.visibleInstance

        local surface = getShopUnifiedLoggingSurface(str1)
        local filter = if FFlagAllowCustomUnifiedEventFilter then InExperienceShopUnifiedEventFilter.filter else nil

        if not FFlagAXUnifiedEventStrictPayloads then
            sendUnifiedEventLogForInstance(
                visibleInstance,
                {
                    action = UnifiedEventLogEnums.MarketplaceUnifiedAction.ITEM_IMPRESSION,
                    surface = surface
                },
                { includeScreenSize = true, includeElementSizeAndPosition = true, filter = filter }
            )

            return
        end

        local attributePrefix = UnifiedEventLogConstants.ATTRIBUTE_PREFIX
        local attributes = visibleInstance:GetAttributes()

        sendPassthroughUnifiedEventLogForInstance(
            visibleInstance,
            {
                action = UnifiedEventLogEnums.MarketplaceUnifiedAction.ITEM_IMPRESSION,
                surface = surface,
                itemId = attributes[attributePrefix .. UnifiedEventLogConstants.FIELD_ITEM_ID],
                itemType = attributes[attributePrefix .. UnifiedEventLogConstants.FIELD_ITEM_TYPE],
                gridPositionRow = attributes[attributePrefix .. UnifiedEventLogConstants.FIELD_GRID_POSITION_ROW],
                gridPositionColumn = attributes[attributePrefix .. UnifiedEventLogConstants.FIELD_GRID_POSITION_COLUMN]
            },
            { includeScreenSize = true, includeElementSizeAndPosition = true, filter = filter }
        )
    end
end

return InExperienceShopUnifiedImpressionsReporter
