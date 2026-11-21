-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Types = scriptParentParentParent.Types
local Rodux = require(scriptParentParentParentParent.Rodux)
local _ReducerTypes = require(Types.ReducerTypes)
local _ActionTypes = require(Types.ActionTypes)
local DeviceContactsReceived = require(scriptParentParentParent.Actions).DeviceContactsReceived
local Dash = require(scriptParentParentParentParent.Dash)
local DeviceContact = require(scriptParentParentParent.Models.DeviceContact)

local tbl1 = {}

return function(_)
    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[DeviceContactsReceived.name] = function(_, arg1)
        local payload = arg1.payload
        local result = {}
        Dash.forEach(payload, function(arg2)
            local var1 = DeviceContact.formatFromDevice(arg2)

            result[var1.id] = var1
        end)

        return result
    end

    return createReducer(tbl2, tbl3)
end
