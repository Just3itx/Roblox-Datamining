-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxCall = script:FindFirstAncestor("RoduxCall")
local RoduxCallParent = RoduxCall.Parent
local Rodux = require(RoduxCallParent.Rodux)
local CallStateModel = require(RoduxCall.Models).CallStateModel
local UpdateCall = require(RoduxCall.Actions).UpdateCall

local _roduxCallTypes = require(script.Parent.Parent.roduxCallTypes)

return function()
    local createReducer = Rodux.createReducer
    local tbl1 = {}
    tbl1[UpdateCall.name] = function(_, arg1)
        local call = arg1.payload.call
        return CallStateModel.format(call)
    end

    return createReducer(nil, tbl1)
end
