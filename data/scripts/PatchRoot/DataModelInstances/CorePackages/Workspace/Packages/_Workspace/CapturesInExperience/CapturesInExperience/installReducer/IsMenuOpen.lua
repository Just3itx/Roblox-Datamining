-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Rodux = require(scriptParentParentParent.Rodux)

local MenuClosed = require(scriptParentParent.Actions.MenuClosed)
local MenuOpened = require(scriptParentParent.Actions.MenuOpened)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[MenuClosed.name] = function(_: boolean, _): boolean
    return false
end

tbl1[MenuOpened.name] = function(_: boolean, _): boolean
    return true
end

return createReducer(false, tbl1)
