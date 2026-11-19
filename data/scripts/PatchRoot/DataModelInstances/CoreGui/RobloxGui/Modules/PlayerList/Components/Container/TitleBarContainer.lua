-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(CorePackages.Packages.React)
local SignalsReact = require(CorePackages.Packages.SignalsReact)
local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)
local _LeaderboardStore = require(CorePackages.Workspace.Packages.LeaderboardStore)

local useLeaderboardStore = PlayerList.Hooks.useLeaderboardStore

local TitleBarView = require(scriptParentParentParent.Components.PresentationCommon.TitleBarView)

local FFlagPlayerListFixLeaderstatsStacking = require(CorePackages.Workspace.Packages.SharedFlags).FFlagPlayerListFixLeaderstatsStacking

return React.memo(function(tbl1) -- name: TitleBarContainer
    local gameStats = useLeaderboardStore().getGameStatsList()
    local var2 = if FFlagPlayerListFixLeaderstatsStacking then nil else SignalsReact.useSignalState(gameStats.getCount)
    local createElement = React.createElement
    local var3 = TitleBarView
    local tbl2 = {
        gameStats = gameStats,
        gameStatsCount = 0,
        size = 0,
        entrySizeX = 0,
        layoutOrder = 0,
        contentsVisible = 0,
        isSmallTouchDevice = 0,
        showDivider = 0,
        showBackground = 0,
        backgroundTransparency = 0,
        useCustomTextColor = 0,
        customTextColor = 0,
        headerPaddingLeft = 0
    }

    if FFlagPlayerListFixLeaderstatsStacking then
        var2 = nil
    end

    tbl2.gameStatsCount = var2

    tbl2.size = tbl1.size
    tbl2.entrySizeX = tbl1.entrySizeX
    tbl2.layoutOrder = tbl1.layoutOrder
    tbl2.contentsVisible = tbl1.contentsVisible
    tbl2.isSmallTouchDevice = tbl1.isSmallTouchDevice
    tbl2.showDivider = tbl1.showDivider
    tbl2.showBackground = tbl1.showBackground
    tbl2.backgroundTransparency = tbl1.backgroundTransparency
    tbl2.useCustomTextColor = tbl1.useCustomTextColor
    tbl2.customTextColor = tbl1.customTextColor
    tbl2.headerPaddingLeft = tbl1.headerPaddingLeft
    return createElement(var3, tbl2)
end)
