-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent
local LoggingProtocol = require(RobloxSubscriptionPurchaseAppParent.LoggingProtocol)
local SurfaceName = require(RobloxSubscriptionPurchaseApp.Enums.SurfaceName)
local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)
local _types = require(RobloxSubscriptionPurchaseApp.types)

function logRobloxSubscriptionUpsellTelemetryEvent(arg1, tbl1)
    local var1 = RobloxSubscriptionStore.get().getEntryContext()

    local tbl2 = {
        surface = if var1 then var1.surfaceName else SurfaceName.Unspecified
    }

    if tbl1 then
        for value, value2 in tbl1 do
            tbl2[value] = value2
        end
    end

    LoggingProtocol.default:logRobloxTelemetryEvent(arg1, {}, tbl2)
end

return logRobloxSubscriptionUpsellTelemetryEvent
