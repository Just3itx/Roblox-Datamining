-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local React = require(RobloxSubscriptionPurchaseAppParent.React)
local SignalsReact = require(RobloxSubscriptionPurchaseAppParent.SignalsReact)

local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)
local PromptState = require(RobloxSubscriptionPurchaseApp.Enums.PromptState)
local completeRobloxSubscriptionUpsellFlow = require(RobloxSubscriptionPurchaseApp.Actions.completeRobloxSubscriptionUpsellFlow)

local function useHeadlessSubscriptionErrorCompletion()
    local var1 = RobloxSubscriptionStore.get()
    local var2 = SignalsReact.useSignalState(var1.getPromptState)

    React.useEffect(function()
        if var2 == PromptState.Error then
            completeRobloxSubscriptionUpsellFlow()
        end
    end, { var2 })
end

return useHeadlessSubscriptionErrorCompletion
