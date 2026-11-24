-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local SignalsReact = require(InExperienceShopParent.SignalsReact)
local useLocalization = require(InExperienceShopParent.Localization).Hooks.useLocalization

local SharedFlags = require(InExperienceShopParent.SharedFlags)
local AbuseVector = require(InExperienceShopParent.GenericAbuseReporting.AbuseVector)
local FFlagLuaAppEnableGamePassFreeTrials = require(InExperienceShop.Flags.FFlagLuaAppEnableGamePassFreeTrials)
local FFlagEnableFreeTrialTopBarChip = require(InExperienceShop.Flags.FFlagEnableFreeTrialTopBarChip)
local FFlagEnableGamePassTrialUnifiedLogging = require(InExperienceShop.Flags.FFlagEnableGamePassTrialUnifiedLogging)

local initiateShopItemPurchase = require(InExperienceShop.initiateShopItemPurchase)
local FFlagCategoryLoggingInShopPurchase = require(InExperienceShop.Flags.FFlagCategoryLoggingInShopPurchase)
local formatUpdatedDate = require(InExperienceShop.Utils.formatUpdatedDate)
local getInExperienceShopStore = require(InExperienceShop.Stores.getInExperienceShopStore)
local Constants = require(InExperienceShop.Constants)
local ShopPageType = if SharedFlags.FFlagPassShopPurchaseSurfaceToBuyModal then require(InExperienceShop.Analytics.Constants).ShopPageType else nil
local useGamePassTrialRedemption = require(InExperienceShop.Hooks.useGamePassTrialRedemption)
local useShopReportOverflow = require(InExperienceShop.Hooks.useShopReportOverflow)

local _Types = require(InExperienceShop.Types)

local _ItemDetailsView = require(script.Parent.ItemDetailsView)

local tbl1 = { product = "Feature.DeveloperProducts.Label.Product" }

local function findSectionForItem(tbl2, id: string, itemType)
    for _, value in tbl2 do
        for _, item in value.items do
            if item.id == id and item.itemType == itemType then
                return value
            end
        end
    end
    return nil
end

