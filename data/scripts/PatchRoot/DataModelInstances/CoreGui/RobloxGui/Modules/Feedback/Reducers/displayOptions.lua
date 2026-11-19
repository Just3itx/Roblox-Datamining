-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)
local Cryo = require(CorePackages.Packages.Cryo)

local scriptParentParent = script.Parent.Parent

local SetScreenSize = require(scriptParentParent.Actions.SetScreenSize)

local createReducer = Rodux.createReducer
local tbl1 = {
    inputType = nil,
    screenSize = Vector2.new(0, 0)
}
local tbl2 = {}
tbl2[SetScreenSize.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { screenSize = arg2.screenSize })
end

return createReducer(tbl1, tbl2)
