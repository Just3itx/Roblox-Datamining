-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")

local _getRobloxSubscriptionProducts = require(RobloxSubscriptionPurchaseApp.Network.getRobloxSubscriptionProducts)
local isRobloxSubscriptionProductFreeTrial = require(RobloxSubscriptionPurchaseApp.Utils.isRobloxSubscriptionProductFreeTrial)

local function isRobloxPlusFreeTrialEligible(arg1)
    if type(arg1) ~= "table" or arg1[1] == nil then
        return false
    end

    return isRobloxSubscriptionProductFreeTrial(arg1[1])
end

return isRobloxPlusFreeTrialEligible
