-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Roact = require(AppChatParent.Roact)
local RoactNavigation = require(AppChatParent.RoactNavigation)
local EnumScreens = require(AppChat.EnumScreens)
local SharedFlags = require(AppChatParent.SharedFlags)
local AppNavBar = require(AppChatParent.AppNavBar)

local memoize = require(AppChatParent.AppCommonLib).memoize

local ChatDetails = AppChat.Components.ChatDetails
local GenericDialogType = require(ChatDetails.Dialogs.GenericDialogType)
local EditChatGroupNameDialogScreen = require(ChatDetails.EditChatGroupNameDialog.EditChatGroupNameDialogScreen)
local LeaveGroupDialogScreen = require(ChatDetails.LeaveGroupDialog.LeaveGroupDialogScreen)
local ParticipantDialogScreenDeprecated = require(ChatDetails.ParticipantDialog.ParticipantDialogScreenDeprecated)
local RemoveUserDialogScreen = require(ChatDetails.RemoveUserDialog.RemoveUserDialogScreen)
local AbuseReportScreen = require(AppChat.Components.ChatAbuseReport.AbuseReportScreen)

local MessageContextMenuScreen = require(AppChat.Components.ChatConversation.MessageInteraction.MessageContextMenuScreen)
local SquadVoiceChangerOverlay = require(AppChatParent.Squads.SquadVoiceChangerOverlay)
local ChatLandingTelemetryLayer = require(AppChat.Telemetry.Layers.ChatLandingTelemetryLayer)
local ChatLandingTelemetryState = require(AppChat.Contexts.TelemetryState.ChatLandingTelemetryState)
local ChatConversationTelemetryLayer = require(AppChat.Telemetry.Layers.ChatConversationTelemetryLayer)
local ChatConversationTelemetryState = require(AppChat.Contexts.TelemetryState.ChatConversationTelemetryState)
local useGetAndSetRef = require(AppChat.Hooks.useGetAndSetRef)
local TrustedFriendsUpsellScreen = require(AppChat.Components.TrustedFriendsUpsell.TrustedFriendsUpsellScreen)
local GroupOSADialogScreen = require(AppChat.Components.OSA.GroupOSADialogScreen)

local ChatConversation = AppChat.Components.ChatConversation

local CreateUnfilteredChatPartialModalScreen = require(ChatConversation.PartialModal.CreateUnfilteredChatPartialModalScreen)
local LearnMorePartialModalScreen = require(ChatConversation.PartialModal.LearnMorePartialModalScreen)
local ConversationOverlayScreen = require(ChatConversation.PartialModal.ConversationOverlayScreen)
local makeDialogScreenTelemetryWrapper = require(AppChat.Navigators.makeDialogScreenTelemetryWrapper)

local configureTopBarWithNavigationOptions = require(AppChat.configureTopBarWithNavigationOptions)
local getChatLandingStackNavigator = require(script.Parent.getChatLandingStackNavigator)

local SquadVoiceAbuseReportScreen = require(AppChatParent.Squads.SquadVoiceAbuseReportScreen)
local SystemMenuTopBar = require(AppChat.Components.TopBar.SystemMenuTopBar)
local ChatConversationTopBar = require(AppChat.Components.TopBar.ChatConversationTopBar)
local ChatLandingTopBar = require(AppChat.Components.TopBar.ChatLandingTopBar)
local ChatTopBarBase = require(AppChat.Components.TopBar.ChatTopBarBase)
local SquadAddFriendsIconButton = require(AppChat.Components.Squads.SquadAddFriendsIconButton)
local Provider = require(AppChat.Contexts.ChatPagePadding.Provider)
local ChatDetailsTelemetryLayer = require(AppChat.Telemetry.Layers.ChatDetailsTelemetryLayer)
local ChatDetailsTelemetryState = require(AppChat.Contexts.TelemetryState.ChatDetailsTelemetryState)
local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)
local BlockingModal = require(AppChatParent.SocialBlockingModal).BlockingModal

