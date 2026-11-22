-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")

local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)

local function resetPerFlowState()
    RobloxSubscriptionStore.get().setMembershipConfigSnapshot(nil)
end

return resetPerFlowState
