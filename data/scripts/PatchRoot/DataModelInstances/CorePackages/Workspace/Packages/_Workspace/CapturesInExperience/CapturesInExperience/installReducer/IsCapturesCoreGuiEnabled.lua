-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Rodux = require(scriptParentParentParent.Rodux)

local CapturesCoreGuiDisabled = require(scriptParentParent.Actions.CapturesCoreGuiDisabled)
local CapturesCoreGuiEnabled = require(scriptParentParent.Actions.CapturesCoreGuiEnabled)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[CapturesCoreGuiDisabled.name] = function(_: boolean, _): boolean
    return false
end

tbl1[CapturesCoreGuiEnabled.name] = function(_: boolean, _): boolean
    return true
end

return createReducer(true, tbl1)
