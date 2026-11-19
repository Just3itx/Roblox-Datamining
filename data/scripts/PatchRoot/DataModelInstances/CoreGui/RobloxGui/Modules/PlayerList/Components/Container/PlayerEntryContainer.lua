-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(CorePackages.Packages.React)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local SignalsReact = require(CorePackages.Packages.SignalsReact)
local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)
local _LeaderboardStore = require(CorePackages.Workspace.Packages.LeaderboardStore)
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local PlayerIconInfoStore = require(CorePackages.Workspace.Packages.PlayerIconInfoStore)

local useLeaderboardStore = PlayerList.Hooks.useLeaderboardStore

local PlayerEntryView = require(scriptParentParentParent.Components.PresentationCommon.PlayerEntryView)
local ClosePlayerDropDown = require(scriptParentParentParent.Actions.ClosePlayerDropDown)
local OpenPlayerDropDown = require(scriptParentParentParent.Actions.OpenPlayerDropDown)
local FFlagReplacePlayerIconRoduxWithSignal = SharedFlags.FFlagReplacePlayerIconRoduxWithSignal
local PlayerIconInfoStore2 = if FFlagReplacePlayerIconRoduxWithSignal then PlayerIconInfoStore.PlayerIconInfoStore else nil
local FFlagPlayerListFixLeaderstatsStacking = SharedFlags.FFlagPlayerListFixLeaderstatsStacking
local FFlagPlayerListUseFocusNavHook = PlayerList.Flags.FFlagPlayerListUseFocusNavHook

return React.memo(RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        selectedPlayer = arg1.playerDropDown.selectedPlayer,
        dropdownOpen = arg1.playerDropDown.isVisible,
        isSmallTouchDevice = arg1.displayOptions.isSmallTouchDevice,
        isDirectionalPreferred = arg1.displayOptions.isTenFootInterface
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        closeDropdown = function()
            return arg1(ClosePlayerDropDown())
        end,
        openDropdown = function(arg2)
            return arg1(OpenPlayerDropDown(arg2))
        end
    }
end)(function(tbl1) -- name: PlayerEntryContainer
    local var1 = useLeaderboardStore()
    local playerIconInfo

    if FFlagReplacePlayerIconRoduxWithSignal then
        local playerIconInfoReactive = PlayerIconInfoStore2.getPlayerIconInfoReactive(tbl1.player.UserId)
        playerIconInfo = SignalsReact.useSignalState(playerIconInfoReactive)
    else
        playerIconInfo = tbl1.playerIconInfo
    end

    local gameStats = var1.getGameStatsList()
    local playerData = var1.getPlayerEntry(tbl1.player, false)
    local var2 = if FFlagPlayerListFixLeaderstatsStacking then nil else SignalsReact.useSignalState(gameStats.getCount)

    if not playerData then
        return nil
    end

    local createElement = React.createElement
    local var3 = PlayerEntryView
    local tbl2 = {
        playerData = playerData,
        gameStats = gameStats,
        gameStatsCount = 0,
        size = 0,
        entrySizeX = 0,
        layoutOrder = 0,
        player = 0,
        titlePlayerEntry = 0,
        playerIconInfo = 0,
        playerRelationship = 0,
        dropdownOpen = 0,
        selectedPlayer = 0,
        firstPlayerRef = 0,
        openDropdown = 0,
        closeDropdown = 0,
        setDropDownPlayerDimensionY = 0,
        prevFocusedEntry = 0,
        destroyedFocusedPlayerId = 0,
        registerPlayerInstance = 0,
        unregisterPlayerInstance = 0,
        setSelectedPlayerId = 0,
        isSmallTouchDevice = 0,
        isDirectionalPreferred = 0
    }

    if FFlagPlayerListFixLeaderstatsStacking then
        var2 = nil
    end

    tbl2.gameStatsCount = var2
    tbl2.size = tbl1.size
    tbl2.entrySizeX = tbl1.entrySizeX
    tbl2.layoutOrder = tbl1.layoutOrder
    tbl2.player = tbl1.player
    tbl2.titlePlayerEntry = tbl1.titlePlayerEntry
    tbl2.playerIconInfo = playerIconInfo
    tbl2.playerRelationship = tbl1.playerRelationship
    tbl2.dropdownOpen = tbl1.dropdownOpen
    tbl2.selectedPlayer = tbl1.selectedPlayer
    tbl2.firstPlayerRef = tbl1.firstPlayerRef
    tbl2.openDropdown = tbl1.openDropdown
    tbl2.closeDropdown = tbl1.closeDropdown
    tbl2.setDropDownPlayerDimensionY = tbl1.setDropDownPlayerDimensionY
    tbl2.prevFocusedEntry = tbl1.prevFocusedEntry
    tbl2.destroyedFocusedPlayerId = tbl1.destroyedFocusedPlayerId
    tbl2.registerPlayerInstance = if FFlagPlayerListUseFocusNavHook then tbl1.registerPlayerInstance else nil
    tbl2.unregisterPlayerInstance = if FFlagPlayerListUseFocusNavHook then tbl1.unregisterPlayerInstance else nil
    tbl2.setSelectedPlayerId = if FFlagPlayerListUseFocusNavHook then tbl1.setSelectedPlayerId else nil
    tbl2.isSmallTouchDevice = tbl1.isSmallTouchDevice
    tbl2.isDirectionalPreferred = tbl1.isDirectionalPreferred
    return (createElement(var3, tbl2))
end))
