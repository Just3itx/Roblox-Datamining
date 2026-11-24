-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local SessionService = game:GetService("SessionService")

local React = require(InExperienceShopParent.React)
local Foundation = require(InExperienceShopParent.Foundation)
local SignalsReact = require(InExperienceShopParent.SignalsReact)
local PurchasePrompt = require(InExperienceShopParent.PurchasePrompt)
local Promise = require(InExperienceShopParent.Promise)

local View = Foundation.View

local FIntShopOwnershipFetchMaxAttempts = require(InExperienceShop.Flags.FIntShopOwnershipFetchMaxAttempts)
local FFlagEnableInExperienceShopUnifiedLogging = require(InExperienceShop.Flags.FFlagEnableInExperienceShopUnifiedLogging)
local FFlagEnableCategoryLoggingInShop = require(InExperienceShop.Flags.FFlagEnableCategoryLoggingInShop)
local FFlagShopUseMockUserOwnsGamePass = require(InExperienceShop.Flags.FFlagShopUseMockUserOwnsGamePass)
local FFlagSkipPaymentSessionForPlainRobux = require(InExperienceShop.Flags.FFlagSkipPaymentSessionForPlainRobux)
local FFlagHideBonusInShopWhenNotClaimable = require(InExperienceShop.Flags.FFlagHideBonusInShopWhenNotClaimable)
local FFlagEnableBonusJwtInShop = require(InExperienceShopParent.SharedFlags).FFlagEnableBonusJwtInShop
local FFlagShopListenNativePurchaseFinished = require(InExperienceShop.Flags.FFlagShopListenNativePurchaseFinished)
local FFlagShopRobuxPurchaseCompletionModal = require(InExperienceShop.Flags.FFlagShopRobuxPurchaseCompletionModal)
local FFlagRefetchRobuxWidgetAfterPurchase = require(InExperienceShop.Flags.FFlagRefetchRobuxWidgetAfterPurchase)
local FFlagEnableShopRobuxBuyTelemetry = require(InExperienceShop.Flags.FFlagEnableShopRobuxBuyTelemetry)
local GetBlockRobuxTileClickInShop = require(InExperienceShop.Flags.GetBlockRobuxTileClickInShop)
local userOwnsGamePassHttp = require(InExperienceShop.Api.userOwnsGamePassHttp)
local MockUserOwnsGamePass = require(InExperienceShop.Mocks.MockUserOwnsGamePass)
local RobuxPackageTile = require(InExperienceShop.Components.RobuxPackageTile)
local ShopDebugLogger = require(InExperienceShop.Internal.ShopDebugLogger)
local getInExperienceShopStore = require(InExperienceShop.Stores.getInExperienceShopStore)
local toUnifiedCategoryId = require(InExperienceShop.Analytics.toUnifiedCategoryId)
local getRobuxPackageBonusPresentation = require(InExperienceShop.Utils.getRobuxPackageBonusPresentation)
local promoteBonusRobuxPackageToTopPicks = require(InExperienceShop.Api.promoteBonusRobuxPackageToTopPicks)
local redeemBonusToken = require(InExperienceShop.Api.redeemBonusToken)

local _Types = require(InExperienceShop.Types)

