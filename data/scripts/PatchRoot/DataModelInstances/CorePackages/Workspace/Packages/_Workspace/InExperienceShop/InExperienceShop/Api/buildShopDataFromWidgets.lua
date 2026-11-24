-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local Promise = require(InExperienceShopParent.Promise)
local SharedFlags = require(InExperienceShopParent.SharedFlags)
local Constants = require(InExperienceShop.Constants)
local _Types = require(InExperienceShop.Types)
local FFlagEnableRobuxInExperienceShop = SharedFlags.FFlagEnableRobuxInExperienceShop
local FFlagEnableBonusJwtInShop = SharedFlags.FFlagEnableBonusJwtInShop
local _multiGetProductInfo = require(script.Parent.multiGetProductInfo)
local parseGamePassTrialAvailabilities = require(script.Parent.parseGamePassTrialAvailabilities)
local shopItemMapping = require(script.Parent.shopItemMapping)
local robuxWidgetMapping = require(script.Parent.robuxWidgetMapping)
local hydrateRobuxBonusItems = require(script.Parent.hydrateRobuxBonusItems)
local toRobuxPackageItem = robuxWidgetMapping.toRobuxPackageItem
local appendBonusItemRequests = hydrateRobuxBonusItems.appendBonusItemRequests
local mergeBonusItemDetailsIntoSections = hydrateRobuxBonusItems.mergeBonusItemDetailsIntoSections
local makeRequestKey = shopItemMapping.makeRequestKey
local toShopItem = shopItemMapping.toShopItem
local logCounter = require(InExperienceShop.Internal.logCounter)
local ProductInfoFailedItemsCounter = require(InExperienceShop.Events.ProductInfoFailedItemsCounter)

local FFlagEnableExperienceShopGlobalIcon = require(InExperienceShop.Flags.FFlagEnableExperienceShopGlobalIcon)
local FFlagIdentifyTopPicksByCategoryType = require(InExperienceShop.Flags.FFlagIdentifyTopPicksByCategoryType)
local FFlagParseStableCategoryId = require(InExperienceShop.Flags.FFlagParseStableCategoryId)
local FFlagLuaAppEnableGamePassFreeTrials = require(InExperienceShop.Flags.FFlagLuaAppEnableGamePassFreeTrials)

local str1 = game:DefineFastString("FreeTrialTopBarChipSettingName", "FreeTrialTopBarChip")

local function isNotificationSettingEnabled(isEnabled): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(isEnabled) == "boolean" then
        return isEnabled
    elseif typeof(isEnabled) == "string" then
        return isEnabled == "true"
    end

    return false
end

local function readFreeTrialTopBarChipFromNotificationSettings(arg1)
    local notificationSettings = arg1.notificationSettings
    if notificationSettings == nil then
        return false
    end
    for _, notificationSetting in ipairs(notificationSettings) do
        if notificationSetting.name == str1 then
            return isNotificationSettingEnabled(notificationSetting.isEnabled)
        end
    end
    return false
end

local tbl1 = {
    id = Constants.HOME_CATEGORY_ID,
    name = "CommonUI.Features.Label.Home"
}

