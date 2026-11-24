-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommerceService = game:GetService("CommerceService")

local CommercePurchaseApp = script:FindFirstAncestor("CommercePurchaseApp")
local CommercePurchaseAppParent = CommercePurchaseApp.Parent
local React = require(CommercePurchaseAppParent.React)
local useDispatch = require(CommercePurchaseAppParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useLocalization = require(CommercePurchaseAppParent.Localization).Hooks.useLocalization
local useSelector = require(CommercePurchaseAppParent.RoactUtils).Hooks.RoactRodux.useSelector

local CommercePurchasePromptStateEnum = require(CommercePurchaseApp.Enums.CommercePurchasePromptStateEnum)
local selectPromptState = require(CommercePurchaseApp.Store.Selectors.selectPromptState)
local InitiateCommercePurchaseFlow = require(CommercePurchaseApp.Store.Thunks.InitiateCommercePurchaseFlow)
local FFlagAddCommerceErrors = require(CommercePurchaseApp.Flags.FFlagAddCommerceErrors)

local function useCommercePurchaseRequestListenerEffect()
    local var1 = useDispatch()
    local var2 = useSelector(selectPromptState)
    local var3 = useLocalization({
        genericError = if FFlagAddCommerceErrors then "CoreScripts.CommercePurchasePrompt.ErrorPrompt.Body.ErrorLoading" else "CoreScripts.CommercePurchasePrompt.ErrorPrompt.GenericError"
    })

    React.useEffect(function()
        local connection = if var1 then CommerceService.PromptCommerceProductPurchaseRequested:Connect(function(commerceProductId: string)
            if var2 == CommercePurchasePromptStateEnum.None then
                var1(InitiateCommercePurchaseFlow(commerceProductId, var3.genericError))
            end
        end) else nil

        return function()
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end, { var1, var3 })
end
return useCommercePurchaseRequestListenerEffect
