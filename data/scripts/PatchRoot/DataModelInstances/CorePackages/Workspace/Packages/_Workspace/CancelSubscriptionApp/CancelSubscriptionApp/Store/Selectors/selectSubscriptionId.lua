-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CancelSubscriptionApp = script:FindFirstAncestor("CancelSubscriptionApp")

local _Types = require(CancelSubscriptionApp.Store.Types)

local function selectSubscriptionId(arg1)
    return arg1.subscriptionId
end

return selectSubscriptionId
