-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.InGameMenuDependencies).Rodux

local scriptParentParent = script.Parent.Parent

local Constants = require(scriptParentParent.Resources.Constants)

local SetInspectMenuEnabled = require(scriptParentParent.Actions.SetInspectMenuEnabled)
local SetInputType = require(scriptParentParent.Actions.SetInputType)

local InputType = Constants.InputType

local createReducer = Rodux.createReducer
local tbl1 = {
    inspectMenuEnabled = true,
    inputType = InputType.MouseAndKeyboard
}
local tbl2 = {}
tbl2[SetInspectMenuEnabled.name] = function(arg1, arg2)
    return {
        inspectMenuEnabled = arg2.enabled,
        inputType = arg1.inputType
    }
end

tbl2[SetInputType.name] = function(arg1, arg2)
    return {
        inspectMenuEnabled = arg1.inspectMenuEnabled,
        inputType = arg2.inputType
    }
end

return createReducer(tbl1, tbl2)
