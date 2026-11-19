-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox
local Cryo = InGameMenuDependencies.Cryo
local RoactRodux = InGameMenuDependencies.RoactRodux
local t = InGameMenuDependencies.t

local Foundation = require(CorePackages.Packages.Foundation)
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation
local var1 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.UNSTABLE.withCursorMigration else UIBlox.App.SelectionImage.withSelectionCursorProvider
local var2 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.Enums.CursorType else UIBlox.App.SelectionImage.CursorKind
local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle
local Images = UIBlox.App.ImageSet.Images

local scriptParentParentParent = script.Parent.Parent.Parent

local withLocalization = require(scriptParentParentParent.Localization.withLocalization)

local Flags = scriptParentParentParent.Flags
local GetFFlagIGMGamepadSelectionHistory = require(Flags.GetFFlagIGMGamepadSelectionHistory)
local FocusHandler = require(script.Parent.Parent.Connection.FocusHandler)
local VoiceIndicator = require(RobloxGui.Modules.VoiceChat.Components.VoiceIndicator)
local Constants = require(RobloxGui.Modules.VoiceChat.Constants)

local PlayerLabelV2 = require(scriptParentParentParent.Components.PlayerLabelV2)
local PlayerContextualMenu = require(scriptParentParentParent.Components.PlayerContextualMenu)

local FFlagLuaMenuPerfImprovements = require(scriptParentParentParent.Flags.FFlagLuaMenuPerfImprovements)

local PageNavigationWatcher = require(scriptParentParentParent.Components.PageNavigationWatcher)
local Divider = require(scriptParentParentParent.Components.Divider)

local BarOnTopScrollingFrame = require(scriptParentParentParent.Components.BarOnTopScrollingFrame)
local Page = require(scriptParentParentParent.Components.Page)

local CloseMenu = require(scriptParentParentParent.Thunks.CloseMenu)

local Assets = require(scriptParentParentParent.Resources.Assets)

local Constants2 = require(scriptParentParentParent.Resources.Constants)
local SendAnalytics = require(scriptParentParentParent.Utility.SendAnalytics)

local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default
local BlockingUtility = require(CorePackages.Workspace.Packages.BlockingUtility)
local UnblockPlayer = require(RobloxGui.Modules.PlayerList.Thunks.UnblockPlayer)
local TrustAndSafety = require(RobloxGui.Modules.TrustAndSafety)
local onBlockButtonActivated = require(RobloxGui.Modules.Settings.onBlockButtonActivated)

local var3 = require(CorePackages.Workspace.Packages.CoreScriptsInitializer).CoreLogger:new(script.Name)

local var4 = settings():GetFVariable("InGameGlobalGuiInset") + 24

local var5 = Roact.PureComponent:extend("PlayersPage")

var5.validateProps = t.strictInterface({
    isMenuOpen = t.boolean,
    voiceEnabled = t.optional(t.boolean),
    inspectMenuEnabled = t.boolean,
    friends = t.map(t.integer, t.enum(Enum.FriendStatus)),
    closeMenu = t.callback,
    unblockPlayer = t.callback,
    pageTitle = t.string,
    screenSize = t.Vector2,
    currentPage = t.optional(t.string),
    isRespawnDialogOpen = t.optional(t.boolean),
    isReportDialogOpen = t.optional(t.boolean),
    isGamepadLastInput = t.optional(t.boolean),
    isCurrentZoneActive = t.optional(t.boolean)
})

