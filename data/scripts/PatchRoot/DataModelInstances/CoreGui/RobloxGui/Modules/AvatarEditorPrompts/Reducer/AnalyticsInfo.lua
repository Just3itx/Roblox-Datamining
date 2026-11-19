-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:20:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)
local Cryo = require(CorePackages.Packages.Cryo)

local scriptParentParent = script.Parent.Parent

local CloseOpenPrompt = require(scriptParentParent.Actions.CloseOpenPrompt)
local AddAnalyticsInfo = require(scriptParentParent.Actions.AddAnalyticsInfo)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[AddAnalyticsInfo.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, arg2.info)
end

tbl1[CloseOpenPrompt.name] = function(_, _)
    return {}
end

return (createReducer({ addedAssets = nil, removedAssets = nil }, tbl1))
