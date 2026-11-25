-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiImpressionEventType = SduiCoreSystem.SduiImpressionEventType
local getSduiImpressionHandlerRegistry = SduiCoreSystem.getSduiImpressionHandlerRegistry

local FFlagSduiDevStoreSeeAllImpressionsLogging = require(ServerDrivenUiParent.SharedFlags).FFlagSduiDevStoreSeeAllImpressionsLogging
local FFlagSduiQueryImpressionsLogging = require(ServerDrivenUiParent.SharedFlags).FFlagSduiQueryImpressionsLogging
local FFlagSafetyResourceBannerTelemetry = require(ServerDrivenUiParent.SharedFlags).FFlagSafetyResourceBannerTelemetry

local function registerDiscoveryImpressions()
    local tbl1 = {
        [SduiImpressionEventType.filterImpressions] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Impressions.SduiFilterImpressionsHandler)
            end,
            skipItemImpressionsLog = true
        },
        [SduiImpressionEventType.gameImpressions] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Impressions.SduiGameImpressionsHandler)
            end,
            skipItemImpressionsLog = false
        },
        [SduiImpressionEventType.socialLinksImpressions] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Impressions.SduiSocialLinksImpressionsHandler)
            end,
            skipItemImpressionsLog = false
        },
        [SduiImpressionEventType.virtualEventImpressions] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Impressions.SduiVirtualEventImpressionsHandler)
            end,
            skipItemImpressionsLog = false
        },
        [SduiImpressionEventType.experienceStoreImpressions] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Impressions.SduiEdpStoreImpressionsHandler)
            end,
            skipItemImpressionsLog = false
        },
        [SduiImpressionEventType.marketplaceItemImpressions] = {
            lazyHandler = function()
                return require(ServerDrivenUi.Impressions.SduiMarketplaceItemImpressionsHandler)
            end,
            skipItemImpressionsLog = false
        },
        [SduiImpressionEventType.devStoreSeeAllImpressions] = FFlagSduiDevStoreSeeAllImpressionsLogging and {
            lazyHandler = function()
                return require(ServerDrivenUi.Impressions.SduiDevStoreSeeAllImpressionsHandler)
            end,
            skipItemImpressionsLog = false
        } or nil,
        [SduiImpressionEventType.queryImpressions] = FFlagSduiQueryImpressionsLogging and {
            lazyHandler = function()
                return require(ServerDrivenUi.Impressions.SduiQueryImpressionsHandler)
            end,
            skipItemImpressionsLog = true
        } or nil,
        [SduiImpressionEventType.safetyResourceBannerImpressions] = FFlagSafetyResourceBannerTelemetry and {
            lazyHandler = function()
                return require(ServerDrivenUi.Impressions.SduiSafetyResourceBannerImpressionsHandler)
            end,
            skipItemImpressionsLog = true
        } or nil
    }

    getSduiImpressionHandlerRegistry().registerImpressionHandlerConfigs(tbl1)
end

return registerDiscoveryImpressions
