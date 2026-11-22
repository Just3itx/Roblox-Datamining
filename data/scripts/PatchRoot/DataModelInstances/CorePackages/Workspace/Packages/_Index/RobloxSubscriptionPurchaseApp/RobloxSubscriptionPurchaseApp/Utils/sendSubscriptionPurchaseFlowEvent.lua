-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent
local default = require(RobloxSubscriptionPurchaseAppParent.LoggingProtocol).default

local SubscriptionPurchaseFlowTelemetry = require(RobloxSubscriptionPurchaseApp.Events.SubscriptionPurchaseFlowTelemetry)

function sendSubscriptionPurchaseFlowEvent(tbl1)
    default:logRobloxTelemetryEvent(
        SubscriptionPurchaseFlowTelemetry.SubscriptionPurchaseFlowEvent,
        { default.StandardizedFields.addOsInfo, default.StandardizedFields.addSessionId, "addSessionInfo" },
        tbl1
    )
end

return sendSubscriptionPurchaseFlowEvent
