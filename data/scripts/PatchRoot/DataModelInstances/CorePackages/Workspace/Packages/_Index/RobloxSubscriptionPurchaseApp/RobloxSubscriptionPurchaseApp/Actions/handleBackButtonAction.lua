-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")

local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)
local cleanupSubscriptionFlow = require(RobloxSubscriptionPurchaseApp.Actions.cleanupSubscriptionFlow)

local function handleBackButtonAction()
    RobloxSubscriptionStore.get().triggerOnBackButtonActivated()
    cleanupSubscriptionFlow()
end

return handleBackButtonAction
