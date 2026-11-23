-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local UnifiedEventLogEnums = require(script.Parent.UnifiedEventLogEnums)
local _UnifiedEventTypes = require(script.Parent.Generated.UnifiedEventTypes)
local MarketplaceUnifiedAction = UnifiedEventLogEnums.MarketplaceUnifiedAction
local MarketplaceUnifiedItemType = UnifiedEventLogEnums.MarketplaceUnifiedItemType
local WidgetUiTreatment = UnifiedEventLogEnums.WidgetUiTreatment

local UnifiedLoggingSurface = require(AvatarExperienceAnalyticsParent.AvatarExperienceNavigation).Enums.UnifiedLoggingSurface

local sendAXCounterV2 = require(script.Parent.sendAXCounterV2)

local FFlagAXUnifiedImpressionsOnThumbnail = require(AvatarExperienceAnalyticsParent.AvatarExperienceFlags).FFlagAXUnifiedImpressionsOnThumbnail
local FFlagAXFixHomeAvatarsUnifiedPurchase = require(AvatarExperienceAnalyticsParent.SharedFlags).FFlagAXFixHomeAvatarsUnifiedPurchase
local FFlagAXEnableUnifiedLoggingAvatarMoment = require(AvatarExperienceAnalyticsParent.SharedFlags).FFlagAXEnableUnifiedLoggingAvatarMoment
local FFlagAXUnifiedEventCounters = require(AvatarExperienceAnalyticsParent.AvatarExperienceFlags).FFlagAXUnifiedEventCounters

local bool1 = game:DefineFastFlag("AXSendPurchaseAttempt", false)

local bool2 = game:DefineFastFlag("AXUnifiedFilterWidgetLoadedAndUIImpression", false)
local bool3 = game:DefineFastFlag("AXAlignUnifiedFilterSearchKeyword", false)

local module = {}

local tbl1 = {
    AssetTypeIdStringToName = {},
    BundleTypeIdStringToName = {}
}
for _, enumItem in (Enum.BundleType:GetEnumItems()) do
    local bundleTypeIdStringToName = tbl1.BundleTypeIdStringToName
    local enumItemValue = enumItem.Value
    bundleTypeIdStringToName[tostring(enumItemValue)] = enumItem.Name
end

for _, enumItem in (Enum.AvatarAssetType:GetEnumItems()) do
    local assetTypeIdStringToName = tbl1.AssetTypeIdStringToName
    local enumItemValue = enumItem.Value
    assetTypeIdStringToName[tostring(enumItemValue)] = enumItem.Name
end

function module.hasOrganicData(arg1): boolean
    return not not (arg1.assetType
        or arg1.bundleType
        or arg1.organicItemPrice
        or arg1.organicItemWearAfterPurchase
        or arg1.organicItemSaveToMyAvatars
        or arg1.organicAssetIds
        or arg1.organicBundleIds)
end

function module.hasWidgetData(arg1): boolean
    return not not (arg1.widgetId
        or arg1.widgetType
        or arg1.assetIds
        or arg1.bundleIds
        or arg1.widgetItemIds
        or arg1.organicResultIds
        or arg1.widgetItemPrice
        or arg1.uiTreatmentType
        or arg1.themeId
        or arg1.widgetItemWearAfterPurchase
        or arg1.widgetItemSaveToMyAvatars)
end

function module.hasUiElementData(arg1): boolean
    return not not arg1.elementName
end

function module.hasItemId(arg1): boolean
    local action = arg1.action
    local itemId = arg1.itemId
    if FFlagAXEnableUnifiedLoggingAvatarMoment and action == MarketplaceUnifiedAction.PAGE_EXIT then
        return true
    end

    if action == MarketplaceUnifiedAction.UNDEFINED_ACTION
        or action == MarketplaceUnifiedAction.UI_ELEMENT_CLICK
        or action == MarketplaceUnifiedAction.PAGE_VIEW
        or action == MarketplaceUnifiedAction.WIDGET_IMPRESSION
        or bool2 and (action == MarketplaceUnifiedAction.UI_ELEMENT_IMPRESSION or action == MarketplaceUnifiedAction.WIDGET_LOADED)
    then
        return true
    end

    return not (itemId == nil) and itemId ~= ""
