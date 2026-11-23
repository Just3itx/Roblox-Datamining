-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseAppParent = script:FindFirstAncestor("BulkPurchaseApp").Parent
local default = require(BulkPurchaseAppParent.LoggingProtocol).default
local BulkPurchaseMissingPurchaseOptionsCounter = require(BulkPurchaseAppParent.AvatarExperienceAnalytics).Events.BulkPurchaseMissingPurchaseOptionsCounter

local function reportMissingPurchaseOptions(tbl1)
    for _, value in tbl1 do
        local purchaseOptions = value.purchaseOptions
        if purchaseOptions == nil or #purchaseOptions == 0 then
            default:logRobloxTelemetryCounter(BulkPurchaseMissingPurchaseOptionsCounter, 1, {})
            return
        end
    end
end

local function reportBulkPurchaseRequestIssues(tbl1)
    if tbl1 == nil then
        return
    end
    reportMissingPurchaseOptions(tbl1)
end

return reportBulkPurchaseRequestIssues
