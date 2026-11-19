-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Cryo = InGameMenuDependencies.Cryo
local Rodux = InGameMenuDependencies.Rodux

local scriptParentParent = script.Parent.Parent

local SetGameNameAndDescription = require(scriptParentParent.Actions.SetGameNameAndDescription)

local createReducer = Rodux.createReducer

local tbl1 = {}
tbl1[SetGameNameAndDescription.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { name = arg2.gameName, description = arg2.gameDescription })
end

return createReducer({ name = "Game", description = "" }, tbl1)
