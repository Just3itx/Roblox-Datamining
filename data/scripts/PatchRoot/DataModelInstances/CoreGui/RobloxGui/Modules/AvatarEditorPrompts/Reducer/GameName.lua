-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")

local Rodux = require(CorePackages.Packages.Rodux)

local _RobloxGui = CoreGui:WaitForChild("RobloxGui")
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local Actions = script.Parent.Parent.Actions

local GameNameFetched = require(Actions.GameNameFetched)

local var1 = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.GameNamePlaceHolder")

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[GameNameFetched.name] = function(_, arg1)
    return arg1.gameName
end

return createReducer(var1, tbl1)
