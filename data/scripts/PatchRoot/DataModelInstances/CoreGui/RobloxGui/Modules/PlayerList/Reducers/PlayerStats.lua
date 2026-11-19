-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)
local Cryo = require(CorePackages.Packages.Cryo)

local Actions = script.Parent.Parent.Actions
local AddPlayer = require(Actions.AddPlayer)
local RemovePlayer = require(Actions.RemovePlayer)
local SetPlayerLeaderstat = require(Actions.SetPlayerLeaderstat)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[AddPlayer.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { [arg2.userId] = {} })
end

tbl1[RemovePlayer.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { [arg2.userId] = Cryo.None })
end

tbl1[SetPlayerLeaderstat.name] = function(arg1, arg2)
    if arg1[arg2.userId] == nil then
        return arg1
    end
    local join = Cryo.Dictionary.join
    local tbl2 = {
        [arg2.userId] = Cryo.Dictionary.join(arg1[arg2.userId], { [arg2.leaderstat] = arg2.value })
    }
    return join(arg1, tbl2)
end

return (createReducer({}, tbl1))
