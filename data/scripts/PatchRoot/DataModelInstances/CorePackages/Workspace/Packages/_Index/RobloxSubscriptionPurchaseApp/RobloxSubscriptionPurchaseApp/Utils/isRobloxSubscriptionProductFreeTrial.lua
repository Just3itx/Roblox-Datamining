-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local getFreeTrialOffer = require(RobloxSubscriptionPurchaseApp.Utils.getFreeTrialOffer)

local function isRobloxSubscriptionProductFreeTrial(arg1): boolean
    return getFreeTrialOffer(arg1) ~= nil
end

return isRobloxSubscriptionProductFreeTrial
