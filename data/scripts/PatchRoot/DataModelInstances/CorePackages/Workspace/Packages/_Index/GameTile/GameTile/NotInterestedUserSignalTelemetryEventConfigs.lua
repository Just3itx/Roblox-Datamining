-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
local GameTileParent = script:FindFirstAncestor("GameTile").Parent

local LoggingProtocol = require(GameTileParent.LoggingProtocol)

return {
    NotInterestedMissingAppPage = {
        eventName = "Discovery_NotInterestedMissingAppPage",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 25, 8, 14 },
        description = "Counter for Not Interested Missing App Page"
    },
    NotInterestedUserSignalFailed = {
        eventName = "Discovery_NotInterestedUserSignalFailed",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 25, 8, 14 },
        description = "Counter for Not Interested User Signal Failed"
    }
}
