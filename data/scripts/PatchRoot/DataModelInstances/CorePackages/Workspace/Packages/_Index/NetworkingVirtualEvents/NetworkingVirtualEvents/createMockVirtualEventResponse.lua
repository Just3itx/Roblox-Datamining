-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NetworkingVirtualEvents = script:FindFirstAncestor("NetworkingVirtualEvents")

local _types = require(NetworkingVirtualEvents.types)

local function createMockVirtualEventResponse(id: string)
    return {
        id = id,
        title = "Event Title",
        description = "Event description...",
        host = { hostType = "user", hostId = 1, hostName = "Roblox", hasVerifiedBadge = false },
        eventTime = {
            startUtc = DateTime.fromLocalTime(2022, 1, 1):ToIsoDate(),
            endUtc = DateTime.fromLocalTime(2022, 1, 7):ToIsoDate()
        },
        universeId = 1,
        placeId = 123456789,
        eventStatus = "active",
        createdUtc = DateTime.fromLocalTime(2022, 1, 1):ToIsoDate(),
        updatedUtc = DateTime.fromLocalTime(2022, 1, 1):ToIsoDate(),
        userRsvpStatus = "none"
    }
end

return createMockVirtualEventResponse
