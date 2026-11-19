-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)
local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)

local Actions = script.Parent.Parent.Actions
local OpenPlayerDropDown = require(Actions.OpenPlayerDropDown)
local ClosePlayerDropDown = require(Actions.ClosePlayerDropDown)
local RemovePlayer = require(Actions.RemovePlayer)
local SetPlayerListVisibility = require(Actions.SetPlayerListVisibility)

local FFlagAddNewPlayerListMobileFocusNav = PlayerList.Flags.FFlagAddNewPlayerListMobileFocusNav

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SetPlayerListVisibility.name] = function(arg1, arg2)
    if arg2.isVisible then
        return arg1
    end

    return {
        isVisible = false,
        selectedPlayer = if FFlagAddNewPlayerListMobileFocusNav then nil else arg1.selectedPlayer
    }
end

tbl1[OpenPlayerDropDown.name] = function(_, arg1)
    return {
        isVisible = true,
        selectedPlayer = arg1.selectedPlayer
    }
end

tbl1[ClosePlayerDropDown.name] = function(arg1, _)
    return {
        isVisible = false,
        selectedPlayer = arg1.selectedPlayer
    }
end

tbl1[RemovePlayer.name] = function(arg1, arg2)
    return if arg2.player == arg1.selectedPlayer then { isVisible = false, selectedPlayer = nil } else arg1
end

return (createReducer({ isVisible = false, selectedPlayer = nil }, tbl1))
