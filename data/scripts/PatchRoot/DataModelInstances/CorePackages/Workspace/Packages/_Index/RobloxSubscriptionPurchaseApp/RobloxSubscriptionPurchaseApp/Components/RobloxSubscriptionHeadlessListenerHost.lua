-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local completeRobloxSubscriptionUpsellFlow = require(RobloxSubscriptionPurchaseApp.Actions.completeRobloxSubscriptionUpsellFlow)
local useNativePurchaseFinishedListener = require(RobloxSubscriptionPurchaseApp.Hooks.useNativePurchaseFinishedListener)

local FFlagEnableHeadlessSubscriptionNativePurchaseCancelCallback = require(RobloxSubscriptionPurchaseApp.Flags.FFlagEnableHeadlessSubscriptionNativePurchaseCancelCallback)
local useRobloxSubscriptionChangedListener = require(RobloxSubscriptionPurchaseApp.Hooks.useRobloxSubscriptionChangedListener)
local useSubscriptionPollingTimeoutGuard = require(RobloxSubscriptionPurchaseApp.Hooks.useSubscriptionPollingTimeoutGuard)
local useMembershipConfigChangePoller = require(RobloxSubscriptionPurchaseApp.Hooks.useMembershipConfigChangePoller)
local FFlagPlusMembershipConfigChangeCheck = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagPlusMembershipConfigChangeCheck
local useHeadlessSubscriptionErrorCompletion = require(RobloxSubscriptionPurchaseApp.Hooks.useHeadlessSubscriptionErrorCompletion)

local function RobloxSubscriptionHeadlessListenerHost()
    if FFlagEnableHeadlessSubscriptionNativePurchaseCancelCallback then
        useNativePurchaseFinishedListener(nil, nil, function()
            completeRobloxSubscriptionUpsellFlow()
        end)
    else
        useNativePurchaseFinishedListener()
    end
    useRobloxSubscriptionChangedListener()
    useSubscriptionPollingTimeoutGuard()
    if FFlagPlusMembershipConfigChangeCheck then
        useMembershipConfigChangePoller()
    end
    useHeadlessSubscriptionErrorCompletion()
    return nil
end

return RobloxSubscriptionHeadlessListenerHost
