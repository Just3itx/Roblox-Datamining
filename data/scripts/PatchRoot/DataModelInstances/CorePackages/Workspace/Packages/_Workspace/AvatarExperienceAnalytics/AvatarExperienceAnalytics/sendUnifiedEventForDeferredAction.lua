-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalytics = script:FindFirstAncestor("AvatarExperienceAnalytics")
local AvatarExperienceAnalyticsParent = AvatarExperienceAnalytics.Parent

local CollectionService = game:GetService("CollectionService")
local Cryo = require(AvatarExperienceAnalyticsParent.Cryo)
local UnifiedEventLogConstants = require(script.Parent.UnifiedEventLogConstants)
local UnifiedEventLogEnums = require(script.Parent.UnifiedEventLogEnums)
local UnifiedEventLoggingUtils = require(AvatarExperienceAnalytics.Utils.UnifiedEventLoggingUtils)
local sendUnifiedEventLog = require(script.Parent.sendUnifiedEventLog)
local sendUnifiedEventLogForInstance = require(script.Parent.sendUnifiedEventLogForInstance)
local mapAnalyticsMetadataFields = require(AvatarExperienceAnalytics.Utils.mapAnalyticsMetadataFields)
local _UnifiedEventTypes = require(script.Parent.Generated.UnifiedEventTypes)

local AvatarExperienceFlags = require(AvatarExperienceAnalyticsParent.AvatarExperienceFlags)
local UnifiedSelectionListStore = require(script.Parent.Store.UnifiedSelectionListStore)
local LastDeferredSingleItemStore = require(script.Parent.Store.LastDeferredSingleItemStore)

local FFlagAXMISEnableMultiShoppingUnifiedEvents = AvatarExperienceFlags.FFlagAXMISEnableMultiShoppingUnifiedEvents
local FFlagAXFixSingleItemPurchaseWidgetLogging = AvatarExperienceFlags.FFlagAXFixSingleItemPurchaseWidgetLogging
local FFlagAXFixUnifiedPurchaseFieldLanding = AvatarExperienceFlags.FFlagAXFixUnifiedPurchaseFieldLanding
local FFlagAXFixDeferredItemIdTypeMatch = AvatarExperienceFlags.FFlagAXFixDeferredItemIdTypeMatch
local FFlagAXUnifiedEventStrictPayloads = AvatarExperienceFlags.FFlagAXUnifiedEventStrictPayloads

local function fillUnsetFields(tbl1, tbl2) -- Luacid: Inlined by compiler; 4 call sites recovered
    return Cryo.Dictionary.join(tbl2 or {}, tbl1)
end

local function getUnsetInstanceFields(arg1: Instance, tbl1)
    local unsetInstanceFields = ({})
    if tbl1 then
        for value, value2 in tbl1 do
            unsetInstanceFields[value] = value2
        end
    end
    for k in unsetInstanceFields do
        if arg1:GetAttribute(UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. k) ~= nil then
            unsetInstanceFields[k] = nil
        end
    end
    return unsetInstanceFields
end

return function(arg1, tbl1)
    if FFlagAXFixUnifiedPurchaseFieldLanding then
        arg1 = mapAnalyticsMetadataFields(arg1)
    end

    if not FFlagAXMISEnableMultiShoppingUnifiedEvents then
        local tagged = CollectionService:GetTagged(UnifiedEventLogConstants.LAST_ACTIVATED_TAG_NAME)

        if #tagged > 0 then
            for _, value in tagged do
                local var1 = sendUnifiedEventLogForInstance
                local var2 = if FFlagAXUnifiedEventStrictPayloads then Cryo.Dictionary.join(getUnsetInstanceFields(value, tbl1), arg1) else arg1
                var1(value, var2, { includeScreenSize = true, includeElementSizeAndPosition = true })
            end

            return
        end

        local var1 = sendUnifiedEventLog
        if FFlagAXUnifiedEventStrictPayloads then
            arg1 = fillUnsetFields(arg1, tbl1)
        end

        var1(arg1)

        return
    end

    local selectionList = UnifiedSelectionListStore.getSelectionList()

    local var1 = UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. "itemId"
    local var2 = UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. "itemType"

    local var3 = nil
    for _, value in selectionList do
        local bool1 = if FFlagAXFixDeferredItemIdTypeMatch then tostring(value[var1]) == tostring(arg1.itemId) else value[var1] == arg1.itemId

        if bool1 and tostring(value[var2]) == tostring(arg1.itemType) then
            var3 = value
            break
        end
    end

    if not FFlagAXFixSingleItemPurchaseWidgetLogging or var3 ~= nil then
        local fieldsToSendFromInstanceAttributes = UnifiedEventLoggingUtils.getFieldsToSendFromInstanceAttributes(var3)
        local var4 = Cryo.Dictionary.join(fieldsToSendFromInstanceAttributes, arg1)

        local var5 = sendUnifiedEventLog
        if FFlagAXUnifiedEventStrictPayloads then
            var4 = fillUnsetFields(var4, tbl1)
        end

        var5(var4)
        return
    end

    if arg1.action == UnifiedEventLogEnums.MarketplaceUnifiedAction.PURCHASE_SUCCESS then
        local snapshot = LastDeferredSingleItemStore.getSnapshot()
        LastDeferredSingleItemStore.clearSnapshot()
        if snapshot then
            local fieldsToSendFromInstanceAttributes = UnifiedEventLoggingUtils.getFieldsToSendFromInstanceAttributes(snapshot)
            local var4 = Cryo.Dictionary.join(fieldsToSendFromInstanceAttributes, arg1)
            local var5 = sendUnifiedEventLog
            if FFlagAXUnifiedEventStrictPayloads then
                var4 = fillUnsetFields(var4, tbl1)
            end

            var5(var4)

            return
        end
    end

    local var4 = sendUnifiedEventLog
    if FFlagAXUnifiedEventStrictPayloads then
        arg1 = fillUnsetFields(arg1, tbl1)
    end

    var4(arg1)
end
