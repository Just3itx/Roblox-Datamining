-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local _GraphQLServer = require(VirtualEvents.Parent.GraphQLServer)
local getVirtualEventDates = require(VirtualEvents.Common.getVirtualEventDates)

local function getSecondsLeftInEvent(arg1, dateTime)
    local virtualEventDates = getVirtualEventDates(arg1)

    if dateTime.UnixTimestamp < virtualEventDates.startDate.UnixTimestamp then
        return math.huge
    end

    if dateTime.UnixTimestamp > virtualEventDates.endDate.UnixTimestamp then
        return 0
    end

    return virtualEventDates.endDate.UnixTimestamp - virtualEventDates.startDate.UnixTimestamp - (dateTime.UnixTimestamp - virtualEventDates.startDate.UnixTimestamp)
end

return getSecondsLeftInEvent