function var5.init(arg1)
    arg1:setState({
        players = Players:GetPlayers(),
        selectedPlayer = nil,
        selectedPlayerPosition = Vector2.new(0, 0),
        pageSizeY = 0,
        voiceChatEnabled = false,
        allMuted = false,
        selectedPlayerRef = nil,
        firstPlayerRef = nil
    })

    function arg1.setSelectedPlayerRef(selectedPlayerRef)
        if GetFFlagIGMGamepadSelectionHistory() then
            arg1:setState({ selectedPlayerRef = selectedPlayerRef })
            return
        end

        arg1:setState({ selectedPlayerRef = selectedPlayerRef, firstPlayerRef = Roact.None })
    end

    function arg1.setFirstPlayerRef(firstPlayerRef)
        arg1:setState({ firstPlayerRef = firstPlayerRef })
    end

    if not FFlagLuaMenuPerfImprovements then
        return
    end

    function arg1.positionChanged(arg2)
        arg1:setState({ selectedPlayerPosition = arg2.AbsolutePosition })
    end

    function arg1.toggleMoreActions(userId: number | User)
        local player = Players:GetPlayerByUserId(userId)
        if arg1.state.selectedPlayer == player then
            arg1:setState({ selectedPlayer = Roact.None })
            return
        end

        arg1:setState({ selectedPlayer = player })
    end
end

local function sortPlayers(arg1, arg2): boolean
    return arg1.Name:lower() < arg2.Name:lower()
end