end

function module.hasValidItemType(arg1): boolean
    local itemType = arg1.itemType

    if itemType ~= MarketplaceUnifiedItemType.UNDEFINED_ITEM_TYPE and itemType ~= nil then
        return itemType == MarketplaceUnifiedItemType.ASSET
            or itemType == MarketplaceUnifiedItemType.BUNDLE
            or itemType == MarketplaceUnifiedItemType.LOOK
    end

    local action = arg1.action

    if FFlagAXEnableUnifiedLoggingAvatarMoment and action == MarketplaceUnifiedAction.PAGE_EXIT then
        return true
    end

    if bool2 then
        return action == MarketplaceUnifiedAction.UI_ELEMENT_CLICK
            or action == MarketplaceUnifiedAction.UI_ELEMENT_IMPRESSION
            or action == MarketplaceUnifiedAction.PAGE_VIEW
            or action == MarketplaceUnifiedAction.WIDGET_IMPRESSION
            or action == MarketplaceUnifiedAction.WIDGET_LOADED
    end

    return action == MarketplaceUnifiedAction.UI_ELEMENT_CLICK
        or action == MarketplaceUnifiedAction.PAGE_VIEW
        or action == MarketplaceUnifiedAction.WIDGET_IMPRESSION
end

function module.hasValidAction(arg1): boolean
    local action = arg1.action
    return not (action == nil) and action ~= MarketplaceUnifiedAction.UNDEFINED_ACTION
end

function module.hasValidSurface(arg1): boolean
    local surface = arg1.surface
    return not (surface == nil) and surface ~= UnifiedLoggingSurface.UNDEFINED_SURFACE
end

function module.hasRequestIdForWidgetLog(arg1): boolean
    if not module.hasWidgetData(arg1) then
        return true
    end

    return not (arg1.requestId == nil) and arg1.requestId ~= ""
end

function module.hasValidSizeAndPosition(arg1): boolean
    local action = arg1.action
    if FFlagAXFixHomeAvatarsUnifiedPurchase
        and action == MarketplaceUnifiedAction.PURCHASE_SUCCESS
        and (arg1.surface == UnifiedLoggingSurface.DISCOVERY_HOMEPAGE
            or arg1.surface == UnifiedLoggingSurface.DISCOVERY_SEARCH_RESULTS)
    then
        return true
    end

    if FFlagAXEnableUnifiedLoggingAvatarMoment
        and action == MarketplaceUnifiedAction.PURCHASE_SUCCESS
        and arg1.surface == UnifiedLoggingSurface.SHOP_AVATAR_MOMENT
    then
        return true
    end

    if action ~= MarketplaceUnifiedAction.ITEM_IMPRESSION
        and action ~= MarketplaceUnifiedAction.ITEM_SELECTED
        and action ~= MarketplaceUnifiedAction.ITEM_DESELECTED
        and action ~= MarketplaceUnifiedAction.PURCHASE_SUCCESS
    then
        if action ~= MarketplaceUnifiedAction.WIDGET_IMPRESSION then
            return true
        end

        local gridPositionRow = arg1.gridPositionRow or 0
        local gridPositionColumn = arg1.gridPositionColumn or 0
        return gridPositionRow > 0 and gridPositionColumn == 1
    end

    local screenSizeWidth = arg1.screenSizeWidth or 0
    local screenSizeHeight = arg1.screenSizeHeight or 0
    local bool4 = screenSizeWidth > 0 and screenSizeHeight > 0
    local elementSizeWidth = arg1.elementSizeWidth or 0
    local elementSizeHeight = arg1.elementSizeHeight or 0
    local bool5 = elementSizeWidth > 0 and elementSizeHeight > 0
    local gridPositionRow = arg1.gridPositionRow or 0
    local gridPositionColumn = arg1.gridPositionColumn or 0
    local bool6 = gridPositionRow > 0 and gridPositionColumn > 0
    return bool4 and bool5 and bool6
end

