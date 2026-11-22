-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent
local React = require(RobloxSubscriptionPurchaseAppParent.React)
local SignalsReact = require(RobloxSubscriptionPurchaseAppParent.SignalsReact)
local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)
local RobloxSubscriptionSignals = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionSignals)
local PromptState = require(RobloxSubscriptionPurchaseApp.Enums.PromptState)
local finalizeRobloxSubscriptionUpsellFlow = require(RobloxSubscriptionPurchaseApp.Actions.finalizeRobloxSubscriptionUpsellFlow)
local getRobloxSubscriptionMembershipConfig = require(RobloxSubscriptionPurchaseApp.Network.getRobloxSubscriptionMembershipConfig)
local MembershipConfigChangeCheck = require(RobloxSubscriptionPurchaseApp.Utils.MembershipConfigChangeCheck)
local FIntPlusUpgradePollingIntervalMs = require(RobloxSubscriptionPurchaseApp.Flags.FIntPlusUpgradePollingIntervalMs)

local function useMembershipConfigChangePoller()
    local var1 = RobloxSubscriptionStore.get()
    local var2 = React.useRef(var1)

    local var3 = SignalsReact.useSignalState(var1.getPromptState)

    React.useEffect(function()
        if var3 ~= PromptState.SubscriptionStatusPolling then
            return nil
        end

        local current = var2.current
        local membershipConfigSnapshot = current.getMembershipConfigSnapshot()
        if membershipConfigSnapshot == nil then
            return nil
        end

        local bool1 = false
        local function isStillPolling(): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
            return not bool1 and current.getPromptState() == PromptState.SubscriptionStatusPolling
        end

        local function scheduleCheck() -- Luacid: Inlined by compiler; 1 call site recovered
            task.delay(FIntPlusUpgradePollingIntervalMs / 1000, function()
                if not isStillPolling() then
                    return
                end
                getRobloxSubscriptionMembershipConfig():andThen(function(arg1)
                    if not isStillPolling() then
                        return
                    end

                    if arg1 == nil or not MembershipConfigChangeCheck.isChanged(membershipConfigSnapshot, arg1) then
                        scheduleCheck()
                        return
                    end

                    local var4 = RobloxSubscriptionSignals.get()
                    var4.setHasRobloxSubscriptionUpgradedThisSession(true)

                    if next(membershipConfigSnapshot) ~= nil and var4.getHasRobloxSubscription() then
                        var4.setExistingSubscriptionUpgradedThisSession(true)
                    end
                    finalizeRobloxSubscriptionUpsellFlow(true)
                end)
            end)
        end

        scheduleCheck()

        return function()
            bool1 = true
        end
    end, { var3 })
end

return useMembershipConfigChangePoller
