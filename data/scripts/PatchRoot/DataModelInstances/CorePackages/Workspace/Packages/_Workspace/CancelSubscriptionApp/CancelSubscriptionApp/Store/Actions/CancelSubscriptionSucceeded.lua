-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CancelSubscriptionAppParent = script:FindFirstAncestor("CancelSubscriptionApp").Parent
return require(CancelSubscriptionAppParent.Rodux).makeActionCreator("CancelSubscriptionSucceeded", function(subscriptionId: string)
    return { subscriptionId = subscriptionId }
end)