local function isPromise(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return typeof(arg1) == "table" and typeof(arg1.andThen) == "function"
end

return React.memo(function(tbl1) -- name: RobuxPackageTileContainer
    local pkg = tbl1.pkg
    local var1 = React.useRef(nil)
    local var2 = SignalsReact.useSignalState(getInExperienceShopStore)
    local bonusGamePassId = promoteBonusRobuxPackageToTopPicks.getBonusGamePassId(pkg)

    local var3 = nil
    local var4 = nil
    local var5 = nil
    local var6 = nil
    local var7 = nil

    if FFlagEnableBonusJwtInShop then
        local var8
        var3, var8 = React.useState(false)
        var4 = var8
        var5 = React.useRef(false)
        var6 = React.useRef(true)
        var7 = React.useRef(nil)

        React.useEffect(function()
            var6.current = true
            return function()
                var6.current = false
                local current = var7.current
                var7.current = nil
                if current ~= nil and typeof(current.cancel) == "function" then
                    current:cancel()
                end
            end
        end, {})
    end

    local var8 = SignalsReact.useSignalState(function(arg1)
        local ownership = var2.getOwnership(arg1)
        return if bonusGamePassId == nil then nil else ownership[bonusGamePassId]
    end)

    local var9 = SignalsReact.useSignalState(function(arg1)
        local bonusPromotionEligibility = var2.getBonusPromotionEligibility(arg1)
        return if bonusGamePassId == nil then nil else bonusPromotionEligibility[bonusGamePassId]
    end)

    local robuxPackageBonusPresentation = getRobuxPackageBonusPresentation(pkg, var8, var9)

    local mobileProductId = pkg.mobileProductId
    local productId = pkg.productId
    local paymentSessionId = tbl1.paymentSessionId
    local bonusJwt = if FFlagEnableBonusJwtInShop then tbl1.bonusJwt else nil
    local hasBonusItem = robuxPackageBonusPresentation.hasBonusItem

    local var10 = hasBonusItem
        and (not FFlagHideBonusInShopWhenNotClaimable
            or paymentSessionId ~= nil and paymentSessionId ~= ""
            or not (bonusJwt == nil) and bonusJwt ~= "")

    local useEffect = React.useEffect
    local function func1()
        if not FFlagEnableInExperienceShopUnifiedLogging then
            return
        end

        task.defer(function()
            local avatarExperienceAnalytics = require(InExperienceShopParent.AvatarExperienceAnalytics)
            local addUnifiedEventLogging = avatarExperienceAnalytics.addUnifiedEventLogging
            local marketplaceUnifiedItemType = avatarExperienceAnalytics.UnifiedEventLogEnums.MarketplaceUnifiedItemType

            local fFlagAxUnifiedEventStrictPayloads = avatarExperienceAnalytics.Flags.FFlagAXUnifiedEventStrictPayloads
            local bool1 = pkg.bonusItem ~= nil
            local tbl2 = {
                universeId = game.GameId,
                itemId = if fFlagAxUnifiedEventStrictPayloads then tostring(if productId ~= nil then productId else pkg.id) elseif productId ~= nil then productId else pkg.id,
                itemType = if bool1 then marketplaceUnifiedItemType.ROBUX_WITH_BONUS else marketplaceUnifiedItemType.ROBUX,
                categoryId = if fFlagAxUnifiedEventStrictPayloads then toUnifiedCategoryId(tbl1.categoryId) else tbl1.categoryId,
                categoryType = tbl1.categoryType,
                gridPositionRow = tbl1.gridPositionRow,
                gridPositionColumn = tbl1.gridPositionColumn,
                stableCategoryId = if FFlagEnableCategoryLoggingInShop then tbl1.stableCategoryId else nil,
                categoryGroup = if FFlagEnableCategoryLoggingInShop then tbl1.categoryGroup else nil,
                categoryName = if FFlagEnableCategoryLoggingInShop then tbl1.categoryName else nil
            }

            addUnifiedEventLogging(var1, tbl2, { sessionTagName = SessionService:GetSessionTag("level2a") })
        end)
    end

    local id = pkg.id

    local bonusItem = pkg.bonusItem
    local categoryId = tbl1.categoryId
    local categoryType = tbl1.categoryType
    local gridPositionRow = tbl1.gridPositionRow
    local gridPositionColumn = tbl1.gridPositionColumn
    local stableCategoryId = if FFlagEnableCategoryLoggingInShop then tbl1.stableCategoryId else nil
    local categoryGroup = if FFlagEnableCategoryLoggingInShop then tbl1.categoryGroup else nil
    local categoryName = if FFlagEnableCategoryLoggingInShop then tbl1.categoryName else nil
    useEffect(func1, {
        id,
        productId,
        bonusItem,
        categoryId,
        categoryType,
        gridPositionRow,
        gridPositionColumn,
        stableCategoryId,
        categoryGroup,
        categoryName
    })

    local onWebViewClosed = React.useCallback(function()
        if bonusGamePassId ~= nil then
            ShopDebugLogger.logLazy(function()
                return "refreshBonusOwnership: polling bonusGamePassId=" .. bonusGamePassId
            end)

            local var11 = if FFlagShopUseMockUserOwnsGamePass then MockUserOwnsGamePass else userOwnsGamePassHttp
            var2.pollGamePassOwnership(bonusGamePassId, FIntShopOwnershipFetchMaxAttempts, var11, true)
        else
            ShopDebugLogger.log("refreshBonusOwnership: skip poll, no bonus game pass")
        end

        if FFlagRefetchRobuxWidgetAfterPurchase and (bonusGamePassId ~= nil or not FFlagSkipPaymentSessionForPlainRobux) then
            var2.refreshRobuxWidgetsAfterPurchase()
        end
    end, { bonusGamePassId, var2 })

    local onNativePurchaseLaunched = if FFlagShopListenNativePurchaseFinished then React.useCallback(function()
        if mobileProductId == nil or mobileProductId == "" then
            ShopDebugLogger.log("onNativePurchaseLaunched: skip, no store SKU")
            return
        end

        if not FFlagRefetchRobuxWidgetAfterPurchase and not FFlagShopRobuxPurchaseCompletionModal and bonusGamePassId == nil then
            ShopDebugLogger.log("onNativePurchaseLaunched: skip, no bonus game pass")
            return
        end

        ShopDebugLogger.logLazy(function()
            return "onNativePurchaseLaunched: recording bonusGamePassId=" .. tostring(bonusGamePassId) .. " storeSku=" .. mobileProductId
        end)
        if FFlagShopRobuxPurchaseCompletionModal then
            var2.bonusGamePassIdForNativePurchase(bonusGamePassId, mobileProductId, pkg.robuxAmount)
            return
        end
        var2.bonusGamePassIdForNativePurchase(bonusGamePassId, mobileProductId)
    end, {
        bonusGamePassId,
        mobileProductId,
        pkg.robuxAmount,
        var2
    }) else nil

    local onBuyActivated = React.useCallback(function()
        local launchRobuxPackagePurchase = PurchasePrompt.launchRobuxPackagePurchase
        if launchRobuxPackagePurchase == nil then
            ShopDebugLogger.log("onBuyActivated: skip, launchRobuxPackagePurchase missing")
            return
        end

        if FFlagEnableBonusJwtInShop and var5.current then
            return
        end

        if FFlagEnableShopRobuxBuyTelemetry and FFlagEnableInExperienceShopUnifiedLogging and var1.current ~= nil then
            require(InExperienceShop.Analytics.sendRobuxBuyClickUnifiedEvent)(var1.current, tbl1.shopPageType)
        end

        local var13 = paymentSessionId
        if FFlagSkipPaymentSessionForPlainRobux then
            var13 = if hasBonusItem then var13 else ""
        end

        ShopDebugLogger.logLazy(function(): string
            return "onBuyActivated: launch mobileProductId=" .. tostring(mobileProductId) .. " productId=" .. tostring(productId) .. " bonusGamePassId=" .. tostring(bonusGamePassId)
        end)

        local tbl2 = {
            mobileProductId = mobileProductId or "",
            productId = productId,
            paymentSessionId = var13,
            onWebViewClosed = onWebViewClosed
        }
        if FFlagShopListenNativePurchaseFinished then
            tbl2.onNativePurchaseLaunched = onNativePurchaseLaunched
        end

        if not FFlagEnableBonusJwtInShop then
            launchRobuxPackagePurchase(tbl2)
            return
        end

        tbl2.bonusJwt = if FFlagSkipPaymentSessionForPlainRobux and not hasBonusItem then "" else bonusJwt
        if FFlagRefetchRobuxWidgetAfterPurchase then
            function tbl2.redeemBonusToken(str1: string, num1: number)
                return redeemBonusToken(str1, num1):catch(function(arg1)
                    if typeof(arg1) ~= "table" or arg1.kind ~= "BadRequest" then
                        return Promise.reject(arg1)
                    end
                    ShopDebugLogger.log("redeemBonusToken: HTTP 400, refreshing Robux widgets")
                    local var14 = var2.refreshRobuxWidgetsAfterPurchase()

                    if not isPromise(var14) then
                        var14 = Promise.resolve()
                    end

                    return var14:andThen(function()
                        return Promise.reject(arg1)
                    end)
                end)
            end
        else
            tbl2.redeemBonusToken = redeemBonusToken
        end
        local current = launchRobuxPackagePurchase(tbl2)

        if not isPromise(current) then
            return
        end

        var5.current = true
        var7.current = current
        var4(true)

        local function settle()
            var5.current = false
            var7.current = nil
            if var6.current then
                var4(false)
            end
        end

        current:catch(function(arg1)
            ShopDebugLogger.logLazy(function(): string
                local var15 = if typeof(arg1) == "table" then tostring(arg1.message) else tostring(arg1)
                return "RobuxPackageTile: purchase launch failed err=" .. var15
            end)
        end):finally(settle)
    end, {
        mobileProductId,
        productId,
        paymentSessionId,
        bonusJwt,
        onWebViewClosed,
        onNativePurchaseLaunched,
        hasBonusItem,
        bonusGamePassId,
        var2,
        tbl1.shopPageType
    })

    local bonusItemDetails = pkg.bonusItemDetails
    local onBonusItemActivated = tbl1.onBonusItemActivated
    local onTileActivated = React.useCallback(function()
        if GetBlockRobuxTileClickInShop() or not var10 or bonusItemDetails == nil or onBonusItemActivated == nil then
            return
        end

        local itemType = bonusItemDetails.itemType
        if itemType == nil then
            return
        end
        onBonusItemActivated(bonusItemDetails.id, itemType)
    end, { var10, bonusItemDetails, onBonusItemActivated })

    local createElement = React.createElement
    local var15 = View
    local tbl2 = {
        tag = "fill size-full-0",
        LayoutOrder = tbl1.LayoutOrder,
        ref = if FFlagEnableInExperienceShopUnifiedLogging then var1 else nil
    }
    local tbl3 = { Tile = 0 }
    local createElement2 = React.createElement
    local var16 = RobuxPackageTile
    local tbl4 = {
        robuxAmount = pkg.robuxAmount,
        currencyAmountStr = pkg.currencyAmountStr,
        robuxImage = pkg.robuxImage,
        hasBonusItem = var10,
        bonusItemThumbnail = robuxPackageBonusPresentation.bonusItemThumbnail,
        onTileActivated = onTileActivated,
        onBuyActivated = onBuyActivated,
        isBuyLoading = 0,
        isPrimaryRobuxPackage = 0,
        mediaHeightScale = 0
    }

    if not FFlagEnableBonusJwtInShop then
        var3 = nil
    end

    tbl4.isBuyLoading = var3
    tbl4.isPrimaryRobuxPackage = pkg.isPrimaryRobuxPackage == true
    tbl4.mediaHeightScale = tbl1.mediaHeightScale
    tbl3.Tile = createElement2(var16, tbl4)
    return createElement(var15, tbl2, tbl3)
end)
