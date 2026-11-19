-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local Signals = require(CorePackages.Packages.Signals)
local SignalsReact = require(CorePackages.Packages.SignalsReact)
local Otter = require(CorePackages.Packages.Otter)
local Cryo = require(CorePackages.Packages.Cryo)
local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)
local _LeaderboardStore = require(CorePackages.Workspace.Packages.LeaderboardStore)
local Display = require(CorePackages.Workspace.Packages.Display)

local StatsUtils = require(RobloxGui.Modules.Stats.StatsUtils)

local scriptParent = script.Parent
local PresentationCommon = scriptParent.Parent.PresentationCommon
local scriptParentParentParent = scriptParent.Parent.Parent

local useLeaderboardStore = PlayerList.Hooks.useLeaderboardStore
local usePlatformLeaderboard = PlayerList.Hooks.usePlatformLeaderboard
local Constants = PlayerList.Common.Constants

local PlayerEntryContainer = require(scriptParentParentParent.Components.Container.PlayerEntryContainer)
local PlayerListDisplayContainer = require(scriptParentParentParent.Components.Container.PlayerListDisplayContainer)
local TenFootSideBar = require(PresentationCommon.TenFootSideBar)

local Connection = scriptParentParentParent.Components.Connection
local EventConnections = require(Connection.EventConnections)
local ContextActionsBinder = require(Connection.ContextActionsBinder)
local TopStatConnector = require(Connection.TopStatConnector)
local WithLayoutValues = require(Connection.LayoutValues).WithLayoutValues

local FFlagAddNewPlayerListFocusNav = PlayerList.Flags.FFlagAddNewPlayerListFocusNav
local FFlagPlayerListFixPlatformLeaderboardSizing = PlayerList.Flags.FFlagPlayerListFixPlatformLeaderboardSizing
local FFlagPlayerListTwoTabsOnLegacy = PlayerList.Flags.FFlagPlayerListTwoTabsOnLegacy
local FFlagPlayerListRemoveTopStat = require(scriptParentParentParent.Flags.FFlagPlayerListRemoveTopStat)

local tbl1 = { dampingRatio = 1, frequency = 7 }
local signal = if FFlagPlayerListFixPlatformLeaderboardSizing and FFlagPlayerListTwoTabsOnLegacy then Signals.createSignal(false) else nil
local var1 = Roact.PureComponent:extend("PlayerListApp")

local function shouldShowNeutralTeam(players) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, player in ipairs(players) do
        if player.Team == nil then
            return true
        end
    end
    return false
end

local function getTeamCount(teams, players): number
    local tbl2 = {}
    local num1 = 0
    for _, team in pairs(teams) do
        if not tbl2[team.TeamColor.Number] then
            tbl2[team.TeamColor.Number] = true
            num1 += 1
        end
    end

    if num1 > 0 and shouldShowNeutralTeam(players) then
        num1 += 1
    end
    return num1
end

function var1.init(arg1)
    arg1.state = { visible = true }

    local positionOffset, updatePositionOffset = Roact.createBinding(UDim2.new(0, 0, 0, 0))
    arg1.positionOffset = positionOffset
    arg1.updatePositionOffset = updatePositionOffset

    arg1.positionMotor = Otter.createSingleMotor(0)
    arg1.positionMotor:onStep(function(xScale: number?)
        arg1.updatePositionOffset(UDim2.new(xScale, 0, 0, 0))
    end)
    arg1.positionMotor:onComplete(function(_)
        if not arg1.props.displayOptions.isVisible then
            arg1:setState({ visible = false })
        end
    end)

    arg1.disposeUiScaleEffect = Signals.createEffect(function(arg2)
        local displayStore = Display.GetDisplayStore(arg2)
        arg1:setState({ UiScale = displayStore.getUIScale(arg2) })
    end)
end

