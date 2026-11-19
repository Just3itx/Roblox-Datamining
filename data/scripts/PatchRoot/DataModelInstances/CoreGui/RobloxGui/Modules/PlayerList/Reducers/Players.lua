-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)
local Cryo = require(CorePackages.Packages.Cryo)

local Actions = script.Parent.Parent.Actions
local AddPlayer = require(Actions.AddPlayer)
local RemovePlayer = require(Actions.RemovePlayer)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[AddPlayer.name] = function(arg1, arg2)
    return Cryo.List.join(arg1, { arg2.player })
end

tbl1[RemovePlayer.name] = function(arg1, arg2)
    return Cryo.List.filter(arg1, function(player): boolean
        return player ~= arg2.player
    end)
end

return (createReducer({}, tbl1))
