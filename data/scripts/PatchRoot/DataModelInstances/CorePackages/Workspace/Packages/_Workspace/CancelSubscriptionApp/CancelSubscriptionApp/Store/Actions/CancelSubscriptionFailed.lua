-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CancelSubscriptionApp = script:FindFirstAncestor("CancelSubscriptionApp")
local CancelSubscriptionAppParent = CancelSubscriptionApp.Parent
local Rodux = require(CancelSubscriptionAppParent.Rodux)

local _ErrorStateEnum = require(CancelSubscriptionApp.Enums.ErrorStateEnum)

return Rodux.makeActionCreator("CancelSubscriptionFailed", function(errorState, subscriptionId: string)
    return { errorState = errorState, subscriptionId = subscriptionId }
end)
