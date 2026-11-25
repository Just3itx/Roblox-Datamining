-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local ProductPurchasePromptCounter = require(PurchasePromptParent.IAPExperience).Counters.ProductPurchasePromptCounter.ProductPurchasePromptCounter
local default = require(PurchasePromptParent.LoggingProtocol).default
local PromptState = require(PurchasePrompt.Enums.PromptState)
local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local FFlagFixPurchasingErrorCounter = require(PurchasePrompt.Flags.FFlagFixPurchasingErrorCounter)
local FFlagAddSurfaceAndProductTypeToPromptCounter = require(PurchasePrompt.Flags.FFlagAddSurfaceAndProductTypeToPromptCounter)

local function logProductPurchasePromptCounter(error, arg1, str1: string?, str2: string?)
    if not FFlagFixPurchasingErrorCounter then
        default:logRobloxTelemetryCounter(ProductPurchasePromptCounter, 1, {
            promptState = tostring(error),
            purchaseError = if error ~= PromptState.Error then "" else tostring(arg1),
            surface = FFlagAddSurfaceAndProductTypeToPromptCounter and (str1 or "Unknown") or nil,
            productType = FFlagAddSurfaceAndProductTypeToPromptCounter and (str2 or "Unknown") or nil
        })

        return
    end

    local var1 = default
    local var2 = ProductPurchasePromptCounter
    local num1 = 1
    local tbl1 = {
        promptState = tostring(error),
        purchaseError = if PurchaseError.isMember(arg1) then tostring(arg1) else tostring(PurchaseError.UnknownFailure),
        surface = FFlagAddSurfaceAndProductTypeToPromptCounter and (str1 or "Unknown") or nil,
        productType = FFlagAddSurfaceAndProductTypeToPromptCounter and (str2 or "Unknown") or nil
    }
    var1:logRobloxTelemetryCounter(var2, num1, tbl1)
end
return logProductPurchasePromptCounter
