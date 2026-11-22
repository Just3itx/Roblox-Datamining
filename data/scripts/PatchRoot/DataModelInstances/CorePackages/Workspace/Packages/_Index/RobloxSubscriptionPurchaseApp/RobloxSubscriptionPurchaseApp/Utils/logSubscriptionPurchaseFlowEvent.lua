-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")

local buildSubscriptionPurchaseFlowPayload = require(RobloxSubscriptionPurchaseApp.Utils.buildSubscriptionPurchaseFlowPayload)
local sendSubscriptionPurchaseFlowEvent = require(RobloxSubscriptionPurchaseApp.Utils.sendSubscriptionPurchaseFlowEvent)

local function logSubscriptionPurchaseFlowEvent(str1: string, tbl1)
    local subscriptionPurchaseFlowPayload = buildSubscriptionPurchaseFlowPayload(str1)
    if tbl1 then
        for k, value in pairs(tbl1) do
            subscriptionPurchaseFlowPayload[k] = value
        end
    end

    sendSubscriptionPurchaseFlowEvent(subscriptionPurchaseFlowPayload)
end

return logSubscriptionPurchaseFlowEvent
