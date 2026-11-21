-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Types = scriptParentParentParent.Types
local Rodux = require(scriptParentParentParentParent.Rodux)
local _ReducerTypes = require(Types.ReducerTypes)
local _ActionTypes = require(Types.ActionTypes)
local RequestSent = require(scriptParentParentParent.Actions).RequestSent
local Dash = require(scriptParentParentParentParent.Dash)

local tbl1 = {}

return function(_)
    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[RequestSent.name] = function(arg1, arg2)
        return Dash.join(arg1, { [arg2.payload.id] = true })
    end

    return createReducer(tbl2, tbl3)
end
