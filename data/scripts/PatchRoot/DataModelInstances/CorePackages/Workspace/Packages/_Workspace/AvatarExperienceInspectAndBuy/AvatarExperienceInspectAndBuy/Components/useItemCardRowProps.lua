-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local SessionService = game:GetService("SessionService")
local useTokens = require(AvatarExperienceInspectAndBuyParent.Foundation).Hooks.useTokens
local Localization = require(AvatarExperienceInspectAndBuyParent.Localization)
local AXCommon = require(AvatarExperienceInspectAndBuyParent.AXCommon)
local ItemTypeEnum = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceModel).Enums.ItemTypeEnum
local ItemCardThumbnail = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceUIKit).ItemCardComponents.ItemCardThumbnail
local WearTimeSelectedOptionInList = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceTimedOptions).WearTimeSelectedOptionInList
local useLocalization = Localization.Hooks.useLocalization
local React = require(AvatarExperienceInspectAndBuyParent.React)
local useConvertedItemData = require(AvatarExperienceInspectAndBuy.Hooks.useConvertedItemData)
local _Types = require(AvatarExperienceInspectAndBuy.Types)
local Constants = require(AvatarExperienceInspectAndBuy.Constants)
local AssetLocalizationKeys = Constants.AssetLocalizationKeys
local BundleLocalizationKeys = Constants.BundleLocalizationKeys
local PriceStatusLocalizationKeys = Constants.PriceStatusLocalizationKeys
local AvatarExperienceAnalytics = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceAnalytics)
local addUnifiedEventLogging = AvatarExperienceAnalytics.addUnifiedEventLogging
local UnifiedEventLogEnums = AvatarExperienceAnalytics.UnifiedEventLogEnums
local UnifiedLoggingSurface = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceNavigation).Enums.UnifiedLoggingSurface
local _ViewType = require(AvatarExperienceInspectAndBuy.Enums.ViewType)
local PriceStatus = require(AvatarExperienceInspectAndBuy.Enums.PriceStatus)
local RetrievalStatus = require(AvatarExperienceInspectAndBuyParent.Http).Enum.RetrievalStatus
local getItemThumbnailUrl = require(AvatarExperienceInspectAndBuy.Utils.getItemThumbnailUrl)
local getCatalogCardItemType = require(AvatarExperienceInspectAndBuy.Utils.getCatalogCardItemType)
local getPriceLineContent = require(AvatarExperienceInspectAndBuy.Utils.getPriceLineContent)
local getPriceInRobux = require(AvatarExperienceInspectAndBuy.Utils.itemDetailsUtils).getPriceInRobux
local getPriceStatus = require(AvatarExperienceInspectAndBuy.Utils.getPriceStatus)
local Cryo = require(AvatarExperienceInspectAndBuyParent.Cryo)
local useSignalState = require(AvatarExperienceInspectAndBuyParent.SignalsReact).useSignalState
local useItemSelectionStore = require(AvatarExperienceInspectAndBuy.Contexts.ItemSelectionStoreContext).useItemSelectionStore

local FFlagAXMarketplaceLicensingItemCards = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceFlags).FFlagAXMarketplaceLicensingItemCards

local CatalogItemCardStatusIconTypeEnum = AXCommon.Components.CatalogItemCard.CatalogItemCardStatusIconTypeEnum

return function(arg1, layoutOrder: number, _, callback: (...any) -> (...any), num1: number)
    local var1 = useTokens()
    local var2, var3 = useConvertedItemData(arg1)
    local var4 = if arg1.itemType == ItemTypeEnum.Bundle then BundleLocalizationKeys else AssetLocalizationKeys
    local var5 = Cryo.Dictionary.join(var4, PriceStatusLocalizationKeys)
    local var6 = useLocalization(var5)

    local var7 = useItemSelectionStore()
    local var8 = useSignalState(var7.getItemData(arg1.id))

    local isOwned = React.useMemo(function(): boolean
        return getPriceStatus(var2) == PriceStatus.Owned
    end, { var2 })

    React.useEffect(function()
        if not (var2 and var2.timedOptions) then
            return
        end

        local price = getPriceInRobux(var2, getPriceStatus(var2)) or 0
        local timedOptions = table.clone(var2.timedOptions)
        table.insert(timedOptions, { days = 0, price = price, selected = true })

        var7.setItemData(arg1.id, { timedOptions = timedOptions })
    end, { var2, arg1.id, var7 })

    local onTimedOptionPriceChanged = React.useCallback(function(price: number, days: number?)
        if not (var8 and var8.timedOptions) then
            return
        end

        local timedOptions = {}
        for _, timedOption in var8.timedOptions do
            table.insert(timedOptions, {
                days = timedOption.days,
                price = timedOption.price,
                selected = timedOption.price == price and (days == nil or timedOption.days == days)
            })
        end

        var7.setItemData(arg1.id, { timedOptions = timedOptions })
    end, { arg1.id, var8, var7 })

    local timedOptions = if var8 then var8.timedOptions or nil else nil

    local selectedTimedOptionPrice = React.useMemo(function()
        if not timedOptions then
            return nil
        end
        for _, timedOption in timedOptions do
            if timedOption.selected then
                return timedOption.price
            end
        end
        return nil
    end, { timedOptions })

    if not var2 then
        return {}
    end

    local url = getItemThumbnailUrl(arg1)
    local itemSubType = var6[var2.itemSubType]
    local itemType = getCatalogCardItemType(var2.itemRestrictions)
    local itemStatus = if var2.timedOptions then not isOwned and {
        type = "icon",
        iconType = CatalogItemCardStatusIconTypeEnum.Durable
    } or nil else nil
    local priceLineContent = if var3 == RetrievalStatus.Done then getPriceLineContent(var2, var1, var6) else nil
    local creator = var2.creator and {
        name = var2.creator.creatorName or "",
        verified = var2.creator.creatorHasVerifiedBadge
    } or nil

    local ref = React.useRef(nil)
    React.useEffect(function()
        addUnifiedEventLogging(ref, {
            action = UnifiedEventLogEnums.MarketplaceUnifiedAction.UI_ELEMENT_CLICK,
            surface = UnifiedLoggingSurface.IN_EXPERIENCE_INSPECT_BUY,
            elementName = "CLICK_INSPECTBUY_ITEM_" .. arg1.id
        }, {
            sessionTagName = SessionService:GetSessionTag("level2a")
        })
    end, { arg1.id })

    local onActivated = React.useCallback(function()
        callback(arg1)
    end, { callback, arg1 })

    return {
        title = var2.name,
        presentationSlot = React.createElement(ItemCardThumbnail, { url = url }),
        itemSubType = itemSubType,
        itemType = itemType,
        creator = creator,
        itemLicensingInfo = if FFlagAXMarketplaceLicensingItemCards then var2.itemLicensingInfo else nil,
        priceLineContent = priceLineContent,
        LayoutOrder = layoutOrder,
        Size = UDim2.fromOffset(num1, 0),
        headerSize = UDim2.fromOffset(num1, num1),
        footerAutomaticSize = Enum.AutomaticSize.XY,
        AutomaticSize = Enum.AutomaticSize.XY,
        onActivated = onActivated,
        ref = ref,
        itemStatus = itemStatus,
        isOwned = isOwned,
        timedOptions = timedOptions,
        onTimedOptionPriceChanged = onTimedOptionPriceChanged,
        selectedTimedOptionPrice = selectedTimedOptionPrice,
        wearTimeSelectedOptionInList = WearTimeSelectedOptionInList
    }
end
