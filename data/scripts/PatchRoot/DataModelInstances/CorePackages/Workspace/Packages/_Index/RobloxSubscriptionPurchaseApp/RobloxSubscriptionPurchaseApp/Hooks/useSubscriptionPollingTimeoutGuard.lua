-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent
local React = require(RobloxSubscriptionPurchaseAppParent.React)
local SignalsReact = require(RobloxSubscriptionPurchaseAppParent.SignalsReact)
local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)
local PromptState = require(RobloxSubscriptionPurchaseApp.Enums.PromptState)
local finalizeRobloxSubscriptionUpsellFlow = require(RobloxSubscriptionPurchaseApp.Actions.finalizeRobloxSubscriptionUpsellFlow)
local transitionToError = require(RobloxSubscriptionPurchaseApp.Actions.transitionToError)
local ErrorReason = require(RobloxSubscriptionPurchaseApp.Enums.ErrorReason)
local FFlagPlusMembershipConfigChangeCheck = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagPlusMembershipConfigChangeCheck
local FIntPlusUpgradePollingTimeoutSeconds = require(RobloxSubscriptionPurchaseApp.Flags.FIntPlusUpgradePollingTimeoutSeconds)

local num1 = game:DefineFastInt("RobloxSubscriptionPurchasePollingTimeoutSeconds", 4)

local function useSubscriptionPollingTimeoutGuard()
    local var1 = RobloxSubscriptionStore.get()
    local var2 = React.useRef(var1)

    local var3 = SignalsReact.useSignalState(var1.getPromptState)
    local var4 = SignalsReact.useSignalState(var1.getIsNativePurchase)

    React.useEffect(function()
        if var3 ~= PromptState.SubscriptionStatusPolling then
            return
        end

        local bool1 = false
        local var5 = if FFlagPlusMembershipConfigChangeCheck and var2.current.getMembershipConfigSnapshot() ~= nil then FIntPlusUpgradePollingTimeoutSeconds else num1

        task.delay(var5, function()
            if bool1 then
                return
            end

            local current = var2.current

            if current.getPromptState() ~= PromptState.SubscriptionStatusPolling then
                return
            end

            if current.getIsNativePurchase() then
                transitionToError(ErrorReason.GenericError, "useSubscriptionPollingTimeoutGuard")
                return
            end

            finalizeRobloxSubscriptionUpsellFlow(false)
        end)

        return function()
            bool1 = true
        end
    end, { var3, var4 })
end

return useSubscriptionPollingTimeoutGuard