function module.hasValidFilter(arg1)
    local surface = arg1.surface
    local keyword = arg1.keyword
    local category = arg1.category
    local subcategory = arg1.subcategory
    local filterPriceMin = arg1.filterPriceMin
    local filterPriceMax = arg1.filterPriceMax
    local filterPrice = arg1.filterPrice
    local filterCreatorsName = arg1.filterCreatorsName
    local filterCreators = arg1.filterCreators

    if bool3 and keyword ~= nil then
        return not (keyword == "")
            and (arg1.action == MarketplaceUnifiedAction.PURCHASE_ATTEMPT
                or arg1.action == MarketplaceUnifiedAction.PURCHASE_SUCCESS
                or surface == UnifiedLoggingSurface.SEARCH_RESULTS
                or surface == UnifiedLoggingSurface.ITEM_DETAILS)
    end

    local bool4 = true
    if category ~= nil and category ~= "" then
        if subcategory ~= nil and subcategory == "" then
            bool4 = false
        end
    elseif not FFlagAXUnifiedImpressionsOnThumbnail then
        bool4 = arg1.action == MarketplaceUnifiedAction.WIDGET_IMPRESSION
            or arg1.action == MarketplaceUnifiedAction.UI_ELEMENT_CLICK
            or arg1.action == MarketplaceUnifiedAction.PAGE_VIEW
            or arg1.action == MarketplaceUnifiedAction.PURCHASE_ATTEMPT
            or FFlagAXEnableUnifiedLoggingAvatarMoment and arg1.action == MarketplaceUnifiedAction.PAGE_EXIT
    end

    local bool5 = if bool3 or not keyword and surface ~= UnifiedLoggingSurface.SEARCH_RESULTS then true else surface == UnifiedLoggingSurface.SEARCH_RESULTS and keyword ~= nil and keyword ~= ""
    local bool6 = (not filterPriceMin or filterPriceMin == "") and (not filterPriceMax or filterPriceMax == "")
        or filterPrice == UnifiedEventLogEnums.FiltersPrice.PRICE_RANGE

    local bool7 = not filterCreatorsName
        or filterCreatorsName == ""
        or filterCreators == UnifiedEventLogEnums.FiltersCreators.CREATORS_BY_USERNAME

    return bool5 and bool4 and bool6 and bool7
end

