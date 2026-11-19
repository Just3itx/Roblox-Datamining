-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Rodux = require(CorePackages.Packages.Rodux)
local scriptParentParent = script.Parent.Parent
local SetView = require(scriptParentParent.Actions.SetView)
local Constants = require(scriptParentParent.Constants)

local createReducer = Rodux.createReducer
local Wide = Constants.View.Wide
local tbl1 = {}
tbl1[SetView.name] = function(_, arg1)
    return arg1.view
end

return createReducer(Wide, tbl1)