local GetFFlagEnableCrossExpVoice = SharedFlags.GetFFlagEnableCrossExpVoice
local GetFFlagIsSquadEnabled = SharedFlags.GetFFlagIsSquadEnabled
local FFlagAppIaScrollAway = SharedFlags.FFlagAppIaScrollAway
local FFlagAppIaScrollAwayFixSocial = SharedFlags.FFlagAppIaScrollAwayFixSocial
local FFlagEnablePartyVoiceChangersInLua = SharedFlags.FFlagEnablePartyVoiceChangersInLua
local FFlagAppChatDisableAbsorbInputSelectable = require(AppChat.Flags.FFlagAppChatDisableAbsorbInputSelectable)
local FFlagAppChatConsoleFocusFixes = require(AppChat.Flags.FFlagAppChatConsoleFocusFixes)

local UserGameSettings = UserSettings():GetService("UserGameSettings")

local function AppChatNavigatorTelemetryProviders(tbl1)
    local get, set = useGetAndSetRef({})
    local value = React.useCallback(function()
        local var3 = get()
        return {
            chatLandingListCount = var3.chatLandingListCount,
            pendingConversationCount = var3.pendingConversationCount,
            unfilteredConversationCount = var3.unfilteredConversationCount,
            searchSessionId = var3.searchSessionId,
            activeFilters = var3.activeFilters
        }
    end, { get })

    local var1, var2 = useGetAndSetRef({})
    local var3 = React.useCallback(function()
        local var6 = var1()
        return {
            conversationId = var6.conversationId,
            moderationType = var6.moderationType,
            userPendingStatus = var6.userPendingStatus
        }
    end, { var1 })

    local _children = tbl1.children

    local var4, var5 = useGetAndSetRef({})
    local var6 = React.useCallback(function()
        local var9 = var4()
        return {
            participantsCount = var9.participantsCount,
            isGroupOwner = var9.isGroupOwner
        }
    end, { var4, var1 })
    local var7 = React.useMemo(function()
        return { get = var4, set = var5 }
    end, { var4, var5 })
    local var8 = React.useMemo(function()
        return { get = get, set = set }
    end, { get, set })
    local var9 = React.useMemo(function()
        return { get = var1, set = var2 }
    end, { var1, var2 })

    local element = React.createElement(
        ChatDetailsTelemetryState.Provider,
        { value = var7 },
        React.createElement(ChatDetailsTelemetryLayer.Provider, { value = var6 }, tbl1.children)
    )

    return React.createElement(ChatLandingTelemetryState.Provider, { value = var8 }, { React.createElement(
            ChatLandingTelemetryLayer.Provider,
            { value = value },
            { React.createElement(
                    ChatConversationTelemetryState.Provider,
                    { value = var9 },
                    { React.createElement(ChatConversationTelemetryLayer.Provider, { value = var3 }, element) }
                ) }
        ) })
end

local var1 = Roact.Component:extend("ChatLandingStackNavigatorConnector")
var1.router = getChatLandingStackNavigator(UserGameSettings.ReducedMotion).router

function var1.init(arg1)
    arg1.state = {
        shouldReduceMotion = UserGameSettings.ReducedMotion
    }

    arg1.getNavigator = memoize(function(arg2)
        local chatLandingStackNavigator = getChatLandingStackNavigator(arg2)

        var1.router = chatLandingStackNavigator.router
        return chatLandingStackNavigator
    end)

    function arg1.updateSettings()
        arg1:setState({ shouldReduceMotion = UserGameSettings.ReducedMotion })
    end

    arg1.reducedMotionConnection = UserGameSettings:GetPropertyChangedSignal("ReducedMotion"):Connect(arg1.updateSettings)
end

function var1.willUnmount(arg1)
    if arg1.reducedMotionConnection then
        arg1.reducedMotionConnection:Disconnect()
    end
end

local function getActiveRouteName(navigation) -- Luacid: Inlined by compiler; 1 call site recovered
    local state = navigation and navigation.state
    if not (state and state.routes and state.index) then
        return nil
    end
    local var2 = state.routes[state.index]
    if not var2 then
        return nil
    end

    if not (var2.routes and var2.index) then
        return var2.routeName
    end

    local var3 = var2.routes[var2.index]
    return var3 and var3.routeName or var2.routeName
