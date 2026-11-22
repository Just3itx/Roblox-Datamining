-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent
local LoggingProtocol = require(RobloxSubscriptionPurchaseAppParent.LoggingProtocol)
local SurfaceName = require(RobloxSubscriptionPurchaseApp.Enums.SurfaceName)
local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)
local _types = require(RobloxSubscriptionPurchaseApp.types)
local _ErrorReason = require(RobloxSubscriptionPurchaseApp.Enums.ErrorReason)
local FFlagEnablePlusReferralTelemetry = require(RobloxSubscriptionPurchaseApp.Flags.FFlagEnablePlusReferralTelemetry)

local FFlagEnablePlusReferralEntrypointTelemetry = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagEnablePlusReferralEntrypointTelemetry

function logRobloxSubscriptionUpsellCounter(arg1)
    local var1 = RobloxSubscriptionStore.get()
    local entryContext = var1.getEntryContext()
    local errorReason = var1.getErrorReason()
    local surface = if entryContext then entryContext.surfaceName else SurfaceName.Unspecified
    local referrerId = if FFlagEnablePlusReferralTelemetry then var1.getReferrerId() else nil
    local var3 = referrerId and referrerId > 0 and referrerId or nil
    local entrypoint = if FFlagEnablePlusReferralEntrypointTelemetry and entryContext then entryContext.entrypoint else nil
    LoggingProtocol.default:logRobloxTelemetryCounter(arg1, 1, {
        surface = surface,
        errorReason = errorReason and tostring(errorReason) or nil,
        isReferral = if var3 then "true" else nil,
        entrypoint = entrypoint
    })
end

return logRobloxSubscriptionUpsellCounter
