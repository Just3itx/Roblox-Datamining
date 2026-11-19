-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Rodux = require(CorePackages.Packages.Rodux)
local scriptParentParent = script.Parent.Parent
local ShowMenu = require(scriptParentParent.Actions.ShowMenu)
local HideMenu = require(scriptParentParent.Actions.HideMenu)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[ShowMenu.name] = function(_, _): boolean
    return true
end

tbl1[HideMenu.name] = function(_, _): boolean
    return false
end

return createReducer(true, tbl1)
