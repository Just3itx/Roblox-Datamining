-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)

local scriptParentParent = script.Parent.Parent

local ScreenSizeUpdated = require(scriptParentParent.Actions.ScreenSizeUpdated)

local createReducer = Rodux.createReducer
local vector2 = Vector2.new(0, 0)
local tbl1 = {}
tbl1[ScreenSizeUpdated.name] = function(_, arg1)
    return arg1.screenSize
end

return (createReducer(vector2, tbl1))
