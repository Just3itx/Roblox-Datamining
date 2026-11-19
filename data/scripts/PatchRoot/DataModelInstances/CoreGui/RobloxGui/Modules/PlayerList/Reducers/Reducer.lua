-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)

local DisplayOptions = require(script.Parent.DisplayOptions)
local ScreenSize = require(script.Parent.ScreenSize)
local Settings = require(script.Parent.Settings)
local GameStats = require(script.Parent.GameStats)

local Teams = require(script.Parent.Teams)
local TeamNames = require(script.Parent.TeamNames)
local TeamColors = require(script.Parent.TeamColors)

local Players = require(script.Parent.Players)
local PlayerStats = require(script.Parent.PlayerStats)
local PlayerTeam = require(script.Parent.PlayerTeam)
local PlayerIconInfo = require(script.Parent.PlayerIconInfo)
local PlayerRelationship = require(script.Parent.PlayerRelationship)

local PlayerDropDown = require(script.Parent.PlayerDropDown)
local PlayerKeys = require(script.Parent.PlayerKeys)

local var1 = Rodux.combineReducers({
    displayOptions = DisplayOptions,
    screenSize = ScreenSize,
    settings = Settings,
    gameStats = GameStats,
    teams = Teams,
    teamNames = TeamNames,
    teamColors = TeamColors,
    players = Players,
    playerStats = PlayerStats,
    playerTeam = PlayerTeam,
    playerIconInfo = PlayerIconInfo,
    playerRelationship = PlayerRelationship,
    playerDropDown = PlayerDropDown
})

return function(arg1, arg2)
    local var2 = var1(arg1, arg2)

    var2.playerKeys = PlayerKeys(arg1 and arg1.playerKeys or nil, arg2, var2)

    return var2
end
