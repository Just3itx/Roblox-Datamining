-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)
local Cryo = require(CorePackages.Packages.Cryo)

local Actions = script.Parent.Parent.Actions
local AddPlayerToTeam = require(Actions.AddPlayerToTeam)
local RemovePlayerFromTeam = require(Actions.RemovePlayerFromTeam)
local RemovePlayer = require(Actions.RemovePlayer)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[AddPlayerToTeam.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { [arg2.player.UserId] = arg2.team })
end

tbl1[RemovePlayerFromTeam.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { [arg2.player.UserId] = Cryo.None })
end

tbl1[RemovePlayer.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { [arg2.player.UserId] = Cryo.None })
end

return (createReducer({}, tbl1))
