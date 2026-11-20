-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxPresence = script:FindFirstAncestor("RoduxPresence")
local RoduxPresenceParent = RoduxPresence.Parent
local Rodux = require(RoduxPresenceParent.Rodux)
local Cryo = require(RoduxPresenceParent.Cryo)

local Actions = RoduxPresence.Actions
local ReceivedUserPresence = require(Actions.ReceivedUserPresence)

local PresenceModel = require(RoduxPresence.Models.PresenceModel)

local tbl1 = {}
return function(arg1)
    local presenceNetworking = arg1.presenceNetworking

    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[ReceivedUserPresence.name] = function(arg2, arg3)
        local userId = arg3.payload.userId
        local payload = arg3.payload

        assert(PresenceModel.isValid(payload))

        return Cryo.Dictionary.join(arg2, { [userId] = PresenceModel.format(payload) })
    end

    tbl3[presenceNetworking.GetPresencesFromUserIds.Succeeded.name] = function(arg2, arg3)
        local userPresences = arg3.responseBody.userPresences

        local tbl4 = {}
        for _, value in ipairs(userPresences) do
            local userId = value.userId
            tbl4[tostring(userId)] = PresenceModel.format(value)
        end

        return Cryo.Dictionary.join(arg2, tbl4)
    end

    return createReducer(tbl2, tbl3)
end
