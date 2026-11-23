-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEventsState = script:FindFirstAncestor("VirtualEventsState")

local Rodux = require(VirtualEventsState.Parent.Rodux)
local Cryo = require(VirtualEventsState.Parent.Cryo)
local _types = require(VirtualEventsState.types)
local VirtualEventModel = require(VirtualEventsState.network).NetworkingVirtualEvents.VirtualEventModel
local logger = require(VirtualEventsState.logger)

return function(arg1)
    local createReducer = Rodux.createReducer
    local tbl1 = {}
    tbl1[arg1.GetActiveVirtualEvents.Succeeded.name] = function(_, arg2)
        local result = {}

        for _, value in arg2.responseBody.data do
            local response = VirtualEventModel.fromResponse(value)

            if not response then
                continue
            end

            if response.eventTime.startTime and response.eventTime.endTime then
                result[value.id] = response
            else
                logger:debug("Discarding VirtualEvent with ID {} (malformed start or end time)", value.id)
            end
        end

        return result
    end

    tbl1[arg1.GetActiveVirtualEvents.Failed.name] = function(_, _)
        return {}
    end

    tbl1[arg1.GetVirtualEvent.Succeeded.name] = function(tbl2, arg2)
        local tbl3 = {}
        local response = VirtualEventModel.fromResponse(arg2.responseBody)

        if response then
            tbl3[response.id] = response
        end

        return Cryo.Dictionary.join(tbl2, tbl3)
    end

    tbl1[arg1.GetVirtualEvent.Failed.name] = function<T>(tbl2, _): T
        return tbl2
    end

    tbl1[arg1.UpdateMyRsvpStatus.Succeeded.name] = function(tbl2, arg2)
        local var1 = arg2.ids[1]
        local var2 = tbl2[var1]

        if not var2 then
            return tbl2
        end

        return Cryo.Dictionary.join(tbl2, { [var1] = Cryo.Dictionary.join(var2, { userRsvpStatus = arg2.postBody.rsvpStatus }) })
    end

    return (createReducer({}, tbl1))
end
