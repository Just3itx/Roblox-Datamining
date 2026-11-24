-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommerceService = game:GetService("CommerceService")
local CommercePurchaseApp = script:FindFirstAncestor("CommercePurchaseApp")
local CommercePurchaseAppParent = CommercePurchaseApp.Parent
local React = require(CommercePurchaseAppParent.React)
local useDispatch = require(CommercePurchaseAppParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useSelector = require(CommercePurchaseAppParent.RoactUtils).Hooks.RoactRodux.useSelector

local CommercePurchaseEnded = require(CommercePurchaseApp.Store.Actions.CommercePurchaseEnded)
local selectErrorCode = require(CommercePurchaseApp.Store.Selectors.selectErrorCode)
local selectCommerceProductId = require(CommercePurchaseApp.Store.Selectors.selectCommerceProductId)
local _ErrorCodeEnum = require(CommercePurchaseApp.Enums.ErrorCodeEnum)

local _CommercePurchaseError = require(script.Parent.CommercePurchaseError)

local function useCommercePurchaseErrorProps()
    local errorCode = useSelector(selectErrorCode)
    local productId = useSelector(selectCommerceProductId)
    local var2 = useDispatch()

    return {
        onDismiss = React.useCallback(function()
            CommerceService:SignalPromptCommerceProductPurchaseFinished(productId, false)
            var2(CommercePurchaseEnded())
        end, { productId, var2 }),
        errorCode = errorCode
    }
end

return useCommercePurchaseErrorProps
