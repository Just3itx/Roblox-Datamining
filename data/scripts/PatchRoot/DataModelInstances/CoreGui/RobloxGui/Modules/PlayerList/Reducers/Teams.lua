-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)
local Cryo = require(CorePackages.Packages.Cryo)

local Actions = script.Parent.Parent.Actions
local AddTeam = require(Actions.AddTeam)
local RemoveTeam = require(Actions.RemoveTeam)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[AddTeam.name] = function(arg1, arg2)
    return Cryo.List.join(arg1, { arg2.team })
end

tbl1[RemoveTeam.name] = function(arg1, arg2)
    return Cryo.List.filter(arg1, function(team): boolean
        return team ~= arg2.team
    end)
end

return (createReducer({}, tbl1))
