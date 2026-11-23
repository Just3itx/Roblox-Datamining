-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local LoggingProtocol = require(BulkPurchaseAppParent.LoggingProtocol)
local BulkPurchaseCountersEnum = require(BulkPurchaseApp.Enums.BulkPurchaseCountersEnum)

local FFlagAXAddPlusUpsellToBulkPurchase = require(BulkPurchaseApp.Flags.FFlagAXAddPlusUpsellToBulkPurchase)
local FFlagAXMoreBulkPurchaseCounters = require(BulkPurchaseApp.Flags.FFlagAXMoreBulkPurchaseCounters)

local tbl1 = {
    [BulkPurchaseCountersEnum.BulkPurchaseRequestedCounter] = {
        eventName = BulkPurchaseCountersEnum.BulkPurchaseRequestedCounter,
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2026, 9, 23 },
        throttlingPercentage = 100,
        description = "Counter fired when bulk purchase is requested",
        links = ""
    },
    [BulkPurchaseCountersEnum.BulkPurchaseSucceededCounter] = {
        eventName = BulkPurchaseCountersEnum.BulkPurchaseSucceededCounter,
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2026, 9, 23 },
        throttlingPercentage = 100,
        description = "Counter fired when bulk purchase has succeeded",
        links = ""
    },
    [BulkPurchaseCountersEnum.BulkPurchaseFailedCounter] = {
        eventName = BulkPurchaseCountersEnum.BulkPurchaseFailedCounter,
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2026, 9, 23 },
        throttlingPercentage = 100,
        description = "Counter fired when bulk purchase has failed",
        links = ""
    },
    [BulkPurchaseCountersEnum.BulkPurchaseRefreshFailedCounter] = {
        eventName = BulkPurchaseCountersEnum.BulkPurchaseRefreshFailedCounter,
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2026, 9, 23 },
        throttlingPercentage = 100,
        description = "Counter fired when bulk purchase refresh has failed",
        links = ""
    },
    [BulkPurchaseCountersEnum.BulkPurchasePlusUpsellInitatedCounter] = {
        eventName = BulkPurchaseCountersEnum.BulkPurchasePlusUpsellInitatedCounter,
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2026, 9, 23 },
        throttlingPercentage = 100,
        description = "Counter fired when bulk purchase server plus upsell is initiated",
        links = ""
    },
    [BulkPurchaseCountersEnum.BulkPurchasePlusUpsellSucceededCounter] = {
        eventName = BulkPurchaseCountersEnum.BulkPurchasePlusUpsellSucceededCounter,
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2026, 9, 23 },
        throttlingPercentage = 100,
        description = "Counter fired when bulk purchase server plus upsell is successful",
        links = ""
    },
    [BulkPurchaseCountersEnum.BulkPurchasePlusUpsellFailedCounter] = {
        eventName = BulkPurchaseCountersEnum.BulkPurchasePlusUpsellFailedCounter,
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2026, 9, 23 },
        throttlingPercentage = 100,
        description = "Counter fired when bulk purchase server plus upsell has failed",
        links = ""
    },
    [BulkPurchaseCountersEnum.BulkPurchasePartialSuccessCounter] = {
        eventName = BulkPurchaseCountersEnum.BulkPurchasePartialSuccessCounter,
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2026, 10, 26 },
        throttlingPercentage = 100,
        description = "Counter fired when bulk purchase has partially succeeded",
        links = ""
    }
}

local function reportBulkPurchaseRequestCounters(arg1, tbl2)
    local tbl3 = {
        FFlagAXAddPlusUpsellToBulkPurchase = tostring(FFlagAXAddPlusUpsellToBulkPurchase)
    }
    if FFlagAXMoreBulkPurchaseCounters and tbl2 then
        for value, value2 in tbl2 do
            tbl3[value] = value2
        end
    end
    LoggingProtocol.default:logRobloxTelemetryCounter(tbl1[arg1], 1, tbl3)
end

return reportBulkPurchaseRequestCounters
