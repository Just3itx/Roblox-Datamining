-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local _GraphQLServer = require(VirtualEvents.Parent.GraphQLServer)
local _VirtualEventsState = require(VirtualEvents.Parent.VirtualEventsState)
local getVirtualEventDates = require(VirtualEvents.Common.getVirtualEventDates)

local function getEventTimerStatus(arg1, dateTime): string
    local virtualEventDates = getVirtualEventDates(arg1)

    local var1 = virtualEventDates.startDate.UnixTimestamp - dateTime.UnixTimestamp
    local var2 = virtualEventDates.endDate.UnixTimestamp - dateTime.UnixTimestamp

    if not (dateTime.UnixTimestamp >= virtualEventDates.startDate.UnixTimestamp) then
        if var1 > 0 and var1 <= 14400 then
            return "UpcomingImminent"
        end

        return "Upcoming"
    end

    if dateTime.UnixTimestamp < virtualEventDates.endDate.UnixTimestamp then
        if var2 <= 14400 then
            return "ElapsedImminent"
        end

        return "Ongoing"
    end

    return "Elapsed"
end

return getEventTimerStatus
