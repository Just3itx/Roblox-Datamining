-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Cryo = require(scriptParentParentParent.Cryo)
local Rodux = require(scriptParentParentParent.Rodux)

local _Types = require(scriptParentParent.Types)

local MomentsCreationFlowClosed = require(scriptParentParent.Actions.MomentsCreationFlowClosed)
local MomentsCreationFlowOpened = require(scriptParentParent.Actions.MomentsCreationFlowOpened)

local tbl1 = { IsOpen = false, Capture = nil, SessionId = nil }

local createReducer = Rodux.createReducer
local tbl2 = {}
tbl2[MomentsCreationFlowOpened.name] = function(tbl3, arg1)
    return Cryo.Dictionary.join(tbl3, { IsOpen = true, Capture = arg1.capture, SessionId = arg1.sessionId })
end

tbl2[MomentsCreationFlowClosed.name] = function(_, _)
    return tbl1
end

return createReducer(tbl1, tbl2)
