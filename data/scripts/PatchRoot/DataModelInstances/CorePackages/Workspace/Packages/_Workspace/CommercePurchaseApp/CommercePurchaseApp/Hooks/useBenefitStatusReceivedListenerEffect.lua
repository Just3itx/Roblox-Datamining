-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommerceService = game:GetService("CommerceService")

local CommercePurchaseAppParent = script:FindFirstAncestor("CommercePurchaseApp").Parent
local React = require(CommercePurchaseAppParent.React)
local useDispatch = require(CommercePurchaseAppParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useLocalization = require(CommercePurchaseAppParent.Localization).Hooks.useLocalization

local ToastRodux = require(CommercePurchaseAppParent.ToastRodux)
local ToastType = ToastRodux.Enums.ToastType
local SetCurrentToastMessage = ToastRodux.Actions.SetCurrentToastMessage

local function useBenefitStatusReceivedListenerEffect()
    local var1 = useDispatch()
    local var2 = useLocalization({
        granted = "CoreScripts.CommercePurchasePrompt.SuccessToast.Granted",
        pending = "CoreScripts.CommercePurchasePrompt.SuccessToast.GrantPending"
    })

    React.useEffect(function()
        local connection = if var1 then CommerceService.BenefitStatusReceived:Connect(function(isGranted: boolean)
            local tbl1 = isGranted and {
                toastType = ToastType.SuccessConfirmation,
                toastTitle = var2.granted
            }
                or {
                    toastType = ToastType.NetworkingError,
                    toastTitle = var2.pending
                }
            var1(SetCurrentToastMessage(tbl1))
        end) else nil

        return function()
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end, { var1, var2 })
end
return useBenefitStatusReceivedListenerEffect
