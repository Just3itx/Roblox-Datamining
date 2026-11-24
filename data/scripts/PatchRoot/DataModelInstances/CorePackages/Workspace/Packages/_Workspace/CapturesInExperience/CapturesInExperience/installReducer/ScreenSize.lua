-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Rodux = require(scriptParentParentParent.Rodux)

local ScreenSizeChanged = require(scriptParentParent.Actions.ScreenSizeChanged)

local vector2 = Vector2.new(0, 0)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[ScreenSizeChanged.name] = function(_vector2: Vector2, tbl2)
    return tbl2.screenSize
end

return createReducer(vector2, tbl1)
