-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Rodux = require(CorePackages.Packages.Rodux)
local scriptParentParent = script.Parent.Parent

local SetAssets = require(scriptParentParent.Actions.SetAssets)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SetAssets.name] = function(_, _): boolean
    return true
end

return (createReducer(false, tbl1))
