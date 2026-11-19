-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)

local scriptParentParent = script.Parent.Parent

local Actions = scriptParentParent.Actions

local SetLayout = require(Actions.SetLayout)
local Constants = require(scriptParentParent.Constants)

local createReducer = Rodux.createReducer
local Large = Constants.Layout.Large
local tbl1 = {}
tbl1[SetLayout.name] = function(_, arg1)
    return arg1.layout
end

return createReducer(Large, tbl1)
