-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent
local LoggingProtocol = require(PurchasePromptParent.LoggingProtocol)

return {
    ProductPurchaseContainerMigrationCounter = {
        eventName = "ProductPurchaseContainerPurchaseFlowUUID",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2025, 1, 21 },
        throttlingPercentage = 100,
        description = "Counter for PurchaseFlowUUID generation in ProductPurchaseContainer init method"
    },
    InitiatePurchaseCounter = {
        eventName = "InitiatePurchasePurchaseFlowUUID",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2025, 1, 21 },
        throttlingPercentage = 100,
        description = "Counter for PurchaseFlowUUID generation in initiatePurchase thunk"
    }
}
