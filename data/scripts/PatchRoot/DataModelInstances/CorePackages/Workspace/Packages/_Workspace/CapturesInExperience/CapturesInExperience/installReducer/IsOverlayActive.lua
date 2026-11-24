-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Rodux = require(scriptParentParentParent.Rodux)

local OverlayActivated = require(scriptParentParent.Actions.OverlayActivated)
local OverlayDeactivated = require(scriptParentParent.Actions.OverlayDeactivated)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[OverlayActivated.name] = function(_: boolean, _): boolean
    return true
end

tbl1[OverlayDeactivated.name] = function(_: boolean, _): boolean
    return false
end

return createReducer(false, tbl1)
