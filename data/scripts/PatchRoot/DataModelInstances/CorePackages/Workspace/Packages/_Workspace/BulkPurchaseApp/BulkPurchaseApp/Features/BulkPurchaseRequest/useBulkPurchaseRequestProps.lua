-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarketplaceService = game:GetService("MarketplaceService")
local BrowserService = game:GetService("BrowserService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local useDispatch = require(BulkPurchaseAppParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useSelector = require(BulkPurchaseAppParent.RoactUtils).Hooks.RoactRodux.useSelector
local React = require(BulkPurchaseAppParent.React)
local SignalsReact = require(BulkPurchaseAppParent.SignalsReact)
local SharedFlags = require(BulkPurchaseAppParent.SharedFlags)
local function isInExperienceBuyRobuxRoutingEnabled() -- Luacid: Inlined by compiler; 1 call site recovered
    return SharedFlags.FFlagEnableBuyRobuxNewRouting and SharedFlags.FFlagEnableBuyRobuxNewRoutingInExperience
end

local isErrorReasonContainsEconomicRestrictions = require(BulkPurchaseAppParent.IAPExperience).Utility.isErrorReasonContainsEconomicRestrictions

local mutedError = require(BulkPurchaseAppParent.Loggers).mutedError
local useAppPolicy = require(BulkPurchaseAppParent.UniversalAppPolicy).useAppPolicy
local RobloxSubscriptionPurchaseApp = require(BulkPurchaseAppParent.RobloxSubscriptionPurchaseApp)
local getRobloxSubscriptionProducts = RobloxSubscriptionPurchaseApp.Network.getRobloxSubscriptionProducts
local RobloxSubscriptionSignals = RobloxSubscriptionPurchaseApp.RobloxSubscriptionSignals
local RobloxSubscriptionFlowCompleteReason = RobloxSubscriptionPurchaseApp.RobloxSubscriptionFlowCompleteReason
local SurfaceName = RobloxSubscriptionPurchaseApp.SurfaceName
local SurfaceContext = RobloxSubscriptionPurchaseApp.SurfaceContext
local PurchasePrompt = require(BulkPurchaseAppParent.PurchasePrompt)
local WebViewUtils = require(BulkPurchaseAppParent.WebViewUtils)

local selectPurchaseResults = require(BulkPurchaseApp.Store.Selectors.selectPurchaseResults)
local selectOrderRequest = require(BulkPurchaseApp.Store.Selectors.selectOrderRequest)
local selectItemData = require(BulkPurchaseApp.Store.Selectors.selectItemData)
local BulkPurchaseEnded = require(BulkPurchaseApp.Store.Actions.BulkPurchaseEnded)
local BulkPurchaseFailed = require(BulkPurchaseApp.Store.Actions.BulkPurchaseFailed)
local BulkPurchaseDisablePurchase = require(BulkPurchaseApp.Store.Actions.BulkPurchaseDisablePurchase)
local BulkPurchaseSucceeded = require(BulkPurchaseApp.Store.Actions.BulkPurchaseSucceeded)
local BulkPurchaseCountersEnum = require(BulkPurchaseApp.Enums.BulkPurchaseCountersEnum)
local BulkPurchasePromptStateEnum = require(BulkPurchaseApp.Enums.BulkPurchasePromptStateEnum)
local ErrorCodeEnum = require(BulkPurchaseApp.Enums.ErrorCodeEnum)
local ItemStatusToErrorCodeMap = require(BulkPurchaseApp.Enums.ItemStatusToErrorCodeMap)
local PaymentPlatformEnum = require(BulkPurchaseApp.Enums.PaymentPlatformEnum)
local getPaymentPlatform = require(BulkPurchaseApp.Utils.getPaymentPlatform)
local getRobuxStoreUrl = require(BulkPurchaseApp.Utils.getRobuxStoreUrl)
local getGuiObjectIsObscured = require(BulkPurchaseApp.Utils.getGuiObjectIsObscured)
local reportBulkPurchaseRequestCounters = require(BulkPurchaseApp.Utils.reportBulkPurchaseRequestCounters)
local FFlagFixVP8143 = require(BulkPurchaseApp.Flags.FFlagFixVP8143)
local FFlagBulkPurchaseReportCounters = require(BulkPurchaseApp.Flags.FFlagBulkPurchaseReportCounters)

local getItemResultsFromResponse = require(script.Parent.Utils.getItemResultsFromResponse)
local getCommonItemStatus = require(script.Parent.Utils.getCommonItemStatus)
local handleEconomicRestrictionError = require(script.Parent.Utils.handleEconomicRestrictionError)
local selectBulkPurchaseRequestState = require(script.Parent.Utils.selectBulkPurchaseRequestState)
local selectOptions = require(script.Parent.Utils.selectOptions)

local bool1 = game:DefineFastFlag("FixBuyRobuxForAndroid", false)
local bool2 = game:DefineFastFlag("FixBulkPurchaseInExperienceBuyRobux", false)
local bool3 = game:DefineFastFlag("FixBulkPurchaseStarterGuiRename", false)
local FFlagAXAddPlusUpsellToBulkPurchase = require(BulkPurchaseApp.Flags.FFlagAXAddPlusUpsellToBulkPurchase)
local FFlagAXAddOffersToBulkPurchase = require(BulkPurchaseApp.Flags.FFlagAXAddOffersToBulkPurchase)
local FFlagAXMoreBulkPurchaseCounters = require(BulkPurchaseApp.Flags.FFlagAXMoreBulkPurchaseCounters)
local FFlagBulkPurchaseTestPurchaseHint = require(BulkPurchaseApp.Flags.FFlagBulkPurchaseTestPurchaseHint)
local FIntBlackbirdUpsellMinPriceForDiscountInclusive = SharedFlags.FIntBlackbirdUpsellMinPriceForDiscountInclusive
local FIntBlackbirdUpsellMaxPriceForDiscountInclusive = SharedFlags.FIntBlackbirdUpsellMaxPriceForDiscountInclusive

local _BulkPurchaseRequest = require(script.Parent.BulkPurchaseRequest)

local function useBulkPurchaseRequestProps()
    local var1 = useDispatch()
    local var2 = useSelector(selectBulkPurchaseRequestState)
    local var3 = useSelector(selectPurchaseResults)
    local orderRequest = useSelector(selectOrderRequest)
    local options = useSelector(selectOptions)
    local var4 = useSelector(selectItemData)
    local totalCost = var2.totalCost
    local balance = var2.balance
    local batchPurchaseAuthToken = if FFlagAXAddPlusUpsellToBulkPurchase then orderRequest and orderRequest.batchPurchaseAuthToken else nil

    local var5 = nil
    local var6 = nil
    if FFlagAXAddPlusUpsellToBulkPurchase then
        local var7
        var5, var7 = React.useState({})
        var6 = var7
    end
    local var7 = nil
    if FFlagAXAddPlusUpsellToBulkPurchase then
        local var8 = RobloxSubscriptionSignals.get()
        var7 = SignalsReact.useSignalState(var8.getHasRobloxSubscription)
    end

    local function onClose()
        MarketplaceService:signalPromptBulkPurchaseFinished(2, var3)
        var1(BulkPurchaseEnded())
    end

    local function func2()
        if FFlagAXAddPlusUpsellToBulkPurchase then
            var1(BulkPurchaseDisablePurchase())
        end
        local success, result = pcall(function()
            return MarketplaceService:PerformBulkPurchase(orderRequest, options)
        end)
        if not success or not result then
            if string.find(result, "403") then
                var1(BulkPurchaseFailed(ErrorCodeEnum.TwoStepVerificationRequired))
            else
                var1(BulkPurchaseFailed(ErrorCodeEnum.Generic))
            end

            return
        end

        if result.message and isErrorReasonContainsEconomicRestrictions(result.message) then
            handleEconomicRestrictionError(result.message, var1)
            return
        end

        local itemResultsFromResponse = getItemResultsFromResponse(result, var4)
        local commonItemStatus = getCommonItemStatus(itemResultsFromResponse)
        if not commonItemStatus then
            if FFlagAXMoreBulkPurchaseCounters then
                reportBulkPurchaseRequestCounters(BulkPurchaseCountersEnum.BulkPurchasePartialSuccessCounter)
            end
            var1(BulkPurchaseSucceeded(BulkPurchasePromptStateEnum.PartialSuccess, itemResultsFromResponse))
            return
        end

        if commonItemStatus == Enum.MarketplaceItemPurchaseStatus.Success then
            if FFlagBulkPurchaseReportCounters then
                reportBulkPurchaseRequestCounters(BulkPurchaseCountersEnum.BulkPurchaseSucceededCounter)
            end
            var1(BulkPurchaseSucceeded(BulkPurchasePromptStateEnum.Success, itemResultsFromResponse))
            return
        end
        if FFlagBulkPurchaseReportCounters then
            if FFlagAXMoreBulkPurchaseCounters then
                reportBulkPurchaseRequestCounters(
                    BulkPurchaseCountersEnum.BulkPurchaseFailedCounter,
                    {
                        errorCode = tostring(ItemStatusToErrorCodeMap[commonItemStatus])
                    }
                )
            else
                reportBulkPurchaseRequestCounters(BulkPurchaseCountersEnum.BulkPurchaseFailedCounter)
            end
        end
        var1(BulkPurchaseFailed(ItemStatusToErrorCodeMap[commonItemStatus]))
    end

    local function func3()
        local paymentPlatform = getPaymentPlatform()
        if paymentPlatform ~= PaymentPlatformEnum.Desktop and paymentPlatform ~= PaymentPlatformEnum.Mobile then
            var1(BulkPurchaseFailed(ErrorCodeEnum.InsufficientRobux))

            return
        end

        if isInExperienceBuyRobuxRoutingEnabled() then
            require(BulkPurchaseAppParent.BuyRobuxInExperience).openBuyRobux({}, function(url: string)
                if bool2 then
                    WebViewUtils.openWebViewSession(url, "")
                    return
                end

                if not bool1 then
                    BrowserService:OpenBrowserWindow(url)
                    return
                end

                local command = HttpService:JSONEncode({ command = "open", url = url })

                BrowserService:SendCommand(command)
            end, "BulkPurchase.onRobuxUpsell")
        elseif bool2 then
            WebViewUtils.openWebViewSession(getRobuxStoreUrl(), "")
        elseif bool1 then
            local command = HttpService:JSONEncode({ command = "open", url = getRobuxStoreUrl() })

            BrowserService:SendCommand(command)
        else
            BrowserService:OpenBrowserWindow(getRobuxStoreUrl())
        end

        var1(BulkPurchaseEnded())
    end

    local var8, var9, blackbirdUpsellBannerProductInfo

    if FFlagAXAddPlusUpsellToBulkPurchase then
        local var10 = useAppPolicy(function(arg1)
            return arg1.getDisableBlackbirdEntrypoints()
        end)

        React.useEffect(function()
            getRobloxSubscriptionProducts():andThen(function(arg1)
                var6(arg1)
            end):catch(function(arg1)
                mutedError("BulkPurchasePrompt", "Failed to fetch Roblox subscription products: " .. tostring(arg1))
            end)
        end, {})

        var8 = React.useMemo(function()
            if var7 then
                return false
            end

            if var10 then
                return false
            end

            for _, item in var2.items do
                local cost = item.cost

                if FIntBlackbirdUpsellMinPriceForDiscountInclusive <= cost and item.cost <= FIntBlackbirdUpsellMaxPriceForDiscountInclusive then
                    return true
                end
            end

            return false
        end, { var10, var7, var2.items })

        var9 = React.useCallback(function()
            if FFlagBulkPurchaseReportCounters then
                reportBulkPurchaseRequestCounters(BulkPurchaseCountersEnum.BulkPurchasePlusUpsellInitatedCounter)
            end
            RobloxSubscriptionPurchaseApp.initiateRobloxSubscriptionPurchase(
                { showBackButton = false },
                {
                    onFlowComplete = function(arg1)
                        if arg1 == RobloxSubscriptionFlowCompleteReason.UpsellPurchaseSucceeded and batchPurchaseAuthToken then
                            var1(BulkPurchaseDisablePurchase())
                            if FFlagBulkPurchaseReportCounters then
                                reportBulkPurchaseRequestCounters(BulkPurchaseCountersEnum.BulkPurchasePlusUpsellSucceededCounter)
                            end

                            if not pcall(function()
                                MarketplaceService:RefreshBulkPurchase(batchPurchaseAuthToken)
                            end) then
                                var1(BulkPurchaseFailed(ErrorCodeEnum.Generic))
                            end
                        end

                        if FFlagBulkPurchaseReportCounters and arg1 == RobloxSubscriptionFlowCompleteReason.UpsellPurchaseFailed then
                            reportBulkPurchaseRequestCounters(BulkPurchaseCountersEnum.BulkPurchasePlusUpsellFailedCounter)
                        end
                    end
                },
                nil,
                SurfaceName.BulkPurchasePrompt,
                SurfaceContext.InGame,
                nil,
                nil
            )
        end, { var1, batchPurchaseAuthToken })

        blackbirdUpsellBannerProductInfo = PurchasePrompt.Utils.getBlackbirdUpsellBannerProductInfo(var5)
    else
        var8 = nil
        blackbirdUpsellBannerProductInfo = nil
        var9 = nil
    end

    local var10 = if FFlagAXAddOffersToBulkPurchase then React.useCallback(function(str1: string)
        local unselectedOffers = {}
        if var2.offerData and var2.offerData.offersAvailable then
            local offersAvailable = var2.offerData.offersAvailable

            for value, _ in offersAvailable do
                if value ~= str1 and not offersAvailable[value].selected then
                    table.insert(unselectedOffers, value)
                end

                if value == str1 and offersAvailable[value].selected then
                    table.insert(unselectedOffers, value)
                end
            end
        end

        pcall(function()
            MarketplaceService:RefreshBulkPurchase(batchPurchaseAuthToken, { unselectedOffers = unselectedOffers })
        end)
    end, { var2.offerData, batchPurchaseAuthToken }) else nil

    local var11 = nil
    local var12 = nil
    local var13 = nil
    if FFlagFixVP8143 then
        var11 = React.useRef(nil)
        local var14
        var12, var14 = React.useState(true)
        var13 = var14
        React.useEffect(function()
            local connection = RunService.Heartbeat:Connect(function()
                if var11.current and typeof(var11.current) == "Instance" and var11.current:IsA("GuiObject") then
                    local guiObjectIsObscured = getGuiObjectIsObscured(var11.current)
                    local core = if bool3 then StarterGui:GetCore("DevConsoleVisible") else game.StarterGui:GetCore("DevConsoleVisible")
                    var13(guiObjectIsObscured or core)
                end
            end)
            return function()
                connection:Disconnect()
            end
        end, {})
    end

    local tbl1 = {
        currentBalance = var2.balance,
        items = var2.items,
        ownedItems = var2.ownedItems,
        unpurchasableItems = var2.unpurchasableItems,
        onClose = onClose,
        onAccept = 0,
        totalCost = 0,
        isDisabled = 0,
        purchaseButtonRef = 0,
        discountInformation = 0,
        shouldShowBlackbirdUpsellBanner = 0,
        blackbirdUpsellBannerProductInfo = 0,
        onBlackbirdUpsellActivated = 0,
        offerData = 0,
        toggleOfferSelected = 0,
        isTestPurchase = 0
    }

    if balance < totalCost then
        func2 = func3
    end

    tbl1.onAccept = func2
    tbl1.totalCost = var2.totalCost
    tbl1.isDisabled = FFlagFixVP8143 and var12 or #var2.items == 0 or FFlagAXAddPlusUpsellToBulkPurchase and var2.disablePurchase == true
    tbl1.purchaseButtonRef = if FFlagFixVP8143 then var11 else nil
    tbl1.discountInformation = var2.discountInformation
    if not FFlagAXAddPlusUpsellToBulkPurchase then
        var8 = nil
    end

    tbl1.shouldShowBlackbirdUpsellBanner = var8

    if not FFlagAXAddPlusUpsellToBulkPurchase then
        blackbirdUpsellBannerProductInfo = nil
    end

    tbl1.blackbirdUpsellBannerProductInfo = blackbirdUpsellBannerProductInfo

    if not FFlagAXAddPlusUpsellToBulkPurchase then
        var9 = nil
    end

    tbl1.onBlackbirdUpsellActivated = var9
    tbl1.offerData = if FFlagAXAddOffersToBulkPurchase then var2.offerData else nil
    if not FFlagAXAddOffersToBulkPurchase then
        var10 = nil
    end

    tbl1.toggleOfferSelected = var10
    tbl1.isTestPurchase = if FFlagBulkPurchaseTestPurchaseHint then RunService:IsStudio() else nil
    return tbl1
end

return useBulkPurchaseRequestProps
