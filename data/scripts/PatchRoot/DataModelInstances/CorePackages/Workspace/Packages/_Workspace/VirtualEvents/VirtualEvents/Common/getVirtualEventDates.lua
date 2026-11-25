-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local _GraphQLServer = require(VirtualEvents.Parent.GraphQLServer)

local function getVirtualEventDates(arg1)
    local startDate = if arg1.eventTime and arg1.eventTime.startUtc then DateTime.fromIsoDate(arg1.eventTime.startUtc) else nil
    local endDate = if arg1.eventTime and arg1.eventTime.endUtc then DateTime.fromIsoDate(arg1.eventTime.endUtc) else nil
    return {
        startDate = startDate or DateTime.now(),
        endDate = endDate or DateTime.now()
    }
end

return getVirtualEventDates
