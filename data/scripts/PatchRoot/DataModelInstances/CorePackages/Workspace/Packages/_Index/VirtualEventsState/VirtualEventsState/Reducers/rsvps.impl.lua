-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEventsState = script:FindFirstAncestor("VirtualEventsState")

local Rodux = require(VirtualEventsState.Parent.Rodux)
local Cryo = require(VirtualEventsState.Parent.Cryo)
local _NetworkingVirtualEvents = require(VirtualEventsState.Parent.NetworkingVirtualEvents)

return function(arg1, arg2)
    local createReducer = Rodux.createReducer

    local tbl1 = {}
    tbl1[arg1.GetVirtualEventRsvps.Succeeded.name] = function(_, arg3)
        return {
            nextPageCursor = arg3.responseBody.nextPageCursor,
            prevPageCursor = arg3.responseBody.prevPageCursor
        }
    end

    local page = createReducer({ nextPageCursor = nil, prevPageCursor = nil }, tbl1)

    local createReducer2 = Rodux.createReducer
    local tbl2 = {}
    tbl2[arg1.GetVirtualEventRsvpCounts.Succeeded.name] = function(tbl3, arg3)
        local var1 = arg3.ids[1]

        return Cryo.Dictionary.join(tbl3, { [var1] = arg3.responseBody.counters })
    end

    tbl2[arg1.GetVirtualEventRsvpCounts.Failed.name] = function<T>(tbl3, _): T
        return tbl3
    end

    tbl2[arg1.UpdateMyRsvpStatus.Succeeded.name] = function(tbl3, arg3)
        local var1 = arg3.ids[1]
        local var2 = tbl3[var1]

        if not var2 then
            return tbl3
        end

        local rsvpStatus = arg3.postBody.rsvpStatus
        local num1 = 0
        if rsvpStatus == "going" then
            num1 = 1
        elseif rsvpStatus == "notGoing" then
            num1 = -1
        end

        local join = Cryo.Dictionary.join
        local tbl4 = {
            [var1] = Cryo.Dictionary.join(var2, { going = math.clamp(var2.going + num1, 0, math.huge) })
        }
        return join(tbl3, tbl4)
    end

    tbl2[arg1.UpdateMyRsvpStatus.Failed.name] = function<T>(tbl3, _): T
        return tbl3
    end

    local counters = createReducer2({}, tbl2)

    local createReducer3 = Rodux.createReducer
    local tbl3 = {}
    tbl3[arg1.GetVirtualEventRsvps.Succeeded.name] = function(tbl4, arg3)
        local var1 = arg3.ids[1]

        local tbl5 = {}
        for _, value in arg3.responseBody.data do
            local userId = value.userId
            tbl5[tostring(userId)] = value
        end

        return Cryo.Dictionary.join(tbl4, { [var1] = Cryo.Dictionary.join(tbl4[var1] or {}, tbl5) })
    end

    tbl3[arg1.GetVirtualEventRsvps.Failed.name] = function<T>(tbl4, _): T
        return tbl4
    end

    tbl3[arg1.UpdateMyRsvpStatus.Succeeded.name] = function(tbl4, arg3)
        local var1 = arg3.ids[1]
        local userId = if arg2.LocalPlayer then arg2.LocalPlayer.UserId else -1

        local tbl5 = {
            [tostring(userId)] = {
                userId = userId,
                rsvpStatus = arg3.postBody.rsvpStatus
            }
        }

        return Cryo.Dictionary.join(tbl4, { [var1] = Cryo.Dictionary.join(tbl4[var1] or {}, tbl5) })
    end

    tbl3[arg1.UpdateMyRsvpStatus.Failed.name] = function<T>(tbl4, _): T
        return tbl4
    end

    local byVirtualEventId = createReducer3({}, tbl3)

    return (Rodux.combineReducers({ page = page, counters = counters, byVirtualEventId = byVirtualEventId }))
end
