-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent
local _LoggingProtocol = require(PurchasePromptParent.LoggingProtocol)

return {
    RerenderTimingStat = {
        eventName = "PurchasePromptAppRerenderTiming",
        backends = { "RobloxTelemetryStat" },
        lastUpdated = { 2025, 8, 4 },
        throttlingPercentage = 1000,
        description = "Stat for tracking re-render timing in PurchasePromptApp to detect performance issues",
        links = "https://roblox.atlassian.net/browse/APPEXP-2951"
    }
}
