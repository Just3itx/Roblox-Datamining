-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalytics = script:FindFirstAncestor("AvatarExperienceAnalytics")
local AvatarExperienceAnalyticsParent = AvatarExperienceAnalytics.Parent

local _AvatarExperienceCommon = require(AvatarExperienceAnalyticsParent.AvatarExperienceCommon)
local Cryo = require(AvatarExperienceAnalyticsParent.Cryo)

local CartIdService = require(AvatarExperienceAnalytics.Lib.CartIdService)

local UnifiedEventLogEnums = require(AvatarExperienceAnalytics.UnifiedEventLogEnums)
local getMarketplaceUnifiedAssetType = require(AvatarExperienceAnalytics.Utils.getMarketplaceUnifiedAssetType)
local getMarketplaceUnifiedBundleType = require(AvatarExperienceAnalytics.Utils.getMarketplaceUnifiedBundleType)
local getWidgetAttributionFields = require(AvatarExperienceAnalytics.Utils.getWidgetAttributionFields)
local FFlagAXUnifiedEventStrictPayloads = require(AvatarExperienceAnalyticsParent.AvatarExperienceFlags).FFlagAXUnifiedEventStrictPayloads

local function appendMISPrefixToCartId(cartId: string): string -- Luacid: Inlined by compiler; 3 call sites recovered
    return "MIS_" .. cartId
end

return function(arg1, arg2, arg3, arg4, action, surface: number?, arg5, arg6)
    local num2 = 0
    local tbl1 = {}
    local tbl2 = {}

    local num3 = 0
    local tbl3 = {}
    local tbl4 = {}

    local tbl5 = {}

    local tbl6 = ({})

    for _, value in arg1 do
        if arg3 and (arg3.lookAssetInfos[value.itemId] or arg3.lookBundleInfos[value.itemId]) then
            if arg3.lookAssetInfos[value.itemId] then
                table.insert(tbl1, value.itemId)

                num2 += value.priceInRobux
            elseif arg3.lookBundleInfos[value.itemId] then
                table.insert(tbl2, value.itemId)

                num2 += value.priceInRobux
            end
        elseif arg4 and (arg4.lookAssetInfos[value.itemId] or arg4.lookBundleInfos[value.itemId]) then
            if arg4.lookAssetInfos[value.itemId] then
                table.insert(tbl3, value.itemId)

                num3 += value.priceInRobux
            elseif arg4.lookBundleInfos[value.itemId] then
                table.insert(tbl4, value.itemId)

                num3 += value.priceInRobux
            end
        else
            local var1 = nil
            for _, value2 in arg2 do
                if value2.itemId == value.itemId and value2.itemType == value.itemType then
                    var1 = value2
                    break
                end
            end

            table.insert(tbl5, {
                cartId = appendMISPrefixToCartId((CartIdService.getCartId())),
                action = action,
                itemId = value.itemId,
                itemType = if value.itemType == "Asset" then UnifiedEventLogEnums.MarketplaceUnifiedItemType.ASSET else UnifiedEventLogEnums.MarketplaceUnifiedItemType.BUNDLE,
                surface = if FFlagAXUnifiedEventStrictPayloads then surface else nil,
                assetType = if value.itemType ~= "Asset" then nil elseif FFlagAXUnifiedEventStrictPayloads then getMarketplaceUnifiedAssetType(value.itemSubType) else value.itemSubType,
                bundleType = if value.itemType ~= "Bundle" then nil elseif FFlagAXUnifiedEventStrictPayloads then getMarketplaceUnifiedBundleType(value.itemSubType) else value.itemSubType,
                widgetId = if var1.widgetInfo then var1.widgetInfo.widgetId else nil,
                widgetType = if var1.widgetInfo then var1.widgetInfo.widgetType else nil,
                widgetItemPrice = if var1.widgetInfo then value.priceInRobux else nil,
                organicItemPrice = if var1.widgetInfo then nil else value.priceInRobux,
                status = value.status
            })
            local widgetAttributionFields = if FFlagAXUnifiedEventStrictPayloads then getWidgetAttributionFields(var1.widgetInfo) else nil

            if widgetAttributionFields then
                local num4 = #tbl5
                tbl6[num4] = Cryo.Dictionary.join(widgetAttributionFields, {
                    widgetAssetType = if value.itemType == "Asset" then getMarketplaceUnifiedAssetType(value.itemSubType) else nil,
                    widgetBundleType = if value.itemType == "Bundle" then getMarketplaceUnifiedBundleType(value.itemSubType) else nil
                })
            end
        end
    end

    if #tbl1 > 0 or #tbl2 > 0 then
        local str1 = if #tbl1 > 0 then table.concat(tbl1, ",") else ""
        local str2 = if #tbl2 > 0 then table.concat(tbl2, ",") else ""

        local tbl7 = {
            cartId = appendMISPrefixToCartId((CartIdService.getCartId())),
            action = action,
            itemId = arg3.itemId,
            itemType = UnifiedEventLogEnums.MarketplaceUnifiedItemType.LOOK,
            surface = if FFlagAXUnifiedEventStrictPayloads then surface else nil
        }
        if arg3.isOrganicLook then
            tbl7.organicAssetIds = str1
            tbl7.organicBundleIds = str2
            tbl7.organicItemPrice = num2
        else
            tbl7.assetIds = str1
            tbl7.bundleIds = str2
            tbl7.widgetItemPrice = num2
        end

        table.insert(tbl5, tbl7)
        local widgetAttributionFields = if FFlagAXUnifiedEventStrictPayloads and not arg3.isOrganicLook then getWidgetAttributionFields(arg5) else nil

        if widgetAttributionFields then
            tbl6[#tbl5] = widgetAttributionFields
        end
    end

    if #tbl3 > 0 or #tbl4 > 0 then
        local str1 = if #tbl3 > 0 then table.concat(tbl3, ",") else ""
        local str2 = if #tbl4 > 0 then table.concat(tbl4, ",") else ""

        local tbl7 = {
            cartId = appendMISPrefixToCartId((CartIdService.getCartId())),
            action = action,
            itemId = arg4.itemId,
            itemType = UnifiedEventLogEnums.MarketplaceUnifiedItemType.LOOK,
            surface = 0
        }

        if not FFlagAXUnifiedEventStrictPayloads then
            surface = nil
        end

        tbl7.surface = surface

        if arg4.isOrganicLook then
            tbl7.organicAssetIds = str1
            tbl7.organicBundleIds = str2
            tbl7.organicItemPrice = num3
        else
            tbl7.assetIds = str1
            tbl7.bundleIds = str2
            tbl7.widgetItemPrice = num3
        end

        table.insert(tbl5, tbl7)
        local widgetAttributionFields = if FFlagAXUnifiedEventStrictPayloads and not arg4.isOrganicLook then getWidgetAttributionFields(arg6) else nil

        if widgetAttributionFields then
            tbl6[#tbl5] = widgetAttributionFields
        end
    end

    return tbl5, tbl6
end
