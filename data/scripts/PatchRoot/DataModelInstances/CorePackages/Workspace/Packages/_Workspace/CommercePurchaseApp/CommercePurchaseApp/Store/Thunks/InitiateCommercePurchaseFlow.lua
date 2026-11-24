-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommercePurchaseApp = script:FindFirstAncestor("CommercePurchaseApp")

local CommerceService = game:GetService("CommerceService")
local CommercePurchaseFailed = require(CommercePurchaseApp.Store.Actions.CommercePurchaseFailed)
local CommercePurchaseStarted = require(CommercePurchaseApp.Store.Actions.CommercePurchaseStarted)
local CommercePurchaseCheckout = require(CommercePurchaseApp.Store.Actions.CommercePurchaseCheckout)
local CommercePurchaseEnded = require(CommercePurchaseApp.Store.Actions.CommercePurchaseEnded)
local ErrorCodeEnum = require(CommercePurchaseApp.Enums.ErrorCodeEnum)
local FFlagAddCommerceErrors = require(CommercePurchaseApp.Flags.FFlagAddCommerceErrors)

local CommercePurchaseAppParent = CommercePurchaseApp.Parent
local ToastRodux = require(CommercePurchaseAppParent.ToastRodux)
local ToastType = ToastRodux.Enums.ToastType
local SetCurrentToastMessage = ToastRodux.Actions.SetCurrentToastMessage

local function convertErrorMessageToErrorCode(str1: string)
    if not FFlagAddCommerceErrors then
        if str1 == "NotPurchasable" then
            return ErrorCodeEnum.NotPurchasable
        end

        return ErrorCodeEnum.Generic
    end

    if str1 == "DeviceTypeNotAllowed" or str1 == "PurchasePlatformNotSupported" then
        return ErrorCodeEnum.DeviceNotSupported
    end

    if str1 == "UniverseNotAllowed" or str1 == "ProductContentModerated" or str1 == "ProductNotFound" then
        return ErrorCodeEnum.NotPurchasable
    end

    if str1 == "UserNotAllowed" or str1 == "AccountCountryNotSupported" or str1 == "UserAgeNotAllowed" then
        return ErrorCodeEnum.AccountNotSupported
    end

    return ErrorCodeEnum.Generic
end

local function handleError(arg1, arg2, toastTitle: string)
    local var1 = convertErrorMessageToErrorCode(arg1)
    if var1 ~= ErrorCodeEnum.Generic then
        arg2:dispatch(CommercePurchaseFailed(var1))
        return
    end

    arg2:dispatch(SetCurrentToastMessage({ toastType = ToastType.NetworkingError, toastTitle = toastTitle }))

    arg2:dispatch(CommercePurchaseEnded())
end

local function InitiateCommercePurchaseFlow(commerceProductId: string, toastTitle: string)
    return function(arg1)
        arg1:dispatch(CommercePurchaseStarted(commerceProductId))
        local success, result = pcall(function()
            return CommerceService:PrepareCommerceProductPurchase(commerceProductId)
        end)
        if success then
            arg1:dispatch(CommercePurchaseCheckout(result.CheckoutSessionId))
            return
        end
        handleError(result, arg1, toastTitle)
    end
end

return InitiateCommercePurchaseFlow
