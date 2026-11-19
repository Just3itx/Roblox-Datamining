-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Rodux = InGameMenuDependencies.Rodux
local Cryo = InGameMenuDependencies.Cryo

local scriptParentParent = script.Parent.Parent
local OpenNativeClosePrompt = require(scriptParentParent.Actions.OpenNativeClosePrompt)
local CloseNativeClosePrompt = require(scriptParentParent.Actions.CloseNativeClosePrompt)
local SetMenuIconTooltipOpen = require(scriptParentParent.Actions.SetMenuIconTooltipOpen)

local createReducer = Rodux.createReducer

local tbl1 = {}
tbl1[OpenNativeClosePrompt.name] = function(arg1, _)
    return Cryo.Dictionary.join(arg1, { closingApp = true })
end

tbl1[CloseNativeClosePrompt.name] = function(arg1, _)
    return Cryo.Dictionary.join(arg1, { closingApp = false })
end

tbl1[SetMenuIconTooltipOpen.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { menuIconTooltipOpen = arg2.menuIconTooltipOpen })
end

return createReducer({ closingApp = false, menuIconTooltipOpen = false }, tbl1)
