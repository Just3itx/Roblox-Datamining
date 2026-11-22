-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NetworkingVirtualEvents = script:FindFirstAncestor("NetworkingVirtualEvents")

local _types = require(NetworkingVirtualEvents.types)

local module = {}

function module.mock(id: string)
    local dateTime = DateTime.now()
    return {
        id = id,
        title = "Event Name",
        description = "Event description goes here...",
        host = { hostType = "user", hostId = 1, hostName = "Roblox", hasVerifiedBadge = true },
        eventTime = {
            startTime = dateTime,
            endTime = DateTime.fromUnixTimestamp(dateTime.UnixTimestamp + 86400),
            startUtc = dateTime:ToIsoDate(),
            endUtc = dateTime:ToIsoDate()
        },
        universeId = 3531439676,
        placeId = 123456789,
        eventStatus = "active",
        createdTime = dateTime,
        updatedTime = dateTime,
        userRsvpStatus = "none"
    }
end

function module.fromResponse(arg1)
    local dateTime = DateTime.fromIsoDate(arg1.eventTime.startUtc)
    local dateTime2 = DateTime.fromIsoDate(arg1.eventTime.endUtc)
    local dateTime3 = DateTime.fromIsoDate(arg1.createdUtc)
    local dateTime4 = DateTime.fromIsoDate(arg1.updatedUtc)

    if not (dateTime and dateTime2 and dateTime3 and dateTime4) then
        return nil
    end

    return {
        id = arg1.id,
        title = arg1.title,
        description = arg1.description,
        host = arg1.host,
        eventTime = {
            startTime = dateTime,
            endTime = dateTime2,
            startUtc = arg1.eventTime.startUtc,
            endUtc = arg1.eventTime.endUtc
        },
        universeId = arg1.universeId,
        placeId = arg1.placeId,
        eventStatus = arg1.eventStatus,
        createdTime = dateTime3,
        updatedTime = dateTime4,
        userRsvpStatus = arg1.userRsvpStatus
    }
end

return module