function var1.render(arg1)
    if not arg1.state.visible then
        return Roact.createFragment({ Roact.createElement(ContextActionsBinder), if FFlagAddNewPlayerListFocusNav then Roact.createElement(EventConnections) else nil })
    end

    return WithLayoutValues(function(arg2)
        local containerPosition = arg2.ContainerPosition
        local containerSize = arg2.ContainerSize
        local anchorPoint = arg2.AnchorPoint
        if not arg2.IsTenFoot and arg1.props.displayOptions.performanceStatsVisible then
            containerPosition += UDim2.fromOffset(0, StatsUtils.ButtonHeight)
        end

        local var2 = containerPosition + UDim2.fromOffset(0, arg2.TopBarOffset * arg1.state.UiScale)

        local maxLeaderstats = arg2.MaxLeaderstats
        if arg1.props.displayOptions.isSmallTouchDevice then
            maxLeaderstats = arg2.MaxLeaderstatsSmallScreen
        end

        local num1 = math.min(arg1.props.gameStatsCount, maxLeaderstats)

        if num1 > 0 then
            local var3 = arg2.StatEntrySizeX + arg2.EntryPadding
            containerSize += UDim2.new(0, var3 * num1, 0, 0)
        end

        local entrySizeX

        if arg2.IsTenFoot then
            entrySizeX = arg2.EntrySizeX
        else
            entrySizeX = arg2.EntryBaseSizeX + math.min(4, num1) * arg2.EntrySizeIncreasePerStat

            local var3 = containerSize + UDim2.new(0, arg2.ExtraContainerPadding, 0, 0)

            if FFlagPlayerListFixPlatformLeaderboardSizing and arg1.props.hasPlatformLeaderboard then
                entrySizeX = math.max(entrySizeX, Constants.PLATFORM_PANEL_WIDTH - var3.X.Offset)
            end

            local var4 = arg2.PlayerDropDownSizeX + arg2.PlayerDropDownOffset
            local var5 = var3.X.Offset + arg2.ContainerPadding * 2 + var4

            if arg1.props.screenSizeX - var5 < entrySizeX then
                entrySizeX = arg1.props.screenSizeX - var5
            end
            containerSize = var3 + UDim2.new(0, entrySizeX, 0, 0)
        end

        local huge = if Players.MaxPlayers >= 6 and Players.MaxPlayers <= 12 then Players.MaxPlayers * 26 + getTeamCount(arg1.props.teams, arg1.props.players) * 20 else math.huge

        local zero = Vector2.zero
        if FFlagPlayerListFixPlatformLeaderboardSizing and arg1.props.hasPlatformLeaderboard then
            zero = Vector2.new(
                math.min(Constants.PLATFORM_PANEL_WIDTH, containerSize.X.Offset),
                Constants.LEGACY_PLATFORM_PANEL_MIN_HEIGHT
            )
            huge = math.max(huge, zero.Y)
        end

        local tbl2 = ({})

        if arg2.IsTenFoot then
            for _, player in ipairs(arg1.props.players) do
                if player ~= Players.LocalPlayer then
                    continue
                end

                tbl2.TitlePlayerEntry = Roact.createElement("Frame", {
                    Position = UDim2.fromOffset(0, 0),
                    Size = UDim2.new(1, arg2.EntryXOffset, 0, arg2.PlayerEntrySizeY),
                    BackgroundTransparency = 1
                }, {
                    PlayerEntry = Roact.createElement(PlayerEntryContainer, {
                        entrySizeX = entrySizeX,
                        titlePlayerEntry = true,
                        player = player,
                        playerIconInfo = arg1.props.playerIconInfo[player.UserId],
                        playerRelationship = arg1.props.playerRelationship[player.UserId]
                    })
                })
                break
            end
        end

        tbl2.PlayerScrollList = Roact.createElement(PlayerListDisplayContainer, {
            screenSizeY = arg1.props.screenSizeY,
            entrySize = entrySizeX,
            isVisible = if FFlagAddNewPlayerListFocusNav then arg1.state.visible else nil
        })
        tbl2.EventConnections = Roact.createElement(EventConnections)
        tbl2.ContextActionsBindings = Roact.createElement(ContextActionsBinder)
        if not FFlagPlayerListRemoveTopStat then
            tbl2.TopStatConnector = Roact.createElement(TopStatConnector)
        end

        if arg1.props.displayOptions.isTenFootInterface then
            tbl2.TenFootSideBar = Roact.createElement(TenFootSideBar)
        end

        return Roact.createElement("Frame", {
            Position = var2,
            AnchorPoint = anchorPoint,
            Size = containerSize,
            BackgroundTransparency = 1,
            Visible = arg1.state.visible,
            ZIndex = if arg2.IsTenFoot then 2 else 1,
            AutoLocalize = false,
            [Roact.Ref] = arg1.rootRef
        }, {
            OffsetFrame = Roact.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 1, 0),
                    Position = arg1.positionOffset,
                    BackgroundTransparency = 1
                },
                tbl2
            ),
            UISizeConstraint = Roact.createElement("UISizeConstraint", { MinSize = zero, MaxSize = Vector2.new(math.huge, huge) }) or nil
        })
    end)
end

function var1.didMount(arg1)
    arg1:setState({ visible = arg1.props.displayOptions.isVisible })
end

function var1.didUpdate(arg1, arg2, _)
    if arg1.props.displayOptions.isVisible == arg2.displayOptions.isVisible then
        return
    end

    if arg1.props.displayOptions.isTenFootInterface then
        arg1:setState({ visible = arg1.props.displayOptions.isVisible })
        return
    end

    if not arg1.props.displayOptions.isVisible then
        arg1.positionMotor:setGoal(Otter.spring(1.1, tbl1))
        return
    end

    arg1:setState({ visible = true })

    arg1.positionMotor:setGoal(Otter.instant(0.2))
    arg1.positionMotor:step(0)
    arg1.positionMotor:setGoal(Otter.spring(0, tbl1))
end

function var1.willUnmount(arg1)
    arg1.positionMotor:destroy()
    arg1.positionMotor = nil

    if arg1.disposeUiScaleEffect then
        arg1.disposeUiScaleEffect()
    end
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        screenSizeX = arg1.screenSize.X,
        screenSizeY = arg1.screenSize.Y,
        displayOptions = arg1.displayOptions,
        players = arg1.players,
        playerStats = arg1.playerStats,
        playerIconInfo = arg1.playerIconInfo,
        playerRelationship = arg1.playerRelationship,
        gameStats = arg1.gameStats,
        teams = arg1.teams
    }
end, nil)(function(arg1) -- name: PlayerListAppWithLeaderboardStore
    local var2 = useLeaderboardStore()

    local computed = Signals.createComputed(function(arg2)
        if var2 then
            return (var2.getGameStatsList().getCount(arg2))
        end

        return #arg1.gameStats
    end)
    local gameStatsCount = SignalsReact.useSignalState(computed)
    local var4

    if FFlagPlayerListFixPlatformLeaderboardSizing and FFlagPlayerListTwoTabsOnLegacy then
        local var5 = usePlatformLeaderboard()
        local var6 = if var5 then var5.getHasActiveLeaderboard else signal
        var4 = SignalsReact.useSignalState(var6)
    else
        var4 = false
    end

    return Roact.createElement(
        var1,
        Cryo.Dictionary.join(arg1, { gameStatsCount = gameStatsCount, hasPlatformLeaderboard = var4 })
    )
end)
