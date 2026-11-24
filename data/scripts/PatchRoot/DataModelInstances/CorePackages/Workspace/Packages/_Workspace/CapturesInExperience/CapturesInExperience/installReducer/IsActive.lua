-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Rodux = require(scriptParentParentParent.Rodux)

local CapturesActivated = require(scriptParentParent.Actions.CapturesActivated)
local CapturesDeactivated = require(scriptParentParent.Actions.CapturesDeactivated)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[CapturesActivated.name] = function(_: boolean, _): boolean
    return true
end

tbl1[CapturesDeactivated.name] = function(_: boolean, _): boolean
    return false
end

return createReducer(false, tbl1)
