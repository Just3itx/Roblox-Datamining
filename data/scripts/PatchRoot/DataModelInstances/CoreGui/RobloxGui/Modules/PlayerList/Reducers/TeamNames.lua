-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)
local Cryo = require(CorePackages.Packages.Cryo)

local Actions = script.Parent.Parent.Actions
local AddTeam = require(Actions.AddTeam)
local RemoveTeam = require(Actions.RemoveTeam)
local SetTeamName = require(Actions.SetTeamName)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[AddTeam.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { [arg2.team] = arg2.team.Name })
end

tbl1[RemoveTeam.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { [arg2.team] = Cryo.None })
end

tbl1[SetTeamName.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { [arg2.team] = arg2.teamName })
end

return (createReducer({}, tbl1))
