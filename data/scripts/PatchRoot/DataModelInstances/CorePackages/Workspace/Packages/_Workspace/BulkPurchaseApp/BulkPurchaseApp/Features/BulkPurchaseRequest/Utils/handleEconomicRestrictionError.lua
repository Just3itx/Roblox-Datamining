-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent

local IAPExperience = require(BulkPurchaseAppParent.IAPExperience)
local parseErrorReasonToEconomicRestriction = IAPExperience.Utility.parseErrorReasonToEconomicRestriction
local EconomicRestrictionsCounter = IAPExperience.Counters.EconomicRestrictionsCounter
local UniversalEconomicRestrictionsCounter = EconomicRestrictionsCounter.UniversalEconomicRestrictionsCounter
local EconomicRestrictionsSurface = EconomicRestrictionsCounter.EconomicRestrictionsSurface
local default = require(BulkPurchaseAppParent.LoggingProtocol).default

local BulkPurchaseFailed = require(BulkPurchaseApp.Store.Actions.BulkPurchaseFailed)
local ErrorCodeEnum = require(BulkPurchaseApp.Enums.ErrorCodeEnum)

local function handleEconomicRestrictionError(arg1, callback: (...any) -> (...any))
    local var1 = parseErrorReasonToEconomicRestriction(arg1)
    local var2 = default
    local var3 = UniversalEconomicRestrictionsCounter
    local num1 = 1
    local tbl1 = {
        surface = EconomicRestrictionsSurface.BulkPurchase,
        failureReason = if var1.violationType then tostring(var1.violationType) else "null"
    }
    var2:logRobloxTelemetryCounter(var3, num1, tbl1)

    callback(
        BulkPurchaseFailed(
            ErrorCodeEnum.EconomicRestriction,
            {
                failureReason = var1.violationType,
                expirationTimeInMinutes = var1.timeoutMinutes
            }
        )
    )
end

return handleEconomicRestrictionError
