-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local scriptParentParentParent = scriptParentParent.Parent

local Signals = require(scriptParentParentParent.Signals)

local createSignalMap = require(scriptParentParentParent.CoreScriptsRoactCommon).Utilities.createSignalMap

local _LeaderboardStoreTypes = require(scriptParentParent.LeaderboardStoreTypes)

local function createMockLeaderboardStore()
    return function()
        Instance.new("Team").Name = "Neutral"
        local team = Instance.new("Team")
        team.Name = "Team 1"
        local team2 = Instance.new("Team")
        team2.Name = "Team 2"

        local tbl1 = {
            Name = "player1",
            Team = team,
            UserId = math.random(1, 1234567890),
            leaderstats = {
                stat1 = { Value = 100 },
                stat2 = { Value = 200 }
            }
        }

        local tbl2 = {
            order = Signals.createSignal(1),
            stats = createSignalMap()
        }
        tbl2.stats.setData("stat1", Signals.createSignal(tbl1.leaderstats.stat1.Value), false)
        tbl2.stats.setData("stat2", Signals.createSignal(tbl1.leaderstats.stat2.Value), false)

        local tbl3 = {
            Name = "player2",
            Team = team,
            UserId = math.random(1, 1234567890),
            leaderstats = {
                stat1 = { Value = 30 },
                stat2 = { Value = 40 }
            }
        }

        local tbl4 = {
            order = Signals.createSignal(2),
            stats = createSignalMap()
        }
        tbl4.stats.setData("stat1", Signals.createSignal(tbl3.leaderstats.stat1.Value), false)
        tbl4.stats.setData("stat2", Signals.createSignal(tbl3.leaderstats.stat2.Value), false)

        local tbl5 = {
            Name = "player3",
            Team = team2,
            UserId = math.random(1, 1234567890),
            leaderstats = {
                stat1 = { Value = 500 },
                stat2 = { Value = 600 }
            }
        }

        local tbl6 = {
            order = Signals.createSignal(1),
            stats = createSignalMap()
        }
        tbl6.stats.setData("stat1", Signals.createSignal(tbl5.leaderstats.stat1.Value), false)
        tbl6.stats.setData("stat2", Signals.createSignal(tbl5.leaderstats.stat2.Value), false)

        local tbl7 = {
            Name = "player4",
            Team = team2,
            UserId = math.random(1, 1234567890),
            leaderstats = {
                stat1 = { Value = 70 },
                stat2 = { Value = 80 }
            }
        }

        local tbl8 = {
            order = Signals.createSignal(2),
            stats = createSignalMap()
        }
        tbl8.stats.setData("stat1", Signals.createSignal(tbl7.leaderstats.stat1.Value), false)
        tbl8.stats.setData("stat2", Signals.createSignal(tbl7.leaderstats.stat2.Value), false)

        local tbl9 = {
            Name = "player5",
            UserId = math.random(1, 1234567890),
            leaderstats = {
                stat1 = { Value = 90 },
                stat2 = { Value = 100 }
            }
        }

        local tbl10 = {
            order = Signals.createSignal(1),
            stats = createSignalMap()
        }
        tbl10.stats.setData("stat1", Signals.createSignal(tbl9.leaderstats.stat1.Value), false)
        tbl10.stats.setData("stat2", Signals.createSignal(tbl9.leaderstats.stat2.Value), false)

        local signalMap = createSignalMap()

        signalMap.setData(tbl1, tbl2, false)
        signalMap.setData(tbl3, tbl4, false)
        signalMap.setData(tbl5, tbl6, false)
        signalMap.setData(tbl7, tbl8, false)
        signalMap.setData(tbl9, tbl10, false)

        local getGameStatsList = createSignalMap()

        local signalMap3 = createSignalMap()
        signalMap3.setData("Neutral", {
            name = Signals.createSignal("Neutral"),
            color = Signals.createSignal(Color3.fromRGB(0, 0, 0)),
            order = Signals.createSignal(1),
            stats = createSignalMap(),
            players = createSignalMap()
        }, false)
        local data = signalMap3.getData("Neutral", false)
        data.players.setData(tbl9, tbl9.UserId, false)
        data.stats.setData("stat1", Signals.createSignal(tbl9.leaderstats.stat1.Value), false)
        data.stats.setData("stat2", Signals.createSignal(tbl9.leaderstats.stat2.Value), false)

        signalMap3.setData(team, {
            name = Signals.createSignal("Team 1"),
            color = Signals.createSignal(Color3.fromRGB(255, 0, 0)),
            order = Signals.createSignal(2),
            stats = createSignalMap(),
            players = createSignalMap()
        }, false)
        local data2 = signalMap3.getData(team, false)
        data2.players.setData(tbl1, tbl1.UserId, false)
        data2.players.setData(tbl3, tbl3.UserId, false)
        data2.stats.setData("stat1", Signals.createSignal(tbl1.leaderstats.stat1.Value + tbl3.leaderstats.stat1.Value), false)

        data2.stats.setData("stat2", Signals.createSignal(tbl1.leaderstats.stat2.Value + tbl3.leaderstats.stat2.Value), false)

        signalMap3.setData(team2, {
            name = Signals.createSignal("Team 2"),
            color = Signals.createSignal(Color3.fromRGB(0, 255, 0)),
            order = Signals.createSignal(3),
            stats = createSignalMap(),
            players = createSignalMap()
        }, false)
        local data3 = signalMap3.getData(team2, false)
        data3.players.setData(tbl5, tbl5.UserId, false)
        data3.players.setData(tbl7, tbl7.UserId, false)
        data3.stats.setData("stat1", Signals.createSignal(tbl5.leaderstats.stat1.Value + tbl7.leaderstats.stat1.Value), false)

        data3.stats.setData("stat2", Signals.createSignal(tbl5.leaderstats.stat2.Value + tbl7.leaderstats.stat2.Value), false)

        local getTeamList = createSignalMap()
        getTeamList.setData("Neutral", signalMap3.getData("Neutral", false), false)
        getTeamList.setData(team, signalMap3.getData(team, false), false)
        getTeamList.setData(team2, signalMap3.getData(team2, false), false)

        return {
            getGameStatsList = function()
                return getGameStatsList
            end,
            getTeamList = function()
                return getTeamList
            end,
            getTeamPlayerList = function(arg1, _)
                return signalMap3.getData(arg1, false).players
            end,
            getPlayerEntry = function(arg1)
                return (signalMap.getData(arg1, false))
            end,
            cleanUp = function()
                getGameStatsList = nil
                getTeamList = nil
                signalMap3 = nil
                signalMap = nil
            end
        }
    end
end

return createMockLeaderboardStore
