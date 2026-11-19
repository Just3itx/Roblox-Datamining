-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(CorePackages.Packages.React)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local SignalsReact = require(CorePackages.Packages.SignalsReact)
local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)
local LeaderboardStore = require(CorePackages.Workspace.Packages.LeaderboardStore)
local _PlayerIconInfoStore = require(CorePackages.Workspace.Packages.PlayerIconInfoStore)

local useLeaderboardStore = PlayerList.Hooks.useLeaderboardStore

local TeamListView = require(scriptParentParentParent.Components.PresentationCommon.TeamListView)

local FFlagPlayerListUseFocusNavHook = PlayerList.Flags.FFlagPlayerListUseFocusNavHook

return React.memo(RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        isSmallTouchDevice = arg1.displayOptions.isSmallTouchDevice,
        isDirectionalPreferred = arg1.displayOptions.isTenFootInterface,
        playerIconInfo = arg1.playerIconInfo,
        playerRelationship = arg1.playerRelationship
    }
end)(function(tbl1) -- name: TeamListContainer
    local getCount = useLeaderboardStore().getTeamList().getCount

    local var1 = SignalsReact.useSignalState(getCount)
    local teamPlayersCount = SignalsReact.useSignalState(tbl1.teamData.players.getCount)

    local layoutOrder = SignalsReact.useSignalBinding(tbl1.teamData.order)

    local showTeamEntry = React.useMemo(function()
        if tbl1.teamData.name(false) == LeaderboardStore.SpecialNeutralTeamName then
            if var1 == 1 then
                return false
            end

            if teamPlayersCount == 0 then
                return false
            end
        end
        return true
    end, { var1, teamPlayersCount, tbl1.teamData.name })

    local var5, var6

    if FFlagPlayerListUseFocusNavHook then
        var5, var6 = React.useMemo(function()
            if not (tbl1.registerTeamInstance and tbl1.teamId) then
                return nil, nil
            end

            local var7 = tbl1.registerTeamInstance(tbl1.teamId, tbl1.teamData.order)
            return var7.registerPlayerInstance, var7.unregisterPlayerInstance
        end, { tbl1.registerTeamInstance, tbl1.teamId, tbl1.teamData })
    else
        var5 = nil
        var6 = nil
    end

    if FFlagPlayerListUseFocusNavHook then
        React.useEffect(function()
            return function()
                if tbl1.unregisterTeamInstance and tbl1.teamId then
                    tbl1.unregisterTeamInstance(tbl1.teamId)
                end
            end
        end, { tbl1.unregisterTeamInstance, tbl1.teamId })
    end

    local createElement = React.createElement
    local var7 = TeamListView
    local tbl2 = {
        layoutOrder = layoutOrder,
        showTeamEntry = showTeamEntry,
        teamPlayersCount = teamPlayersCount,
        entrySizeX = tbl1.entrySizeX,
        teamData = tbl1.teamData,
        playerIconInfos = tbl1.playerIconInfos,
        playerRelationships = tbl1.playerRelationships,
        firstPlayerRef = tbl1.firstPlayerRef,
        setDropDownPlayerDimensionY = tbl1.setDropDownPlayerDimensionY,
        prevFocusedEntry = tbl1.prevFocusedEntry,
        destroyedFocusedPlayerId = tbl1.destroyedFocusedPlayerId,
        registerPlayerInstance = 0,
        unregisterPlayerInstance = 0,
        setSelectedPlayerId = 0,
        isSmallTouchDevice = 0,
        isDirectionalPreferred = 0
    }

    if not FFlagPlayerListUseFocusNavHook then
        var5 = nil
    end

    tbl2.registerPlayerInstance = var5
    if not FFlagPlayerListUseFocusNavHook then
        var6 = nil
    end

    tbl2.unregisterPlayerInstance = var6
    tbl2.setSelectedPlayerId = if FFlagPlayerListUseFocusNavHook then tbl1.setSelectedPlayerId else nil
    tbl2.isSmallTouchDevice = tbl1.isSmallTouchDevice
    tbl2.isDirectionalPreferred = tbl1.isDirectionalPreferred
    return createElement(var7, tbl2)
end))
