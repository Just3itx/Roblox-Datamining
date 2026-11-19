-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)
local Rodux = require(CorePackages.Packages.Rodux)

local Actions = script.Parent.Parent.Actions

local ShowMenu = require(Actions.ShowMenu)
local HideMenu = require(Actions.HideMenu)

local ShowError = require(Actions.ShowError)
local HideError = require(Actions.HideError)

local SetGuiInset = require(Actions.SetGuiInset)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[ShowMenu.name] = function(arg1, _)
    return Cryo.Dictionary.join(arg1, { menuVisible = true })
end

tbl1[HideMenu.name] = function(arg1, _)
    return Cryo.Dictionary.join(arg1, { menuVisible = false })
end

tbl1[ShowError.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { errorVisible = true, errorText = arg2.errorText })
end

tbl1[HideError.name] = function(arg1, _)
    return Cryo.Dictionary.join(arg1, { errorVisible = false })
end

tbl1[SetGuiInset.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { guiInset = arg2.guiInset })
end

return createReducer({ menuVisible = false, guiInset = 0, errorVisible = false, errorText = "" }, tbl1)
