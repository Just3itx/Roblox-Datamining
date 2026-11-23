-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CancelSubscriptionAppParent = script:FindFirstAncestor("CancelSubscriptionApp").Parent
return require(CancelSubscriptionAppParent.Rodux).makeActionCreator("CancelSubscriptionRequested", function(subscriptionId: string)
    return { subscriptionId = subscriptionId }
end)
