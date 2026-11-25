-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent
local LoggingProtocol = require(PurchasePromptParent.LoggingProtocol)

local tbl1 = {
    eventName = "PurchasePromptNonCollectiblePurchase",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    lastUpdated = { 2026, 10, 1 },
    description = "Counts confirmed asset and bundle purchases sent to MarketplaceService:PerformPurchase without a collectible item id, so the engine buys them through the legacy economy endpoint.",
    links = "https://roblox.atlassian.net/browse/CLI-220689"
}

local tbl2 = {}
for _, enumItem in Enum.AvatarAssetType:GetEnumItems() do
    tbl2[enumItem.Value] = true
end

local function reportPurchasePromptNonCollectiblePurchase(infoType, tbl3)
    if infoType ~= Enum.InfoType.Asset then
        if infoType == Enum.InfoType.Bundle then
            LoggingProtocol.default:logRobloxTelemetryCounter(tbl1, 1, { infoType = "Bundle" })
        end

        return
    end

    if not tbl2[tbl3.assetTypeId] then
        return
    end
    LoggingProtocol.default:logRobloxTelemetryCounter(
        tbl1,
        1,
        {
            infoType = "Asset",
            assetTypeId = tostring(tbl3.assetTypeId),
            productType = tbl3.productType or ""
        }
    )
end

return reportPurchasePromptNonCollectiblePurchase
