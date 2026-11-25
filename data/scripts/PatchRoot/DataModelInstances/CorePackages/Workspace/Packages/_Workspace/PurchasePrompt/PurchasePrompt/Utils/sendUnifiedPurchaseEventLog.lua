-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local default = require(PurchasePromptParent.LoggingProtocol).default

local UnifiedPurchaseTelemetry = require(PurchasePrompt.Events.UnifiedPurchaseTelemetry)

function sendUnifiedPurchaseEventLog(arg1)
    default:logRobloxTelemetryEvent(
        UnifiedPurchaseTelemetry.UnifiedProductPurchaseFlowEvent,
        { default.StandardizedFields.addOsInfo, default.StandardizedFields.addSessionId, "addSessionInfo" },
        arg1
    )
end

return sendUnifiedPurchaseEventLog
