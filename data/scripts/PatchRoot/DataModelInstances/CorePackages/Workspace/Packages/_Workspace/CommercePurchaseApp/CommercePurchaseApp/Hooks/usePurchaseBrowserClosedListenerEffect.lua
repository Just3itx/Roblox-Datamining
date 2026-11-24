-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:41:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommerceService = game:GetService("CommerceService")

local CommercePurchaseApp = script:FindFirstAncestor("CommercePurchaseApp")
local CommercePurchaseAppParent = CommercePurchaseApp.Parent
local React = require(CommercePurchaseAppParent.React)
local useDispatch = require(CommercePurchaseAppParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useSelector = require(CommercePurchaseAppParent.RoactUtils).Hooks.RoactRodux.useSelector

local CommercePurchasePromptStateEnum = require(CommercePurchaseApp.Enums.CommercePurchasePromptStateEnum)
local selectPromptState = require(CommercePurchaseApp.Store.Selectors.selectPromptState)
local selectCommerceProductId = require(CommercePurchaseApp.Store.Selectors.selectCommerceProductId)
local selectCheckoutSessionId = require(CommercePurchaseApp.Store.Selectors.selectCheckoutSessionId)

local CommercePurchaseEnded = require(CommercePurchaseApp.Store.Actions.CommercePurchaseEnded)

local function usePurchaseBrowserClosedListenerEffect()
    local var1 = useDispatch()
    local var2 = useSelector(selectPromptState)
    local productId = useSelector(selectCommerceProductId)
    local checkoutSessionId = useSelector(selectCheckoutSessionId)
    React.useEffect(function()
        local connection = if var1 then CommerceService.PurchaseBrowserClosed:Connect(function()
            if var2 == CommercePurchasePromptStateEnum.Checkout then
                CommerceService:SignalPromptCommerceProductPurchaseFinished(productId, true, checkoutSessionId)

                var1(CommercePurchaseEnded())
            end
        end) else nil

        return function()
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end, {
        var1,
        var2,
        productId,
        checkoutSessionId
    })
end

return usePurchaseBrowserClosedListenerEffect