end

function var1.render(arg1)
    local screenProps = if FFlagAppIaScrollAway then arg1.props.navigation.getScreenProps("isInExperience", false) else nil
    local scrollAwayEnabled = FFlagAppIaScrollAway and not screenProps and AppNavBar.getScrollAwayEnabled()
    if FFlagAppIaScrollAwayFixSocial then
        local activeChildNavigationOptions = RoactNavigation.getActiveChildNavigationOptions(arg1.props.navigation)

        scrollAwayEnabled = scrollAwayEnabled and activeChildNavigationOptions.tabBarVisible
    end
    local element = nil
    if FFlagAppChatPerfTracking then
        AppChatPerfTracker.start(AppChatPerfTracker.Events.TopBarRenderInterval)
    end
    local screenName = getActiveRouteName(arg1.props.navigation)
    if screenName == EnumScreens.CreateNewChat or screenName == EnumScreens.EditChatMembers then
        element = Roact.createElement(SystemMenuTopBar, { screenName = screenName, navigation = arg1.props.navigation })
    elseif screenName == EnumScreens.ChatConversation then
        element = Roact.createElement(
            ChatConversationTopBar,
            {
                screenName = EnumScreens.ChatConversation,
                navigation = arg1.props.navigation
            }
        )
    elseif screenName == EnumScreens.ChatLanding then
        element = Roact.createElement(ChatLandingTopBar, { screenName = EnumScreens.ChatLanding, navigation = arg1.props.navigation })
    elseif screenName == EnumScreens.ChatDetails then
        element = Roact.createElement(ChatTopBarBase, { screenName = EnumScreens.ChatDetails, navigation = arg1.props.navigation })
    elseif screenName == EnumScreens.SquadLobby then
        element = Roact.createElement(ChatTopBarBase, {
            screenName = EnumScreens.SquadLobby,
            navigation = arg1.props.navigation,
            renderRight = function()
                return React.createElement(SquadAddFriendsIconButton, { navigation = arg1.props.navigation })
            end
        })
    elseif screenName == EnumScreens.SquadInviteFriends then
        element = Roact.createElement(ChatTopBarBase, { screenName = EnumScreens.SquadInviteFriends, navigation = arg1.props.navigation })
    elseif screenName == EnumScreens.QuickStartSquadInviteFriends then
        element = Roact.createElement(
            ChatTopBarBase,
            {
                screenName = EnumScreens.QuickStartSquadInviteFriends,
                navigation = arg1.props.navigation
            }
        )
    end

    local topBar = element or configureTopBarWithNavigationOptions(arg1.props.navigation)

    local createElement = Roact.createElement
    local func1 = AppChatNavigatorTelemetryProviders
    local tbl1 = {}
    local tbl2 = {
        layout = if FFlagAppIaScrollAway and scrollAwayEnabled then nil else Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
        topBar = topBar,
        content = 0
    }
    local createElement2 = Roact.createElement
    local var3 = Provider
    local tbl3 = {
        value = {
            left = arg1.props.navigation.getScreenProps("appChatOuterPadding", 12),
            right = arg1.props.navigation.getScreenProps("appChatOuterPadding", 12)
        }
    }
    local tbl4 = {
        navigatorFrame = Roact.createElement(
            "Frame",
            {
                Size = if FFlagAppIaScrollAway and scrollAwayEnabled then UDim2.fromScale(1, 1) else UDim2.new(1, 0, 1, -arg1.props.navigation.getScreenProps("topBarHeight", 0)),
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            },
            {
                navigator = Roact.createElement(arg1.getNavigator(arg1.state.shouldReduceMotion), arg1.props)
            }
        )
    }
    tbl2.content = createElement2(var3, tbl3, tbl4)
    local chatLandingStackNavigator = createElement(func1, tbl1, tbl2)

    return Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = not FFlagAppChatConsoleFocusFixes or nil
    }, { ChatLandingStackNavigator = chatLandingStackNavigator })
