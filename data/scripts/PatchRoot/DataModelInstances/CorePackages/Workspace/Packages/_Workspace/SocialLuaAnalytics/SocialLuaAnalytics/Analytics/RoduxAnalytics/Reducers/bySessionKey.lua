-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local dependencies = require(scriptParentParentParentParent.dependencies)
local Rodux = dependencies.Rodux
local Dash = dependencies.Dash

local scriptParentParent = script.Parent.Parent
local _AnalyticsTypes = require(scriptParentParent.AnalyticsTypes)
local SessionIdUpdated = require(scriptParentParent.Actions.SessionIdUpdated)

local tbl1 = {}

return function(_)
    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[SessionIdUpdated.name] = function(arg1, arg2)
        local sessionKey = arg2.payload.sessionKey
        local sessionId = arg2.payload.sessionId

        return Dash.join(arg1 or tbl1, { [sessionKey] = sessionId })
    end

    return createReducer(tbl2, tbl3)
end
