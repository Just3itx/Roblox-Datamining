-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalytics = script:FindFirstAncestor("AvatarExperienceAnalytics")
local AvatarExperienceAnalyticsParent = AvatarExperienceAnalytics.Parent

local Cryo = require(AvatarExperienceAnalyticsParent.Cryo)
local UnifiedEventLogConstants = require(script.Parent.UnifiedEventLogConstants)
local UnifiedEventLoggingUtils = require(AvatarExperienceAnalytics.Utils.UnifiedEventLoggingUtils)
local sendUnifiedEventLog = require(script.Parent.sendUnifiedEventLog)
local UnifiedSelectionListStore = require(script.Parent.Store.UnifiedSelectionListStore)
local reportAvatarEventCounterV1 = require(script.Parent.reportAvatarEventCounterV1)
local Constants = require(script.Parent.Constants)
local UnifiedEventLogEnums = require(AvatarExperienceAnalytics.UnifiedEventLogEnums)
local _UnifiedEventTypes = require(script.Parent.Generated.UnifiedEventTypes)

local AvatarExperienceFlags = require(AvatarExperienceAnalyticsParent.AvatarExperienceFlags)
local FFlagAXFixSearchPurchaseSurface = AvatarExperienceFlags.FFlagAXFixSearchPurchaseSurface
local FFlagAXUnifiedEventStrictPayloads = AvatarExperienceFlags.FFlagAXUnifiedEventStrictPayloads

return function(tbl1, surface: number?, tbl2)
    local selectionList = UnifiedSelectionListStore.getSelectionList()

    local var1 = UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. "itemId"
    local var2 = UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. "itemType"

    for value, value2 in tbl1 do
        local var3 = nil
        for _, value3 in selectionList do
            if tostring(value3[var1]) == tostring(value2.itemId) and tostring(value3[var2]) == tostring(value2.itemType) then
                var3 = value3
                break
            end
        end

        local fieldsToSendFromInstanceAttributes = UnifiedEventLoggingUtils.getFieldsToSendFromInstanceAttributes(var3)
        local var4 = Cryo.Dictionary.join(fieldsToSendFromInstanceAttributes, value2)
        local var5 = if FFlagAXUnifiedEventStrictPayloads
            and FFlagAXFixSearchPurchaseSurface
            and fieldsToSendFromInstanceAttributes.surface ~= nil then fieldsToSendFromInstanceAttributes.surface elseif FFlagAXFixSearchPurchaseSurface and var4.surface ~= nil then var4.surface else surface
        local var6 = Cryo.Dictionary.join(var4, { surface = var5 })
        if FFlagAXUnifiedEventStrictPayloads then
            local var7 = if tbl2 then tbl2[value] else nil
            var6 = Cryo.Dictionary.join(var7 or {}, var6)
        end

        if var6.action == UnifiedEventLogEnums.MarketplaceUnifiedAction.PURCHASE_SUCCESS then
            if var6.itemType == UnifiedEventLogEnums.MarketplaceUnifiedItemType.ASSET then
                reportAvatarEventCounterV1(Constants.AVATAR_EVENT_COUNTER_NAME.AXPurchaseAsset)
            elseif var6.itemType == UnifiedEventLogEnums.MarketplaceUnifiedItemType.BUNDLE then
                reportAvatarEventCounterV1(Constants.AVATAR_EVENT_COUNTER_NAME.AXPurchaseBundle)
            end
        end

        sendUnifiedEventLog(var6)
    end
end
