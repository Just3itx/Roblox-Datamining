-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent

local scriptParentParent = scriptParent.Parent

local _Signals = require(scriptParentParent.Signals)

local createSignalMap = require(scriptParentParent.CoreScriptsRoactCommon).Utilities.createSignalMap

local _LeaderboardStoreTypes = require(scriptParent.LeaderboardStoreTypes)

local LeaderboardStore = require(scriptParent.LeaderboardStore)

local function createLeaderboardStore(arg1, arg2)
    return function()
        local var1 = arg1 or game:GetService("Teams")
        local var2 = arg2 or game:GetService("Players")
        local leaderboardStore = LeaderboardStore.new(var1, var2)
        return {
            getGameStatsList = function()
                if not leaderboardStore then
                    return createSignalMap()
                end
                return leaderboardStore:getGameStatsList()
            end,
            getTeamList = function()
                if not leaderboardStore then
                    return createSignalMap()
                end
                return leaderboardStore:getTeamList()
            end,
            getTeamPlayerList = function(arg3, arg4)
                if not leaderboardStore then
                    return createSignalMap()
                end
                return leaderboardStore:getTeamPlayerList(arg3, arg4)
            end,
            getPlayerEntry = function(arg3, arg4)
                if not leaderboardStore then
                    return nil
                end
                return (leaderboardStore:getPlayerEntry(arg3, arg4))
            end,
            cleanUp = function()
                leaderboardStore:destroy()
                leaderboardStore = nil
            end
        }
    end
end

return createLeaderboardStore