local function isValidPrice(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = tonumber(arg1)
    return not (var1 == nil) and var1 >= 0
end

function module.hasValidEntityData(arg1)
    if arg1.surface == UnifiedLoggingSurface.CUSTOMIZE then
        return true
    end

    if bool1 and arg1.action == MarketplaceUnifiedAction.PURCHASE_ATTEMPT then
        return true
    end

    local num1 = 0
    local var1 = module.hasOrganicData(arg1)
    local var2 = module.hasWidgetData(arg1)
    local var3 = module.hasUiElementData(arg1)

    if var1 then
        num1 += 1
    end
    if var2 then
        num1 += 1
    end
    if var3 then
        num1 += 1
    end

    if num1 ~= 1 then
        return false
    end

    if var1 then
        if not (if FFlagAXUnifiedEventCounters then isValidPrice(arg1.organicItemPrice) else not (arg1.organicItemPrice == nil) and arg1.organicItemPrice >= 0) then
            return false
        end

        if arg1.itemType == MarketplaceUnifiedItemType.LOOK then
            if arg1.action == MarketplaceUnifiedAction.PURCHASE_ATTEMPT then
                return true
            end

            local bool4 = if arg1.organicAssetIds then arg1.organicAssetIds ~= "" else false
            local bool5 = if arg1.organicBundleIds then arg1.organicBundleIds ~= "" else false
            return bool4 or bool5
        end

        local assetType = arg1.assetType and tbl1.AssetTypeIdStringToName[tostring(arg1.assetType)] ~= nil

        local bundleType = arg1.bundleType and tbl1.BundleTypeIdStringToName[tostring(arg1.bundleType)] ~= nil

        return not not (assetType or bundleType)
    end

    if not var2 then
        if not var3 then
            return false
        end

        return not (arg1.elementName == nil) and arg1.elementName ~= ""
    end

    local bool4 = not (arg1.widgetId == nil) and arg1.widgetId ~= ""
    local bool5 = not (arg1.widgetType == nil) and arg1.widgetType ~= ""
    local bool6 = if arg1.widgetItemIds then arg1.widgetItemIds ~= "" else false
    local bool7 = if arg1.assetIds then arg1.assetIds ~= "" else false
    local bool8 = if arg1.bundleIds then arg1.bundleIds ~= "" else false
    local bool9 = arg1.itemType ~= MarketplaceUnifiedItemType.LOOK
        or arg1.action == MarketplaceUnifiedAction.PURCHASE_ATTEMPT
        or bool7
        or bool8
    local bool10 = if arg1.uiTreatmentType then arg1.uiTreatmentType ~= WidgetUiTreatment.UNKNOWN_WIDGET_UI else false
    local bool11 = arg1.widgetType == "ThemedAvatarItemsWidget"
    local bool12 = not (arg1.themeId == nil) and arg1.themeId ~= ""
    local bool13 = not bool11 or bool12
    local bool14 = if FFlagAXUnifiedEventCounters then isValidPrice(arg1.widgetItemPrice) else not (arg1.widgetItemPrice == nil) and arg1.widgetItemPrice >= 0

    if arg1.action == MarketplaceUnifiedAction.WIDGET_IMPRESSION then
        bool14 = true
    end

    return bool4 and bool5 and bool6 and bool9 and bool10 and bool13 and bool14
end

function module.filter(arg1, tbl2)
    local var1 = module.hasItemId(arg1)
    local var2 = module.hasValidItemType(arg1)
    local var3 = module.hasValidAction(arg1)
    local var4 = module.hasValidSurface(arg1)
    local var5 = module.hasRequestIdForWidgetLog(arg1)
    local var6 = module.hasValidSizeAndPosition(arg1)
    local var7 = module.hasValidFilter(arg1)
    local var8 = module.hasValidEntityData(arg1)

    local var9 = var1 and var2 and var3 and var4 and var5 and var6 and var7 and var8

    if FFlagAXUnifiedEventCounters and tbl2 ~= nil and tbl2.skipReporting then
        return var9
    end

    if not var9 then
        local str1 = ""
        if not var1 then
            str1 ..= "hasItemId "
        end
        if not var2 then
            str1 ..= "hasValidItemType "
        end
        if not var3 then
            str1 ..= "hasValidAction "
        end
        if not var4 then
            str1 ..= "hasValidSurface "
        end
        if not var5 then
            str1 ..= "hasRequestIdForWidgetLog "
        end
        if not var6 then
            str1 ..= "hasValidSizeAndPosition "
        end
        if not var7 then
            str1 ..= "hasValidFilter "
        end
        if not var8 then
            str1 ..= "hasValidEntityData "
        end

        if arg1.action == MarketplaceUnifiedAction.ITEM_IMPRESSION then
            warn("Failed to send unified impression event. Failing Check(s): " .. str1)
        elseif arg1.action == MarketplaceUnifiedAction.ITEM_SELECTED then
            warn("Failed to send unified click event. Failing Check(s): " .. str1)
        elseif arg1.action == MarketplaceUnifiedAction.PURCHASE_SUCCESS then
            warn("Failed to send unified purchase event. Failing Check(s): " .. str1)
        else
            warn("Failed to send unified event. Failing Check(s): " .. str1)
        end
    end

    sendAXCounterV2("AXUnifiedFilter", {
        success = tostring(var9),
        action = tostring(arg1.action or MarketplaceUnifiedAction.UNDEFINED_ACTION),
        surface = tostring(arg1.surface or UnifiedLoggingSurface.UNDEFINED_SURFACE),
        hasItemId = tostring(var1),
        hasValidItemType = tostring(var2),
        hasValidAction = tostring(var3),
        hasValidSurface = tostring(var4),
        hasRequestIdForWidgetLog = tostring(var5),
        hasValidSizeAndPosition = tostring(var6),
        hasValidFilter = tostring(var7),
        hasValidEntityData = tostring(var8)
    })

    return var9
end

return module
