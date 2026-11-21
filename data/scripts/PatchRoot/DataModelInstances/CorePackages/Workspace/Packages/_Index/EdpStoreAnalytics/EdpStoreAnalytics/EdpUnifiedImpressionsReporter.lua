-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:50:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EdpStoreAnalytics = script:FindFirstAncestor("EdpStoreAnalytics")
local EdpStoreAnalyticsParent = EdpStoreAnalytics.Parent

local Cryo = require(EdpStoreAnalyticsParent.Cryo)

local AvatarExperienceAnalytics = require(EdpStoreAnalyticsParent.AvatarExperienceAnalytics)
local UnifiedEventLogEnums = AvatarExperienceAnalytics.UnifiedEventLogEnums
local UnifiedLoggingSurface = require(EdpStoreAnalyticsParent.AvatarExperienceNavigation).Enums.UnifiedLoggingSurface
local sendUnifiedEventLogForInstance = AvatarExperienceAnalytics.sendUnifiedEventLogForInstance

local Constants = require(EdpStoreAnalytics.Constants)

local function EdpUnifiedImpressionsReporter(edp: string)
    return function(tbl1)
        local visibleInstance = tbl1.visibleInstance
        local attributes = visibleInstance:GetAttributes() or {}

        sendUnifiedEventLogForInstance(
            visibleInstance,
            Cryo.Dictionary.join(attributes, {
                action = UnifiedEventLogEnums.MarketplaceUnifiedAction.ITEM_IMPRESSION,
                surface = if edp == Constants.StoreEnums.LocationType.Edp then UnifiedLoggingSurface.EDP_PREVIEW else UnifiedLoggingSurface.EDP_STORE
            }),
            { includeScreenSize = true, includeElementSizeAndPosition = true }
        )
    end
end

return EdpUnifiedImpressionsReporter
