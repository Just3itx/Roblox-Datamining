-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local default = require(PurchasePromptParent.LoggingProtocol).default

local VIPServerPostPurchaseTelemetry = require(PurchasePrompt.Events.VIPServerPostPurchaseTelemetry)
local _types = require(PurchasePrompt.types)

local function sendPrivateServerConfigEvent(arg1)
    default:logRobloxTelemetryEvent(
        VIPServerPostPurchaseTelemetry.PrivateServerConfigEvent,
        { default.StandardizedFields.addOsInfo, default.StandardizedFields.addSessionId, "addSessionInfo" },
        arg1
    )
end

return sendPrivateServerConfigEvent
