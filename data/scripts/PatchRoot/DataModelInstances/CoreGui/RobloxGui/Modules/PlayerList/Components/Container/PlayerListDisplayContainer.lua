-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(CorePackages.Packages.React)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local SignalsReact = require(CorePackages.Packages.SignalsReact)
local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)
local _LeaderboardStore = require(CorePackages.Workspace.Packages.LeaderboardStore)

local useLeaderboardStore = PlayerList.Hooks.useLeaderboardStore

local PlayerListDisplayView = require(scriptParentParentParent.Components.PresentationCommon.PlayerListDisplayView)
local SetPlayerListVisibility = require(scriptParentParentParent.Actions.SetPlayerListVisibility)

local FFlagAddNewPlayerListFocusNav = PlayerList.Flags.FFlagAddNewPlayerListFocusNav

local function PlayerListDisplayContainer(tbl1)
    local var1 = useLeaderboardStore()

    local gameStatsList = var1.getGameStatsList()
    local teamList = var1.getTeamList()

    local gameStatsCount = SignalsReact.useSignalState(gameStatsList.getCount)
    local teamListCount = SignalsReact.useSignalState(teamList.getCount)

    if not var1 then
        return nil
    end

    return (React.createElement(
        React.Fragment,
        nil,
        React.createElement(PlayerListDisplayView, {
            teamList = teamList,
            teamListCount = teamListCount,
            gameStatsCount = gameStatsCount,
            entrySizeX = tbl1.entrySize,
            screenSizeY = tbl1.screenSizeY,
            playerIconInfo = tbl1.playerIconInfo,
            playerRelationship = tbl1.playerRelationship,
            dropDownPlayer = tbl1.dropDownPlayer,
            dropDownVisible = tbl1.dropDownVisible,
            dismissPlayerList = tbl1.dismissPlayerList,
            isVisible = tbl1.isVisible,
            isMinimized = tbl1.isMinimized,
            isSmallTouchDevice = tbl1.isSmallTouchDevice,
            isDirectionalPreferred = tbl1.isDirectionalPreferred,
            isUsingGamepad = tbl1.isUsingGamepad
        })
    ))
end

return React.memo(RoactRodux.connect(function(arg1) -- name: mapStateToProps
    local isMinimized = arg1.displayOptions.isMinimized

    return {
        isVisible = if FFlagAddNewPlayerListFocusNav then nil else arg1.displayOptions.isVisible,
        isMinimized = isMinimized,
        isDirectionalPreferred = arg1.displayOptions.isTenFootInterface,
        isUsingGamepad = arg1.displayOptions.isUsingGamepad,
        isSmallTouchDevice = arg1.displayOptions.isSmallTouchDevice,
        playerIconInfo = arg1.playerIconInfo,
        playerRelationship = arg1.playerRelationship,
        dropDownPlayer = arg1.playerDropDown.selectedPlayer,
        dropDownVisible = arg1.playerDropDown.isVisible
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        dismissPlayerList = function()
            return arg1(SetPlayerListVisibility(false))
        end
    }
end)(function(tbl1) -- name: PlayerListDisplayContainerWithLeaderboardStore
    if useLeaderboardStore() then
        return (PlayerListDisplayContainer(tbl1))
    end

    return nil
end))
