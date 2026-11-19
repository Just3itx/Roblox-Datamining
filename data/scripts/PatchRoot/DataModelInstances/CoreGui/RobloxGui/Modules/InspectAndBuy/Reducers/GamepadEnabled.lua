-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Rodux = require(CorePackages.Packages.Rodux)
local scriptParentParent = script.Parent.Parent

local SetGamepadEnabled = require(scriptParentParent.Actions.SetGamepadEnabled)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SetGamepadEnabled.name] = function(_, arg1)
    return arg1.gamepadEnabled
end

return (createReducer(false, tbl1))
