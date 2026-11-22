-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local Signals = require(RobloxSubscriptionPurchaseAppParent.Signals)

local PromptState = require(RobloxSubscriptionPurchaseApp.Enums.PromptState)
local _RobloxSubscriptionFlowCompleteReason = require(RobloxSubscriptionPurchaseApp.Enums.RobloxSubscriptionFlowCompleteReason)
local _GetRobloxSubscriptionProductsModel = require(RobloxSubscriptionPurchaseApp.Models.GetRobloxSubscriptionProductsModel)
local _ErrorReason = require(RobloxSubscriptionPurchaseApp.Enums.ErrorReason)
local _types = require(RobloxSubscriptionPurchaseApp.types)

local var1 = nil

local function func1()
    local getPromptState, setPromptState = Signals.createSignal(PromptState.Unspecified)

    local getRobloxSubscriptionProduct, setRobloxSubscriptionProduct = Signals.createSignal(nil)
    local getDidTryPurchasing, setDidTryPurchasing = Signals.createSignal(false)
    local getPurchaseUiOptions, setPurchaseUiOptions = Signals.createSignal({})
    local getPaymentSessionId, setPaymentSessionId = Signals.createSignal("")
    local getIsNativePurchase, setIsNativePurchase = Signals.createSignal(false)
    local getEntryContext, setEntryContext = Signals.createSignal({})
    local getPurchaseFlowOptions, setPurchaseFlowOptions = Signals.createSignal({})
    local getErrorReason, setErrorReason = Signals.createSignal(nil)
    local getReferrerId, setReferrerId = Signals.createSignal(nil)

    local getRobloxSubscriptionProductId = Signals.createComputed(function(arg1)
        local var22 = getRobloxSubscriptionProduct(arg1)

        return var22 and var22.ProductKey and var22.ProductKey.Id or ""
    end)

    local var22 = nil
    local var23 = nil
    local var24 = nil
    local getOnCtaOverride = nil
    local getMembershipConfigSnapshot = nil

    return {
        getPromptState = getPromptState,
        setPromptState = setPromptState,
        getRobloxSubscriptionProduct = getRobloxSubscriptionProduct,
        setRobloxSubscriptionProduct = setRobloxSubscriptionProduct,
        getPurchaseFlowOptions = getPurchaseFlowOptions,
        setPurchaseFlowOptions = setPurchaseFlowOptions,
        getDidTryPurchasing = getDidTryPurchasing,
        setDidTryPurchasing = setDidTryPurchasing,
        getPaymentSessionId = getPaymentSessionId,
        setPaymentSessionId = setPaymentSessionId,
        getEntryContext = getEntryContext,
        setEntryContext = setEntryContext,
        getErrorReason = getErrorReason,
        setErrorReason = setErrorReason,
        getReferrerId = getReferrerId,
        setReferrerId = setReferrerId,
        setOnFlowComplete = function(func1: ((...any) -> (...any))?)
            var22 = func1
        end,
        triggerOnFlowComplete = function(arg1)
            if var22 then
                var22(arg1)
            end
        end,
        getPurchaseUIOptions = getPurchaseUiOptions,
        setPurchaseUIOptions = setPurchaseUiOptions,
        getIsNativePurchase = getIsNativePurchase,
        setIsNativePurchase = setIsNativePurchase,
        getRobloxSubscriptionProductId = getRobloxSubscriptionProductId,
        setOnUnmountUI = function(func1: ((...any) -> (...any))?)
            var23 = func1
        end,
        triggerUnmountUI = function()
            if var23 then
                var23()
                var23 = nil
            end
        end,
        setOnBackButtonActivated = function(func1: ((...any) -> (...any))?)
            var24 = func1
        end,
        triggerOnBackButtonActivated = function()
            if var24 then
                var24()
            end
        end,
        setOnCtaOverride = function(arg1)
            getOnCtaOverride = arg1
        end,
        getOnCtaOverride = function()
            return getOnCtaOverride
        end,
        setMembershipConfigSnapshot = function(arg1)
            getMembershipConfigSnapshot = arg1
        end,
        getMembershipConfigSnapshot = function()
            return getMembershipConfigSnapshot
        end
    }
end
local module = {}

function module.get()
    if var1 == nil then
        var1 = Signals.createComputed(func1)(false)
    end
    return var1
end

function module.cleanup()
    var1 = nil
end

return module