end

local tbl1 = {
    {
        [EnumScreens.ChatLandingStack] = var1
    },
    {
        [GenericDialogType.EditChatGroupNameDialog] = {
            screen = EditChatGroupNameDialogScreen,
            navigationOptions = { backButtonEnabled = true, overlayEnabled = true }
        }
    },
    {
        [GenericDialogType.LeaveGroupDialog] = {
            screen = makeDialogScreenTelemetryWrapper(LeaveGroupDialogScreen),
            navigationOptions = { backButtonEnabled = true, overlayEnabled = true }
        }
    },
    {
        [GenericDialogType.ParticipantDialog] = {
            screen = makeDialogScreenTelemetryWrapper(ParticipantDialogScreenDeprecated),
            navigationOptions = { backButtonEnabled = true, overlayEnabled = true }
        }
    },
    {
        [GenericDialogType.RemoveUserDialog] = {
            screen = RemoveUserDialogScreen,
            navigationOptions = { backButtonEnabled = true, overlayEnabled = true }
        }
    },
    {
        [EnumScreens.CreateUnfilteredChatPartialModal] = {
            screen = CreateUnfilteredChatPartialModalScreen,
            navigationOptions = { backButtonEnabled = true, overlayEnabled = true }
        }
    },
    {
        [EnumScreens.LearnMorePartialModal] = {
            screen = LearnMorePartialModalScreen,
            navigationOptions = { backButtonEnabled = true, overlayEnabled = true }
        }
    }
}

table.insert(tbl1, {
    [EnumScreens.AppChatReportAbuse] = {
        screen = AbuseReportScreen,
        navigationOptions = { backButtonEnabled = true, overlayEnabled = true }
    }
})

table.insert(tbl1, {
    [EnumScreens.BlockingModal] = {
        screen = BlockingModal,
        navigationOptions = { backButtonEnabled = true, overlayEnabled = true }
    }
})

table.insert(tbl1, {
    [EnumScreens.MessageContextMenu] = {
        screen = MessageContextMenuScreen,
        navigationOptions = { backButtonEnabled = true, overlayEnabled = true }
    }
})

if GetFFlagIsSquadEnabled() and GetFFlagEnableCrossExpVoice() then
    table.insert(tbl1, {
        [EnumScreens.SquadVoiceReportAbuse] = {
            screen = SquadVoiceAbuseReportScreen,
            navigationOptions = { backButtonEnabled = true, overlayEnabled = true }
        }
    })
end

table.insert(tbl1, {
    [EnumScreens.ConversationOverlay] = {
        screen = ConversationOverlayScreen,
        navigationOptions = {
            transparent = true,
            overlayTransparency = 0.5,
            backButtonEnabled = true,
            overlayEnabled = true
        }
    }
})

table.insert(tbl1, {
    [EnumScreens.TrustedConnectionsUpsell] = {
        screen = TrustedFriendsUpsellScreen,
        navigationOptions = {
            transparent = true,
            overlayTransparency = 0.5,
            backButtonEnabled = true,
            overlayEnabled = true
        }
    }
})

table.insert(tbl1, {
    [EnumScreens.GroupOSADialog] = {
        screen = GroupOSADialogScreen,
        navigationOptions = {
            transparent = true,
            overlayTransparency = 0.5,
            backButtonEnabled = true,
            overlayEnabled = true
        }
    }
})

if FFlagEnablePartyVoiceChangersInLua then
    table.insert(tbl1, {
        [EnumScreens.SquadVoiceChangers] = {
            screen = SquadVoiceChangerOverlay,
            navigationOptions = { overlayEnabled = true, overlayTransparency = 0.5 }
        }
    })
end

return RoactNavigation.createRobloxStackNavigator(tbl1, {
    defaultNavigationOptions = FFlagAppChatDisableAbsorbInputSelectable and {
        absorbInputSelectable = false
    } or nil,
    mode = RoactNavigation.StackPresentationStyle.Overlay
})
