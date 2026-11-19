-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(CorePackages.Packages.React)
local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)
local _LeaderboardStore = require(CorePackages.Workspace.Packages.LeaderboardStore)
local SignalsReact = require(CorePackages.Packages.SignalsReact)

local GameTranslator = require(RobloxGui.Modules.GameTranslator)

local useLeaderboardStore = PlayerList.Hooks.useLeaderboardStore

local TeamEntryView = require(scriptParentParentParent.Components.PresentationCommon.TeamEntryView)

local FFlagPlayerListFixLeaderstatsStacking = require(CorePackages.Workspace.Packages.SharedFlags).FFlagPlayerListFixLeaderstatsStacking

return React.memo(function(tbl1) -- name: TeamEntryContainer
    local gameStats = useLeaderboardStore().getGameStatsList()
    local stats = tbl1.teamData.stats

    local teamName = SignalsReact.useSignalBinding(function(arg1)
        return GameTranslator:TranslateGameText(CoreGui, tbl1.teamData.name(arg1))
    end)

    local teamColor = SignalsReact.useSignalState(tbl1.teamData.color)
    local var4 = if FFlagPlayerListFixLeaderstatsStacking then nil else SignalsReact.useSignalState(gameStats.getCount)
    local var5 = if FFlagPlayerListFixLeaderstatsStacking then nil else SignalsReact.useSignalState(stats.getCount)
    local createElement = React.createElement
    local var6 = TeamEntryView
    local tbl2 = {
        teamName = teamName,
        teamColor = teamColor,
        gameStatsCount = 0,
        teamStatsCount = 0,
        gameStats = 0,
        teamStats = 0,
        size = 0,
        entrySizeX = 0,
        layoutOrder = 0,
        isSmallTouchDevice = 0,
        isDirectionalPreferred = 0
    }

    if FFlagPlayerListFixLeaderstatsStacking then
        var4 = nil
    end

    tbl2.gameStatsCount = var4
    if FFlagPlayerListFixLeaderstatsStacking then
        var5 = nil
    end

    tbl2.teamStatsCount = var5
    tbl2.gameStats = gameStats
    tbl2.teamStats = stats

    tbl2.size = tbl1.size
    tbl2.entrySizeX = tbl1.entrySizeX
    tbl2.layoutOrder = tbl1.layoutOrder
    tbl2.isSmallTouchDevice = tbl1.isSmallTouchDevice
    tbl2.isDirectionalPreferred = tbl1.isDirectionalPreferred
    return createElement(var6, tbl2)
end)
