-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")

local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent
local Promise = require(RobloxSubscriptionPurchaseAppParent.Promise)
local Url = require(RobloxSubscriptionPurchaseAppParent.Http).Url

local SurfaceContext = require(RobloxSubscriptionPurchaseApp.Enums.SurfaceContext)
local SurfaceName = require(RobloxSubscriptionPurchaseApp.Enums.SurfaceName)
local _types = require(RobloxSubscriptionPurchaseApp.types)
local _CreatePaymentSessionTypes = require(script.Parent.CreatePaymentSessionTypes)
local HttpRequest = require(script.Parent.HttpRequest)
local logRobloxSubscriptionUpsellCounter = require(RobloxSubscriptionPurchaseApp.Utils.logRobloxSubscriptionUpsellCounter)
local logRobloxSubscriptionUpsellTelemetryEvent = require(RobloxSubscriptionPurchaseApp.Utils.logRobloxSubscriptionUpsellTelemetryEvent)
local RobloxSubscriptionUpsellTelemetry = require(RobloxSubscriptionPurchaseApp.Events.RobloxSubscriptionUpsellTelemetry)
local FFlagSubscriptionUpsellCounterWithErrorReason = require(RobloxSubscriptionPurchaseApp.Flags.FFlagSubscriptionUpsellCounterWithErrorReason)

local HttpService = game:GetService("HttpService")

local var1 = Url.APIS_URL .. "payments-gateway/v1/payment-sessions"

return function(arg1)
    local var2 = arg1 or {
        context = SurfaceContext.Unspecified,
        surfaceName = SurfaceName.Unspecified,
        metadata = {}
    }

    local tbl1 = {
        entryPoint = var2.surfaceName
    }
    local universeId = var2.metadata.universeId
    if universeId ~= nil then
        tbl1.universeId = universeId
    end

    return HttpRequest.new():post(var1, tbl1):andThen(function(arg2): string
        local paymentSession = arg2.paymentSession
        local id = paymentSession and paymentSession.id
        return if type(id) == "string" then id else ""
    end):catch(function(arg2)
        logRobloxSubscriptionUpsellCounter(
            RobloxSubscriptionUpsellTelemetry.RobloxSubscriptionCreatePaymentSessionFailedCounter
        )
        if FFlagSubscriptionUpsellCounterWithErrorReason then
            logRobloxSubscriptionUpsellTelemetryEvent(
                RobloxSubscriptionUpsellTelemetry.RobloxSubscriptionCreatePaymentSessionFailedEvent,
                {
                    errorReason = if type(arg2) == "table" then HttpService:JSONEncode(arg2) else tostring(arg2)
                }
            )
        end

        return Promise.resolve("")
    end)
end