function var5.renderListEntries(arg1, arg2)
    local var6 = Cryo.List.sort(arg2, sortPlayers)

    local num1 = 0
    local tbl1 = {
        ListLayout = Roact.createElement(
            "UIListLayout",
            {
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Right
            }
        )
    }

    for k, selectedPlayer in pairs(var6) do
        local var7 = if FFlagLuaMenuPerfImprovements then selectedPlayer.UserId or k else k

        local var8 = not FFlagLuaMenuPerfImprovements and function(arg3)
            arg1:setState({ selectedPlayerPosition = arg3.AbsolutePosition })
        end or arg1.positionChanged or function(arg3)
            arg1:setState({ selectedPlayerPosition = arg3.AbsolutePosition })
        end

        local var9 = FFlagLuaMenuPerfImprovements and arg1.toggleMoreActions or function()
            if arg1.state.selectedPlayer == selectedPlayer then
                arg1:setState({ selectedPlayer = Roact.None })
                return
            end

            arg1:setState({ selectedPlayer = selectedPlayer })
        end

        local var10 = nil
        if k == 1 and not arg1.state.selectedPlayer then
            var10 = arg1.setFirstPlayerRef
        elseif arg1.state.selectedPlayer == selectedPlayer then
            var10 = arg1.setSelectedPlayerRef
        end

        local iconStyle = if selectedPlayer == Players.LocalPlayer then "MicLight" else "SpeakerLight"

        local var11 = "player_" .. var7
        local createElement = Roact.createElement
        local var12 = PlayerLabelV2
        local tbl2 = {
            username = selectedPlayer.Name,
            displayName = selectedPlayer.DisplayName,
            userId = selectedPlayer.UserId,
            isOnline = true,
            isSelected = arg1.state.selectedPlayer == selectedPlayer,
            LayoutOrder = num1,
            onActivated = var9,
            [Roact.Change.AbsolutePosition] = arg1.state.selectedPlayer == selectedPlayer and var8 or nil,
            [Roact.Ref] = var10
        }
        local tbl3 = { Icon = 0 }
        local voiceEnabled = arg1.props.voiceEnabled

        if voiceEnabled then
            if selectedPlayer == Players.LocalPlayer then
                voiceEnabled = false
            else
                voiceEnabled = Roact.createElement(
                    VoiceIndicator,
                    {
                        userId = tostring(selectedPlayer.UserId),
                        hideOnError = true,
                        iconStyle = iconStyle,
                        onClicked = var9
                    }
                )
            end
        end

        tbl3.Icon = voiceEnabled
        tbl1[var11] = createElement(var12, tbl2, tbl3)

        num1 += 1

        if not (k < #var6) then
            continue
        end

        local var13 = "divider_" .. var7
        tbl1[var13] = Roact.createElement(Divider, { LayoutOrder = num1, Size = UDim2.new(1, -104, 0, 1) })

        num1 += 1
    end

    return tbl1
end

function var5.getMoreActions(arg1, arg2)
    local moreActions = {}

    if arg1.state.selectedPlayer ~= nil then
        if arg1.state.selectedPlayer ~= Players.LocalPlayer then
            local unknown = Enum.FriendStatus.Unknown
            if arg1.props.friends[arg1.state.selectedPlayer.UserId] then
                unknown = arg1.props.friends[arg1.state.selectedPlayer.UserId]
            end

            local addFriend = arg2.addFriend
            local iconsActionsFriendsFriendAdd = Images["icons/actions/friends/friendAdd"]
            local friend = Enum.FriendStatus.Friend

            if unknown == friend then
                addFriend = arg2.unfriend
                iconsActionsFriendsFriendAdd = Images["icons/actions/friends/friendRemove"]
            else
                local friendRequestSent = Enum.FriendStatus.FriendRequestSent

                if unknown == friendRequestSent then
                    addFriend = arg2.cancelFriend
                    iconsActionsFriendsFriendAdd = Images["icons/actions/friends/friendRemove"]
                else
                    local friendRequestReceived = Enum.FriendStatus.FriendRequestReceived

                    if unknown == friendRequestReceived then
                        addFriend = arg2.acceptFriend
                    end
                end
            end

            table.insert(moreActions, {
                text = addFriend,
                icon = iconsActionsFriendsFriendAdd,
                onActivated = function()
                    local selectedPlayer = arg1.state.selectedPlayer

                    if unknown == Enum.FriendStatus.Friend or unknown == Enum.FriendStatus.FriendRequestSent then
                        Players.LocalPlayer:RevokeFriendship(selectedPlayer)
                    else
                        Players.LocalPlayer:RequestFriendship(selectedPlayer)
                        RbxAnalyticsService:ReportCounter("PlayersMenu-RequestFriendship")
                        SendAnalytics(Constants2.AnalyticsMenuActionName, Constants2.AnalyticsRequestFriendName, {})
                    end
                    arg1:setState({ selectedPlayer = Roact.None })
                end
            })
        end

        table.insert(moreActions, {
            text = arg2.viewAvatar,
            icon = Assets.Images.ViewAvatar,
            onActivated = function()
                GuiService:InspectPlayerFromUserIdWithCtx(arg1.state.selectedPlayer.UserId, "escapeMenu")
                arg1:setState({ selectedPlayer = Roact.None })

                arg1.props.closeMenu()
                SendAnalytics(Constants2.AnalyticsMenuActionName, Constants2.AnalyticsExamineAvatarName, {})
            end
        })

        if arg1.state.selectedPlayer ~= Players.LocalPlayer then
            table.insert(moreActions, {
                text = arg2.reportAbuse,
                icon = Images["icons/actions/feedback"],
                onActivated = function()
                    local selectedPlayer = arg1.state.selectedPlayer
                    TrustAndSafety.openReportDialogForPlayer(selectedPlayer, Constants2.AnalyticsMenuActionName)
                    arg1:setState({ selectedPlayer = Roact.None })
                end
            })

            if arg1.props.voiceEnabled then
                local participant = default.participants[tostring(arg1.state.selectedPlayer.UserId)]
                if participant then
                    local isMutedLocally = participant.isMutedLocally
                    table.insert(moreActions, {
                        text = if isMutedLocally then "Unmute Player" else "Mute Player",
                        icon = default:GetIcon(if isMutedLocally then "Unmute" else "Mute", "Misc"),
                        onActivated = function()
                            local selectedPlayer = arg1.state.selectedPlayer
                            var3:debug("Muting Player {}", selectedPlayer.UserId)
                            default:ToggleMutePlayer(selectedPlayer.UserId, Constants.VOICE_CONTEXT_TYPE.IN_GAME_MENU)

                            arg1:setState({ selectedPlayer = Roact.None })
                        end
                    })
                end
            end

            local selectedPlayer = arg1.state.selectedPlayer
            local isPlayerBlockedByUserId = BlockingUtility:IsPlayerBlockedByUserId(selectedPlayer.UserId)
            table.insert(moreActions, {
                text = isPlayerBlockedByUserId and arg2.unblockPlayer or arg2.blockPlayer,
                icon = Images["icons/actions/block"],
                onActivated = function()
                    if isPlayerBlockedByUserId then
                        arg1.props.unblockPlayer(selectedPlayer)
                    else
                        onBlockButtonActivated(selectedPlayer, nil, arg1.__componentName)
                    end

                    arg1:setState({ selectedPlayer = Roact.None })
                end
            })
        end
    end

    return moreActions
end

function var5.renderFocusHandler(arg1, arg2)
    local shouldForgetPreviousSelection = if GetFFlagIGMGamepadSelectionHistory() then arg1.props.currentPage == Constants2.MainPagePageKey or not arg1.props.isCurrentZoneActive else nil
    local createElement = Roact.createElement
    local var6 = FocusHandler
    local tbl1 = { isFocused = 0, shouldForgetPreviousSelection = 0, didFocus = 0 }
    if arg2 then
        if arg1.props.currentPage == "Players" then
            arg2 = arg1.props.isMenuOpen
                and not arg1.props.isReportDialogOpen
                and not arg1.state.selectedPlayer
                and (arg1.state.selectedPlayerRef or arg1.state.firstPlayerRef) ~= nil
        else
            arg2 = false
        end
    end

    tbl1.isFocused = arg2

    tbl1.shouldForgetPreviousSelection = shouldForgetPreviousSelection
    tbl1.didFocus = GetFFlagIGMGamepadSelectionHistory() and function(selectedCoreObject)
        GuiService.SelectedCoreObject = selectedCoreObject or arg1.state.firstPlayerRef
    end or function()
        GuiService.SelectedCoreObject = arg1.state.selectedPlayerRef or arg1.state.firstPlayerRef
    end

    return createElement(var6, tbl1)
end

function var5.renderWithLocalizedAndSelectionCursor(arg1, arg2, arg3)
    local moreActions, var6, selectedPlayerPositionY

    if arg1.state.selectedPlayer == nil then
        moreActions = {}
        var6 = 0
        selectedPlayerPositionY = 0
    else
        moreActions = arg1:getMoreActions(arg2)
        local num1 = #moreActions * 56
        local screenSizeX = arg1.props.screenSize.X
        local screenSizeY = arg1.props.screenSize.Y

        if arg1.state.selectedPlayerPosition.Y + num1 + var4 < screenSizeY then
            selectedPlayerPositionY = arg1.state.selectedPlayerPosition.Y
        else
            selectedPlayerPositionY = screenSizeY - num1 - var4
        end

        if arg1.state.selectedPlayerPosition.X + 400 + 20 + 352 + 24 <= screenSizeX then
            var6 = arg1.state.selectedPlayerPosition.X + 400 + 20
        else
            var6 = screenSizeX - 352 - 24
        end
    end

    local isCurrentZoneActive = arg1.props.isGamepadLastInput and not arg1.props.isRespawnDialogOpen and arg1.props.isCurrentZoneActive

    local moreActionsMenu = if arg1.state.selectedPlayer then Roact.createElement(PlayerContextualMenu, {
        moreActions = moreActions,
        actionWidth = 352,
        xOffset = var6,
        yOffset = selectedPlayerPositionY,
        canCaptureFocus = isCurrentZoneActive,
        onClose = function()
            arg1:setState({ selectedPlayer = Roact.None })
        end
    })
        or nil else nil

    local createElement = Roact.createElement
    local var7 = Page
    local tbl1 = {
        pageTitle = arg1.props.pageTitle,
        titleChildren = 0
    }
    local voiceEnabled = arg1.props.voiceEnabled

    if voiceEnabled then
        local createElement2 = Roact.createElement
        local tbl2 = {
            Size = UDim2.fromOffset(36, 36),
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(1, 0.5),
            BorderSizePixel = 0,
            Position = UDim2.new(1, 4, 0.5, 0),
            Image = default:GetIcon(if arg1.state.allMuted then "UnmuteAll" else "MuteAll", "Misc")
        }

        tbl2[Roact.Event.Activated] = function()
            default:MuteAll(not arg1.state.allMuted, Constants.VOICE_CONTEXT_TYPE.IN_GAME_MENU)
            arg1:setState({ allMuted = not arg1.state.allMuted })
        end

        tbl2.SelectionImageObject = arg3(var2.RoundedRect)
        voiceEnabled = createElement2("ImageButton", tbl2)
    end

    tbl1.titleChildren = voiceEnabled

    return createElement(var7, tbl1, {
        PlayerListContent = withFoundationOrUIBloxStyle(function(_)
            return {}
        end, function(_)
            local createElement2 = Roact.createElement
            local tbl2 = {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0)
            }
            tbl2[Roact.Change.AbsoluteSize] = function(arg4)
                arg1:setState({ pageSizeY = arg4.AbsoluteSize.Y })
            end

            return createElement2("Frame", tbl2, {
                PlayerList = Roact.createElement(BarOnTopScrollingFrame, {
                    Position = UDim2.new(0, 0, 0, 0),
                    Size = UDim2.new(1, 0, 1, 0),
                    CanvasSize = UDim2.new(1, 0, 0, #arg1.state.players * 72),
                    ScrollingEnabled = arg1.state.selectedPlayer == nil
                }, arg1:renderListEntries(arg1.state.players)),
                MoreActionsMenu = moreActionsMenu
            })
        end),
        FocusHandler = arg1:renderFocusHandler(isCurrentZoneActive),
        Watcher = Roact.createElement(PageNavigationWatcher, {
            desiredPage = "Players",
            onNavigateTo = function()
                arg1:setState({ players = Players:GetPlayers() })
            end,
            onNavigateAway = function()
                arg1:setState({ selectedPlayer = Roact.None })
            end
        })
    })
end

function var5.renderWithLocalized(arg1, arg2)
    return var1(function(arg3)
        return arg1:renderWithLocalizedAndSelectionCursor(arg2, arg3)
    end)
end

function var5.render(arg1)
    return withLocalization({
        addFriend = "CoreScripts.InGameMenu.Actions.AddFriend",
        acceptFriend = "CoreScripts.InGameMenu.Actions.AcceptFriend",
        unfriend = "CoreScripts.InGameMenu.Actions.Unfriend",
        cancelFriend = "CoreScripts.InGameMenu.Actions.CancelFriend",
        viewAvatar = "CoreScripts.InGameMenu.Actions.ViewAvatar",
        reportAbuse = "CoreScripts.InGameMenu.Actions.ReportAbuse",
        blockPlayer = "CoreScripts.InGameMenu.Actions.BlockPlayer",
        unblockPlayer = "CoreScripts.InGameMenu.Actions.UnblockPlayer"
    })(
        function(arg2)
            return arg1:renderWithLocalized(arg2)
        end
    )
end

function var5.didUpdate(arg1, arg2, _)
    if arg1.props.isMenuOpen and not arg2.isMenuOpen then
        arg1:setState({ players = Players:GetPlayers(), selectedPlayer = Roact.None })
    end

    local selectedPlayerRef = arg1.state.selectedPlayerRef
    if selectedPlayerRef and arg1.state.selectedPlayerPosition ~= selectedPlayerRef.AbsolutePosition then
        arg1:setState({ selectedPlayerPosition = selectedPlayerRef.AbsolutePosition })
    end
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        isMenuOpen = arg1.isMenuOpen,
        voiceEnabled = arg1.voiceState.voiceEnabled,
        friends = arg1.friends,
        inspectMenuEnabled = arg1.displayOptions.inspectMenuEnabled,
        screenSize = arg1.screenSize,
        currentPage = arg1.menuPage,
        isRespawnDialogOpen = arg1.respawn.dialogOpen,
        isReportDialogOpen = arg1.report.dialogOpen or arg1.report.reportSentOpen,
        isGamepadLastInput = arg1.displayOptions.inputType == Constants2.InputType.Gamepad,
        isCurrentZoneActive = arg1.currentZone == 1
    }
end, function(arg1)
    return {
        closeMenu = function()
            arg1(CloseMenu)
        end,
        unblockPlayer = function(arg2)
            return arg1(UnblockPlayer(arg2))
        end
    }
end)(var5)
