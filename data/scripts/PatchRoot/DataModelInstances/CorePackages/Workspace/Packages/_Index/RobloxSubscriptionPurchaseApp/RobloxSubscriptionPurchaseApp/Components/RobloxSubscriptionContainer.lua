-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:31:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local React = require(RobloxSubscriptionPurchaseAppParent.React)
local Foundation = require(RobloxSubscriptionPurchaseAppParent.Foundation)

local PromptState = require(RobloxSubscriptionPurchaseApp.Enums.PromptState)
local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)

local completeRobloxSubscriptionUpsellFlow = require(RobloxSubscriptionPurchaseApp.Actions.completeRobloxSubscriptionUpsellFlow)

local SignalsReact = require(RobloxSubscriptionPurchaseAppParent.SignalsReact)

local useNativePurchaseFinishedListener = require(RobloxSubscriptionPurchaseApp.Hooks.useNativePurchaseFinishedListener)
local useRobloxSubscriptionChangedListener = require(RobloxSubscriptionPurchaseApp.Hooks.useRobloxSubscriptionChangedListener)
local useSubscriptionPollingTimeoutGuard = require(RobloxSubscriptionPurchaseApp.Hooks.useSubscriptionPollingTimeoutGuard)
local useMembershipConfigChangePoller = require(RobloxSubscriptionPurchaseApp.Hooks.useMembershipConfigChangePoller)
local FFlagPlusMembershipConfigChangeCheck = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagPlusMembershipConfigChangeCheck

local Sheet = Foundation.Sheet
local DialogSize = Foundation.Enums.DialogSize

local BlackbirdSheetContent = require(script.Parent.BlackbirdSheetContent)
local ErrorSheetContent = require(script.Parent.ErrorSheetContent)

local tbl1 = {
    [PromptState.Error] = true
}

local tbl2 = {
    [PromptState.SubscriptionPurchaseUIReady] = true,
    [PromptState.SubscriptionPurchaseInProgress] = true,
    [PromptState.SubscriptionStatusPolling] = true,
    [PromptState.Error] = true
}

local function RobloxSubscriptionContainer()
    local var1 = RobloxSubscriptionStore.get()
    local var2 = SignalsReact.useSignalState(var1.getPromptState)

    useNativePurchaseFinishedListener()
    useRobloxSubscriptionChangedListener()
    useSubscriptionPollingTimeoutGuard()
    if FFlagPlusMembershipConfigChangeCheck then
        useMembershipConfigChangePoller()
    end

    local var3 = BlackbirdSheetContent()
    local var4 = ErrorSheetContent()

    if tbl1[var2] == true then
        var3 = var4
    end

    return tbl2[var2] == true and React.createElement(Sheet.Root, {
        onClose = function()
            completeRobloxSubscriptionUpsellFlow()
        end,
        preferCenterSheet = true,
        size = DialogSize.Medium
    }, {
        Header = var3.Header,
        Content = var3.Content,
        Actions = var3.Actions
    }) or nil
end

return RobloxSubscriptionContainer
