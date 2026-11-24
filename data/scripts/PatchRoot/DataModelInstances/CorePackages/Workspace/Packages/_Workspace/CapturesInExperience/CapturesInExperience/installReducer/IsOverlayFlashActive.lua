-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Rodux = require(scriptParentParentParent.Rodux)

local OverlayFlashActivated = require(scriptParentParent.Actions.OverlayFlashActivated)
local OverlayFlashDeactivated = require(scriptParentParent.Actions.OverlayFlashDeactivated)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[OverlayFlashActivated.name] = function(_: boolean, _): boolean
    return true
end

tbl1[OverlayFlashDeactivated.name] = function(_: boolean, _): boolean
    return false
end

return createReducer(false, tbl1)
