-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local _GraphQLServer = require(VirtualEvents.Parent.GraphQLServer)

local function sortEventsByStartDate(tbl1)
    local var1 = table.clone(tbl1)
    table.sort(var1, function(arg1, arg2): boolean
        if not (arg1.eventTime and arg1.eventTime.startUtc and arg2.eventTime and arg2.eventTime.startUtc) then
            return true
        end

        local dateTime = DateTime.fromIsoDate(arg1.eventTime.startUtc) or DateTime.now()
        local dateTime2 = DateTime.fromIsoDate(arg2.eventTime.startUtc) or DateTime.now()

        return dateTime.UnixTimestamp < dateTime2.UnixTimestamp
    end)
    return var1
end

return sortEventsByStartDate
