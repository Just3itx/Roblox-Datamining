-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollections = script:FindFirstAncestor("GameCollections")
local TelemetryService = game:GetService("TelemetryService")
local GameCollectionsParent = GameCollections.Parent

local _DiscoveryTypes = require(GameCollectionsParent.DiscoveryTypes)

local standardizedFields = { "addOSInfo", "addSessionInfo", "addSessionId" }

local config = {
    eventName = "TileSkipped",
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("TileSkippedTelemetryThrottleHundredthsPercent", 0),
    lastUpdated = { 26, 1, 16 },
    description = "This is fired when a tile render gets skipped."
}

local config2 = {
    eventName = "TilePlaced",
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("TilePlacedTelemetryThrottleHundredthsPercent", 0),
    lastUpdated = { 26, 1, 16 },
    description = "This is fired when a tile position has been determined."
}

local module = {}

function module.logTileSkipped(adId: string?, universeId: string?, tileType, pageContext: string, numColumns: number, numRows: number, originalFeedIndex: number, sortIndex: number?, topicId: string?)
    TelemetryService:LogEvent(config, {
        standardizedFields = standardizedFields,
        customFields = {
            adId = adId,
            universeId = universeId,
            tileType = tileType,
            pageContext = pageContext,
            numColumns = numColumns,
            numRows = numRows,
            originalFeedIndex = originalFeedIndex,
            sortIndex = sortIndex,
            topicId = topicId
        }
    })
end

function module.logTilePlaced(adId: string?, universeId: string?, tileType, pageContext: string, numColumns: number, numRows: number, originalFeedIndex: number, finalFeedIndex: number, sortIndex: number?, topicId: string?, totalFilledColumns: number?)
    TelemetryService:LogEvent(config2, {
        standardizedFields = standardizedFields,
        customFields = {
            adId = adId,
            universeId = universeId,
            tileType = tileType,
            pageContext = pageContext,
            numColumns = numColumns,
            numRows = numRows,
            originalFeedIndex = originalFeedIndex,
            finalFeedIndex = finalFeedIndex,
            sortIndex = sortIndex,
            topicId = topicId,
            totalFilledColumns = totalFilledColumns
        }
    })
end
return module