local function categoryLabelForType(itemType, product: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return if itemType == "GamePass" then "Game pass" else product
end

local function useItemDetailsViewModel(tbl2)
    local item = tbl2.item
    local var1 = useLocalization(tbl1)

    local var2 = SignalsReact.useSignalState(getInExperienceShopStore)

    local var3 = if FFlagCategoryLoggingInShopPurchase then SignalsReact.useSignalState(var2.getSections) else nil

    local var4 = SignalsReact.useSignalState(function(arg1)
        return var2.getOwnership(arg1)[item.id]
    end)

    local showTry = SignalsReact.useSignalState(function(arg1): boolean
        if FFlagLuaAppEnableGamePassFreeTrials and item.itemType == "GamePass" then
            return var2.getTrialAvailabilities(arg1).available[item.id] == true
        end

        var2.getOwnership(arg1)
        return false
    end)

    React.useEffect(function()
        if item.itemType == "GamePass" then
            var2.fetchGamePassOwnership(item.id)
        end
    end, { item.id, item.itemType, var2.fetchGamePassOwnership })

    local isOwned = if var4 == nil then item.isOwned else var4

    local var7 = React.useMemo(function()
        local var7 = nil
        if FFlagCategoryLoggingInShopPurchase and var3 ~= nil then
            local sectionForItem = findSectionForItem(var3, item.id, item.itemType)
            var7 = sectionForItem ~= nil
                and {
                    categoryGroup = sectionForItem.categoryGroup,
                    categoryPosition = sectionForItem.id,
                    categoryName = sectionForItem.name,
                    stableCategoryId = sectionForItem.stableCategoryId
                }
                or var7
        end

        return {
            shopPageType = if ShopPageType then ShopPageType.Category else nil,
            categoryLocation = var7,
            trialStatus = FFlagEnableGamePassTrialUnifiedLogging
                and item.itemType == "GamePass"
                and (if showTry and isOwned ~= true then "available" else "unavailable")
                or nil
        }
    end, {
        item.id,
        item.itemType,
        var3,
        if FFlagEnableGamePassTrialUnifiedLogging then showTry else nil,
        if FFlagEnableGamePassTrialUnifiedLogging then isOwned else nil
    })

    local onBuyActivated = React.useCallback(function()
        local categoryLocation = var7.categoryLocation
        if categoryLocation ~= nil then
            initiateShopItemPurchase(item.id, item.itemType, var7.shopPageType, categoryLocation)
            return
        end
        initiateShopItemPurchase(item.id, item.itemType, var7.shopPageType)
    end, { item.id, item.itemType, var7 })

    local var9 = useGamePassTrialRedemption
    local id = item.id
    local thumbnail = if FFlagEnableFreeTrialTopBarChip then item.thumbnail else nil
    local var10 = var9(id, var7, thumbnail)

    if FFlagEnableGamePassTrialUnifiedLogging then
        local var11 = React.useRef(nil)
        React.useEffect(function()
            if item.itemType ~= "GamePass" or not showTry or var4 ~= false or var11.current == item.id then
                return
            end

            var11.current = item.id
            local sendGamePassTrialUnifiedEvent = require(InExperienceShop.Analytics.sendGamePassTrialUnifiedEvent)
            sendGamePassTrialUnifiedEvent.send({
                action = sendGamePassTrialUnifiedEvent.impressionAction,
                elementName = sendGamePassTrialUnifiedEvent.trialElement,
                itemId = item.id,
                shopPageType = var7.shopPageType,
                trialStatus = var7.trialStatus
            })
        end, {
            item.id,
            item.itemType,
            showTry,
            var4,
            var7
        })
    end
    local fFlagEnableReportingFlowForExperienceShop = SharedFlags.FFlagEnableReportingFlowForExperienceShop

    local buildReportSession = React.useCallback(function()
        return if item.itemType == "GamePass" then {
            abuseVector = AbuseVector.GamePass,
            targetId = item.id
        } else {
            abuseVector = AbuseVector.DeveloperProduct,
            targetId = item.id
        }
    end, { item.id, item.itemType })

    local var12 = useShopReportOverflow.useShopReportOverflow(
        {
            isReportingEnabled = fFlagEnableReportingFlowForExperienceShop,
            buildReportSession = buildReportSession
        }
    )
    local updated = React.useMemo(function()
        return formatUpdatedDate(item.updated)
    end, { item.updated })

    local categoryLabel = categoryLabelForType(item.itemType, var1.product)

    local isCompact, var15 = React.useState(false)

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        local absoluteSizeX = arg1.AbsoluteSize.X
        if absoluteSizeX <= 0 then
            return
        end
        local bool1 = absoluteSizeX < Constants.COMPACT_BREAKPOINT_WIDTH
        var15(function(arg2)
            return if arg2 == bool1 then arg2 else bool1
        end)
    end, {})

    return {
        itemId = item.id,
        name = item.name,
        thumbnail = item.thumbnail,
        price = item.price,
        isOwned = isOwned,
        showTry = showTry,
        isActionLoading = var10.isActionLoading,
        isActionDisabled = var10.isActionDisabled,
        isBuyDisabled = tbl2.disableBuy == true,
        description = item.description,
        creator = item.creator,
        categoryLabel = categoryLabel,
        updated = updated,
        isCompact = isCompact,
        isOverflowMenuOpen = var12.isOverflowMenuOpen,
        isReportingEnabled = var12.isReportingEnabled,
        reportSession = var12.reportSession,
        onClose = tbl2.onClose,
        onBuyActivated = onBuyActivated,
        onTryActivated = var10.onTryActivated,
        onOverflowActivated = var12.onOverflowActivated,
        onOverflowMenuClosed = var12.onOverflowMenuClosed,
        onMenuItemActivated = var12.onMenuItemActivated,
        onReportClose = var12.onReportClose,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged
    }
end

return useItemDetailsViewModel
