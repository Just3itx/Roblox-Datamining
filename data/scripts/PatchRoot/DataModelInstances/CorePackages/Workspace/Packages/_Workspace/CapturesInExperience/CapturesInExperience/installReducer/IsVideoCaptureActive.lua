-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Rodux = require(scriptParentParentParent.Rodux)

local VideoCaptureStarted = require(scriptParentParent.Actions.VideoCaptureStarted)
local VideoCaptureStopped = require(scriptParentParent.Actions.VideoCaptureStopped)

local _CaptureTriggerType = require(scriptParentParent.Enums.CaptureTriggerType)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[VideoCaptureStarted.name] = function(_, arg1)
    return {
        status = true,
        triggerType = arg1.triggerType
    }
end

tbl1[VideoCaptureStopped.name] = function(_, arg1)
    return {
        status = false,
        triggerType = arg1.triggerType
    }
end

return createReducer({ status = false, triggerType = nil }, tbl1)
