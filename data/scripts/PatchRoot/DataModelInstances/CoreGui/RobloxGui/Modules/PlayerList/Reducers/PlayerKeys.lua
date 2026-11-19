-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)

local Actions = script.Parent.Parent.Actions
local AddPlayer = require(Actions.AddPlayer)
local RemovePlayer = require(Actions.RemovePlayer)
local SetPlayerLeaderstat = require(Actions.SetPlayerLeaderstat)

local function createKey(arg1, arg2, playerStats)
    local var1 = if arg2 == nil or playerStats == nil or playerStats[arg1.UserId] == nil then nil else playerStats[arg1.UserId][arg2]
    return {
        name = arg1.DisplayName:upper(),
        stat = var1 and (tonumber(var1) or var1)
    }
end

local function PlayerKeys(arg1, arg2, arg3)
    local name = if arg3.gameStats[1] then arg3.gameStats[1].name or nil else nil

    if not arg1 or name ~= arg1.primaryStat then
        local keys = ({})
        for _, player in pairs(arg3.players) do
            keys[player] = createKey(player, name, arg3.playerStats)
        end

        return { primaryStat = name, keys = keys }
    end

    if arg2.type == AddPlayer.name or arg2.type == SetPlayerLeaderstat.name then
        local tbl1 = {
            primaryStat = name,
            keys = Cryo.Dictionary.join(arg1.keys, { [arg2.player] = createKey(arg2.player, name, arg3.playerStats) })
        }
        return tbl1
    end

    if arg2.type ~= RemovePlayer.name then
        return arg1
    end

    local tbl1 = {
        primaryStat = name,
        keys = Cryo.Dictionary.join(arg1.keys, { [arg2.player] = Cryo.None })
    }
    return tbl1
end

return PlayerKeys
