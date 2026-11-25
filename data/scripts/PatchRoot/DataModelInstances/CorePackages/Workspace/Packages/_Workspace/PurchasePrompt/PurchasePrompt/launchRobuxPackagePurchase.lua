-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local SharedFlags = require(PurchasePromptParent.SharedFlags)

local ContentProvider = game:GetService("ContentProvider")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local WebViewService = game:GetService("WebViewService")

local PlatformService = nil

pcall(function()
    PlatformService = game:GetService("PlatformService")
end)

local UpsellFlow = require(PurchasePrompt.Enums.UpsellFlow)
local getUpsellFlow = require(PurchasePrompt.NativeUpsell.getUpsellFlow)
local GetFFlagEnablePaymentSessionIdInRobuxPurchase = require(PurchasePrompt.Flags.GetFFlagEnablePaymentSessionIdInRobuxPurchase)

local getEngineFeaturePromptNativePurchaseWithContext = require(PurchasePrompt.Flags.getEngineFeaturePromptNativePurchaseWithContext)
local FFlagEnableBonusJwtInShop = SharedFlags.FFlagEnableBonusJwtInShop

local function getWebBaseUrl() -- Luacid: Inlined by compiler; 1 call site recovered
    local str1 = ContentProvider.BaseUrl:lower()
    return (string.gsub(str1, "/m%.", "/www."))
end

local function openRobuxPackageWebView(url: string, callback: ((...any) -> (...any))?) -- Luacid: Inlined by compiler; 1 call site recovered
    local connection = nil
    connection = WebViewService.OnWindowClosed:Connect(function()
        WebViewService:CloseWindow()
        if connection then
            connection:Disconnect()
            connection = nil
        end
        if callback then
            callback()
        end
    end)
    WebViewService:OpenWindow(url, "", true)
end

local function tryLaunchNativePurchaseWithContext(tbl1, paymentSessionId: string): boolean
    local purchaseType = tbl1.purchaseType
    local isInApp = tbl1.isInApp
    if purchaseType == nil or isInApp == nil then
        return false
    end

    local marketplaceService = MarketplaceService
    local promptNativePurchaseWithContext = marketplaceService.PromptNativePurchaseWithContext
    if typeof(promptNativePurchaseWithContext) ~= "function" then
        return false
    end

    local tbl2 = { paymentSessionId = 0, purchaseType = 0, isInApp = 0 }
    if paymentSessionId == "" then
        paymentSessionId = nil
    end

    tbl2.paymentSessionId = paymentSessionId
    tbl2.purchaseType = purchaseType
    tbl2.isInApp = isInApp

    local bool1 = false
    pcall(function()
        promptNativePurchaseWithContext(marketplaceService, tbl1.mobileProductId, tbl2)
        bool1 = true
        if tbl1.onNativePurchaseLaunched ~= nil then
            tbl1.onNativePurchaseLaunched()
        end
    end)
    return bool1
end

local function startPurchase(tbl1, str1: string)
    local mobileProductId = tbl1.mobileProductId
    local productId = tbl1.productId

    local platform = UserInputService:GetPlatform()
    local upsellFlow = getUpsellFlow(platform)

    if upsellFlow ~= UpsellFlow.Mobile then
        if upsellFlow == UpsellFlow.Xbox then
            if PlatformService == nil then
                return
            end
            pcall(function()
                PlatformService:BeginPlatformStorePurchase(mobileProductId)
            end)
        elseif upsellFlow == UpsellFlow.Web then
            if productId == nil then
                return
            end
            local str2 = ("%supgrades/paymentmethods?ap=%s"):format(getWebBaseUrl(), tostring(productId))
            if str1 ~= "" then
                str2 = ("%s&paymentSessionId=%s"):format(str2, str1)
            end
            pcall(function()
                openRobuxPackageWebView(str2, tbl1.onWebViewClosed)
            end)
        end

        return
    end

    if getEngineFeaturePromptNativePurchaseWithContext() and tryLaunchNativePurchaseWithContext(tbl1, str1) then
        return
    end

    local localPlayer = Players.LocalPlayer
    local engineFeature = game:GetEngineFeature("NativePurchaseWithLocalPlayer")
    local engineFeature2 = game:GetEngineFeature("PromptNativePurchaseWithPaymentSessionId")

    pcall(function()
        local marketplaceService = MarketplaceService

        local promptNativePurchaseWithLocalPlayerWithPaymentSessionId = marketplaceService.PromptNativePurchaseWithLocalPlayerWithPaymentSessionId
        local promptNativePurchaseWithLocalPlayer = marketplaceService.PromptNativePurchaseWithLocalPlayer
        local promptNativePurchaseWithPaymentSessionId = marketplaceService.PromptNativePurchaseWithPaymentSessionId
        local promptNativePurchase = marketplaceService.PromptNativePurchase

        if engineFeature and engineFeature2 and typeof(promptNativePurchaseWithLocalPlayerWithPaymentSessionId) == "function" then
            promptNativePurchaseWithLocalPlayerWithPaymentSessionId(marketplaceService, mobileProductId, str1)
        elseif engineFeature and typeof(promptNativePurchaseWithLocalPlayer) == "function" then
            promptNativePurchaseWithLocalPlayer(marketplaceService, mobileProductId)
        elseif engineFeature2 and typeof(promptNativePurchaseWithPaymentSessionId) == "function" then
            promptNativePurchaseWithPaymentSessionId(marketplaceService, localPlayer, mobileProductId, str1)
        elseif typeof(promptNativePurchase) == "function" then
            promptNativePurchase(marketplaceService, localPlayer, mobileProductId)
        else
            error("MarketplaceService has no PromptNativePurchase APIs bound")
        end

        if tbl1.onNativePurchaseLaunched ~= nil then
            tbl1.onNativePurchaseLaunched()
        end
    end)
end

local function launchRobuxPackagePurchase(tbl1)
    local paymentSessionId = GetFFlagEnablePaymentSessionIdInRobuxPurchase() and tbl1.paymentSessionId or ""

    if RunService:IsStudio() then
        return nil
    end

    if FFlagEnableBonusJwtInShop then
        local upsellFlow = getUpsellFlow(UserInputService:GetPlatform())
        local bool1 = not (upsellFlow == UpsellFlow.Mobile) and upsellFlow ~= UpsellFlow.Web
        local bonusJwt = tbl1.bonusJwt
        local redeemBonusToken = tbl1.redeemBonusToken
        if not bool1 and typeof(bonusJwt) == "string" and bonusJwt ~= "" and redeemBonusToken ~= nil then
            local success, result = pcall(function()
                return redeemBonusToken(bonusJwt, game.GameId)
            end)
            if not success or typeof(result) ~= "table" or typeof(result.andThen) ~= "function" then
                return nil
            end

            return result:andThen(function(arg1)
                local var1 = if typeof(arg1) ~= "string" then "" else arg1
                startPurchase(tbl1, var1)
            end)
        end
    end

    startPurchase(tbl1, paymentSessionId)
    return nil
end

return launchRobuxPackagePurchase
