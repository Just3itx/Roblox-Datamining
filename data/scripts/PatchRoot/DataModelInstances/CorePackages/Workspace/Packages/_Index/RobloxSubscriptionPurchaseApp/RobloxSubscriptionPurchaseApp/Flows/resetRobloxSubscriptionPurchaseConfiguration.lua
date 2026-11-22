-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:50:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")

local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)

local function resetRobloxSubscriptionPurchaseConfiguration()
    local var1 = RobloxSubscriptionStore.get()
    var1.setPurchaseUIOptions({})
    var1.setPurchaseFlowOptions({})
    var1.setOnFlowComplete(nil)
    var1.setOnBackButtonActivated(nil)
    var1.setOnCtaOverride(nil)
end

return resetRobloxSubscriptionPurchaseConfiguration
