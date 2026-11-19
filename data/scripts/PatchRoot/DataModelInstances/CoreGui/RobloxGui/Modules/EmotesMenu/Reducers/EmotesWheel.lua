-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)
local Rodux = require(CorePackages.Packages.Rodux)

local Actions = script.Parent.Parent.Actions
local FocusSegment = require(Actions.FocusSegment)
local HideMenu = require(Actions.HideMenu)

local tbl1 = { focusedSegmentIndex = 0 }

local createReducer = Rodux.createReducer
local tbl2 = {}
tbl2[FocusSegment.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { focusedSegmentIndex = arg2.segmentIndex })
end

tbl2[HideMenu.name] = function(arg1, _)
    return Cryo.Dictionary.join(arg1, tbl1)
end

return createReducer(tbl1, tbl2)
