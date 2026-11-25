-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local LoggingProtocol = require(PurchasePromptParent.LoggingProtocol)

local ProductPurchaseSurface = require(PurchasePromptParent.PurchasePromptLite).Enums.ProductPurchaseSurface
local AppContext = require(PurchasePrompt.Utils.AppContext)
local types = require(PurchasePrompt.types)

local function logUnifiedPurchaseTelemetryCounter(arg1, surface, productType)
    LoggingProtocol.default:logRobloxTelemetryCounter(arg1, 1, {
        appContext = AppContext.get(),
        surface = surface or ProductPurchaseSurface.Unknown,
        productType = productType or types.ProductTypeEnum.Unknown
    })
end

return logUnifiedPurchaseTelemetryCounter