local function buildShopDataFromWidgets(arg1, func1: ((...any) -> (...any))?)
    local tbl2 = { tbl1 }
    local tbl3 = ({})
    local tbl4 = {}

    local tbl5 = {}

    local tbl6 = ({})

    local gamePassTrialAvailabilities = if FFlagLuaAppEnableGamePassFreeTrials and typeof(arg1.gamePassTrialAvailabilities) == "table" then parseGamePassTrialAvailabilities(arg1.gamePassTrialAvailabilities) else nil

    for _, value in ipairs(arg1.categories) do
        if Constants.BLACKLISTED_CATEGORY_NAMES[string.lower(value.name)] then
            continue
        end

        local str2 = tostring(value.id)
        table.insert(tbl2, { id = str2, name = value.name })

        local categoryIndex = #tbl3 + 1
        local tbl7 = {
            id = str2,
            name = value.name,
            items = {}
        }
        local metadata = value.metadata
        if FFlagIdentifyTopPicksByCategoryType and metadata ~= nil and metadata.categoryType ~= nil then
            tbl7.categoryType = metadata.categoryType
        end
        if FFlagParseStableCategoryId and metadata ~= nil and metadata.categoryId ~= nil then
            tbl7.stableCategoryId = metadata.categoryId
        end
        if FFlagParseStableCategoryId and metadata ~= nil and metadata.categoryGroup ~= nil then
            tbl7.categoryGroup = metadata.categoryGroup
        end

        if FFlagEnableRobuxInExperienceShop and metadata ~= nil and metadata.paymentSessionId ~= nil then
            tbl7.paymentSessionId = metadata.paymentSessionId
        end
        if FFlagEnableBonusJwtInShop and metadata ~= nil and metadata.bonusJwt ~= nil then
            tbl7.bonusJwt = metadata.bonusJwt
        end
        tbl3[categoryIndex] = tbl7

        local num2 = 0

        for _, item in ipairs(value.items) do
            local type = item.type
            local var2

            if type == "Product" then
                var2 = Enum.InfoType.Product
            else
                if type ~= "GamePass" then
                    if type ~= "Robux" or not FFlagEnableRobuxInExperienceShop then
                        continue
                    end

                    local var3 = toRobuxPackageItem(item)
                    if var3 == nil then
                        continue
                    end

                    if tbl7.robuxPackages == nil then
                        tbl7.robuxPackages = {}
                    end
                    local robuxPackages = tbl7.robuxPackages

                    if #robuxPackages == 0 then
                        var3.isPrimaryRobuxPackage = true
                    end
                    table.insert(robuxPackages, var3)
                    continue
                end

                var2 = Enum.InfoType.GamePass
            end

            num2 += 1
            tbl6[categoryIndex] = true
            table.insert(tbl4, { id = item.id, infoType = var2 })

            table.insert(tbl5, { categoryIndex = categoryIndex, sectionId = str2, itemType = type, sectionItemIndex = num2 })
        end
    end

    local function filterOutput(tbl7)
        local tbl8 = {}
        local tbl9 = {}
        for i, value in ipairs(tbl7) do
            if tbl6[i] or value.robuxPackages ~= nil and #value.robuxPackages > 0 then
                table.insert(tbl8, value)
                tbl9[value.id] = true
            end
        end
        local tbl10 = {}
        for _, value in ipairs(tbl2) do
            if value.id == Constants.HOME_CATEGORY_ID or tbl9[value.id] then
                table.insert(tbl10, value)
            end
        end
        return tbl10, tbl8
    end

    if func1 == nil then
        local failedItems = table.create(#tbl4)
        local func2, tbl7, num1 = ipairs(tbl4)
        local var1 = gamePassTrialAvailabilities

        for value, value2 in func2, tbl7, num1 do
            local var4 = tbl5[value]
            local tbl8 = {
                id = value2.id,
                infoType = value2.infoType,
                itemType = var4.itemType,
                sectionId = var4.sectionId,
                originalIndex = var4.sectionItemIndex
            }
            failedItems[value] = tbl8
        end

        local categories, sections = filterOutput(tbl3)
        return Promise.resolve({
            categories = categories,
            sections = sections,
            failedItems = failedItems,
            metadata = if FFlagEnableExperienceShopGlobalIcon then arg1.metadata else nil,
            notificationFreeTrialTopBarChip = readFreeTrialTopBarChipFromNotificationSettings(arg1),
            gamePassTrialAvailabilities = var1
        })
    end

    local num1 = #tbl4
    if FFlagEnableRobuxInExperienceShop then
        appendBonusItemRequests(tbl4, tbl3)
    end

    return func1(tbl4):andThen(function(tbl7)
        local tbl8 = {}
        for _, value in ipairs(tbl7) do
            tbl8[makeRequestKey(value.request.id, value.request.infoType)] = value
        end

        local failedItems = {}

        for i = 1, num1 do
            local var2 = tbl4[i]

            local var3 = tbl5[i]
            local var4 = tbl8[makeRequestKey(var2.id, var2.infoType)]
            if var4 == nil or not var4.ok then
                table.insert(failedItems, {
                    id = var2.id,
                    infoType = var2.infoType,
                    itemType = var3.itemType,
                    sectionId = var3.sectionId,
                    originalIndex = var3.sectionItemIndex
                })
            else
                local var5 = tbl3[var3.categoryIndex]

                local var6 = toShopItem(var4.value, var3.itemType, var2.id)
                var6.originalIndex = var3.sectionItemIndex
                table.insert(var5.items, var6)
            end
        end

        if #failedItems > 0 then
            logCounter(ProductInfoFailedItemsCounter, #failedItems)
        end

        local tbl10 = tbl3
        if FFlagEnableRobuxInExperienceShop then
            tbl10 = mergeBonusItemDetailsIntoSections(tbl3, tbl7)
        end

        local categories, sections = filterOutput(tbl10)
        return {
            categories = categories,
            sections = sections,
            failedItems = failedItems,
            metadata = if FFlagEnableExperienceShopGlobalIcon then arg1.metadata else nil,
            notificationFreeTrialTopBarChip = readFreeTrialTopBarChipFromNotificationSettings(arg1),
            gamePassTrialAvailabilities = gamePassTrialAvailabilities
        }
    end)
end

return buildShopDataFromWidgets
