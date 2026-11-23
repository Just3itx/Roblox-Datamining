-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local ArgCheck = require(AppChatParent.ArgCheck)
local React = require(AppChatParent.React)
local Roact = require(AppChatParent.Roact)
local UIBlox = require(AppChatParent.UIBlox)
local RoactNavigation = require(AppChatParent.RoactNavigation)
local FocusBehaviors = require(AppChatParent.FocusBehaviors)
local ReactFocusNavigation = require(AppChatParent.ReactFocusNavigation)
local UniversalAppPolicy = require(AppChatParent.UniversalAppPolicy)

local EnumScreens = require(AppChat.EnumScreens)
local ChatLandingTelemetryLayer = require(AppChat.Telemetry.Layers.ChatLandingTelemetryLayer)
local ChatLandingTelemetryState = require(AppChat.Contexts.TelemetryState.ChatLandingTelemetryState)
local ChatConversationTelemetryLayer = require(AppChat.Telemetry.Layers.ChatConversationTelemetryLayer)
local ChatConversationTelemetryState = require(AppChat.Contexts.TelemetryState.ChatConversationTelemetryState)
local ChatDetailsTelemetryLayer = require(AppChat.Telemetry.Layers.ChatDetailsTelemetryLayer)
local ChatDetailsTelemetryState = require(AppChat.Contexts.TelemetryState.ChatDetailsTelemetryState)
local TopBarProvider = require(AppChat.TopBarProvider)

local GetTopBarStore = require(AppChat.Stores.GetTopBarStore)
local FFlagAppChatIxpScreenExposure = require(AppChat.Flags.FFlagAppChatIxpScreenExposure)
local FFlagAppChatIxpParallelScreenLayers = require(AppChat.Flags.FFlagAppChatIxpParallelScreenLayers)

local FStringAppChatLandingConversationRowsIxpLayer = require(AppChat.Flags.FStringAppChatLandingConversationRowsIxpLayer)

local FStringAppChatLandingConversationListIxpLayer = require(AppChat.Flags.FStringAppChatLandingConversationListIxpLayer)
local FStringAppChatLandingPerformanceIxpLayer = require(AppChat.Flags.FStringAppChatLandingPerformanceIxpLayer)
local ChatLandingTopBar = require(AppChat.Components.TopBar.ChatLandingTopBar)
local conversationSwitchNavigator = require(AppChat.Navigators.Wide.conversationSwitchNavigator)
local ConversationStackNavigationFocusListener = require(script.Parent.ConversationStackNavigationFocusListener)

local IXPNavigationUtils = require(AppChat.Utils.IXPNavigationUtils)
local resetForSquadLobbyForWideMode = require(AppChat.Utils.resetForSquadLobbyForWideMode)
local ChatSearchBox = require(script.Parent.ChatSearchBox)
local ChatLandingSearchRow = require(AppChat.Components.TopBar.ChatLandingSearchRow)
local FFlagAppChatWideAlwaysVisibleSearchBox = require(AppChat.Flags.FFlagAppChatWideAlwaysVisibleSearchBox)
local FFlagAppChatFixInExpSearchRowLayoutOrder = require(AppChat.Flags.FFlagAppChatFixInExpSearchRowLayoutOrder)
local ChatLandingContainer = require(script.Parent.ChatLandingContainer)
local Logger = require(script.Parent.Logger)
local getCurrentRoute = require(script.Parent.Utils.getCurrentRoute)
local withStyle = UIBlox.Style.withStyle
local Provider = require(AppChat.Contexts.ChatPagePadding.Provider)
local Context = require(AppChat.Contexts.ChatWideModeFocus.Context)
local useGetAndSetRef = require(AppChat.Hooks.useGetAndSetRef)
local useIsChatSearchAllowed = require(AppChat.Hooks.useIsChatSearchAllowed)

local SharedFlags = require(AppChatParent.SharedFlags)
local GetFFlagEnableAppChatInExperience = SharedFlags.GetFFlagEnableAppChatInExperience
local FFlagAppChatConsoleFocusFixes = require(AppChat.Flags.FFlagAppChatConsoleFocusFixes)
local FFlagAppChatFoundationHeaderBar = require(AppChat.Flags.FFlagAppChatFoundationHeaderBar)

local function LeftContainerTelemetryProviders(tbl1)
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
    local var1 = React.useMemo(function()
        return { get = get, set = set }
    end, { get, set })

    local var5 = if FFlagAppChatWideAlwaysVisibleSearchBox then useIsChatSearchAllowed() else false
    local var6 = if tbl1.renderChildren then tbl1.renderChildren(var5) else tbl1.children
    return React.createElement(
        ChatLandingTelemetryState.Provider,
        { value = var1 },
        { React.createElement(ChatLandingTelemetryLayer.Provider, { value = value }, var6) }
    )
end

local function RightContainerTelemetryProviders(tbl1)
    local get, set = useGetAndSetRef({})
    local value = React.useCallback(function()
        local var3 = get()
        return {
            conversationId = var3.conversationId,
            moderationType = var3.moderationType,
            userPendingStatus = var3.userPendingStatus
        }
    end, { get })

    local _children = tbl1.children

    local var1, var2 = useGetAndSetRef({})
    local var3 = React.useCallback(function()
        local var6 = var1()
        return {
            participantsCount = var6.participantsCount,
            isGroupOwner = var6.isGroupOwner
        }
    end, { var1, get })
    local var4 = React.useMemo(function()
        return { get = var1, set = var2 }
    end, { var1, var2 })
    local var5 = React.useMemo(function()
        return { get = get, set = set }
    end, { get, set })

    local element = React.createElement(
        ChatDetailsTelemetryState.Provider,
        { value = var4 },
        React.createElement(ChatDetailsTelemetryLayer.Provider, { value = var3 }, tbl1.children)
    )

    return React.createElement(
        ChatConversationTelemetryState.Provider,
        { value = var5 },
        { React.createElement(ChatConversationTelemetryLayer.Provider, { value = value }, element) }
    )
end

local FFlagEnablePartyQuickStartButton = require(AppChatParent.SharedFlags).FFlagEnablePartyQuickStartButton

local var1 = Roact.PureComponent:extend("ChatLandingScreenWithSwitchNavigator")
var1.router = conversationSwitchNavigator.router
var1.defaultProps = { navigation = nil }

function var1.init(arg1)
    arg1.ixpSubscription = if FFlagAppChatIxpScreenExposure then IXPNavigationUtils.registerExposureOnFocus(arg1.props.navigation, "Party.LandingPage") else nil

    arg1.conversationRowsIxpSubscription = if FFlagAppChatIxpScreenExposure and FFlagAppChatIxpParallelScreenLayers then IXPNavigationUtils.registerExposureOnFocus(arg1.props.navigation, FStringAppChatLandingConversationRowsIxpLayer) else nil

    arg1.conversationListIxpSubscription = if FFlagAppChatIxpScreenExposure and FFlagAppChatIxpParallelScreenLayers then IXPNavigationUtils.registerExposureOnFocus(arg1.props.navigation, FStringAppChatLandingConversationListIxpLayer) else nil

    arg1.performanceIxpSubscription = if FFlagAppChatIxpScreenExposure and FFlagAppChatIxpParallelScreenLayers then IXPNavigationUtils.registerExposureOnFocus(arg1.props.navigation, FStringAppChatLandingPerformanceIxpLayer) else nil

    function arg1.navigateToConversation(conversationId)
        Logger:info("Navigate To Conversation: {} from {screen}", conversationId)
        arg1.props.navigation.navigate(EnumScreens.ChatConversation, { conversationId = conversationId })
    end

    function arg1.navigateToCreateChat()
        Logger:info("Navigate To CreateNewChat from {screen}")
        arg1.props.navigation.navigate(EnumScreens.CreateNewChat)
    end

    function arg1.navigateToToast(arg2)
        Logger:info("Navigate To Toast from {screen}")
        arg1.props.navigation.navigate(EnumScreens.RoactChatToast, arg2)
    end

    function arg1.navigateToNotifications()
        local var2 = arg1.props.navigation.getScreenProps("navigateToLuaAppPages", {})[EnumScreens.Notifications]
        if var2 then
            Logger:info("Navigate To Notifications from {screen}")
            var2()
            return
        end
        Logger:warning("Notifications page was not set in navigateToLuaAppPages screenProps")
    end

    function arg1.navigateToPrivacy()
        local var2 = arg1.props.navigation.getScreenProps("navigateToLuaAppPages", {})[EnumScreens.PrivacySettings]
        if var2 then
            Logger:info("Navigate To PrivacySettings from {screen}")
            var2()
            return
        end
        Logger:warning("PrivacySettings page was not set in navigateToLuaAppPages screenProps")
    end

    function arg1.navigateToSquadLobby(conversationId)
        Logger:info("Navigate To SquadLobby from {screen}")
        local currentRoute = getCurrentRoute(arg1.props.navigation.state)
        if currentRoute
            and currentRoute.params
            and currentRoute.params.conversationId == conversationId
            and currentRoute.routeName == EnumScreens.ChatConversation
        then
            arg1.props.navigation.navigate(EnumScreens.SquadLobby, { conversationId = conversationId })
            return
        end

        if FFlagEnablePartyQuickStartButton then
            resetForSquadLobbyForWideMode(arg1.props.navigation, conversationId)
            return
        end
        arg1.props.navigation.navigate(
            EnumScreens.ChatLanding,
            nil,
            RoactNavigation.StackActions.reset({
                index = 2,
                actions = { RoactNavigation.Actions.navigate(
                        {
                            routeName = EnumScreens.ChatConversation,
                            params = { conversationId = conversationId }
                        }
                    ), RoactNavigation.Actions.navigate({ routeName = EnumScreens.SquadLobby, params = { conversationId = conversationId } }) }
            })
        )
    end

    function arg1.setScreenTopBar(arg2)
        GetTopBarStore(false).setScreenTopBar(EnumScreens.ChatLanding, arg2)
    end
    arg1.leftContainerRef = Roact.createRef()
    arg1.rightContainerRef = Roact.createRef()
    arg1.conversationTopBarRef = Roact.createRef()
    arg1.conversationPanelRef = Roact.createRef()
    arg1.wideModeFocusValue = {
        conversationListRef = arg1.leftContainerRef,
        conversationTopBarRef = arg1.conversationTopBarRef,
        conversationPanelRef = arg1.conversationPanelRef
    }
    arg1.focusNavigationService = ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)
end

function var1.render(arg1)
    Logger:info("{screen} render")
    local navigation = ArgCheck.isNotNil(arg1.props.navigation, "navigation in ChatLandingScreenWithSwitchNavigator")
    local param = navigation and navigation.getParam("key", "") or ""
    local screenProps = navigation.getScreenProps("showSearchRow", true)
    local height = navigation.getScreenProps("topBarHeight", 0)
    local screenProps3 = navigation.getScreenProps("isInExperience", false)

    return withStyle(function(arg2)
        local tbl1 = {
            LeftContainerProviders = Roact.createElement(LeftContainerTelemetryProviders, {
                renderChildren = function(bool1: boolean)
                    local var3 = FFlagAppChatWideAlwaysVisibleSearchBox and not screenProps3 and bool1
                    local var4 = screenProps or var3
                    return {
                        LeftContainer = Roact.createElement(TopBarProvider, {
                            screenName = EnumScreens.ChatLanding,
                            render = function(arg3)
                                local screenTopBar = arg3.getScreenTopBar(EnumScreens.ChatLanding)
                                ArgCheck.isType(screenTopBar, "table", "screenTopBar")

                                local isShowingFilterBox = screenTopBar.shouldRenderCenter or var4

                                local filterBox = if var4 then if var3 then Roact.createElement(ChatLandingSearchRow, {
                                    hasExit = false,
                                    height = height,
                                    paddingHorizontal = navigation.getScreenProps("appChatOuterPadding", 12),
                                    LayoutOrder = 0,
                                    testId = "ChatInlineSearch",
                                    reportFocusAsSearchEntry = true
                                }) else Roact.createElement(ChatSearchBox, {
                                    height = height,
                                    initialText = screenTopBar.filterText,
                                    onFilter = function(filterText)
                                        arg3.setScreenTopBar(EnumScreens.ChatLanding, { filterText = filterText })
                                    end,
                                    layoutOrder = if FFlagAppChatFixInExpSearchRowLayoutOrder then 0 else nil
                                }) else nil

                                return Roact.createElement("Frame", {
                                    Size = UDim2.new(0.37, 0, 1, 0),
                                    Position = UDim2.new(0, 0, 0, 0),
                                    BackgroundTransparency = 1,
                                    BorderSizePixel = 0,
                                    SelectionGroup = if FFlagAppChatConsoleFocusFixes then true else nil,
                                    SelectionBehaviorDown = if FFlagAppChatConsoleFocusFixes then Enum.SelectionBehavior.Stop else nil,
                                    SelectionBehaviorUp = if FFlagAppChatConsoleFocusFixes then Enum.SelectionBehavior.Stop else nil,
                                    [Roact.Ref] = arg1.leftContainerRef
                                }, {
                                    layout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
                                    leftTopBar = Roact.createElement(ChatLandingTopBar, { screenName = EnumScreens.ChatLanding, navigation = navigation }),
                                    filterBox = filterBox,
                                    content = Roact.createElement(Provider, {
                                        value = {
                                            left = navigation.getScreenProps("appChatOuterPadding", 12),
                                            right = navigation.getScreenProps("appChatInnerPadding", 12)
                                        }
                                    }, {
                                        ChatLanding = Roact.createElement("Frame", {
                                            BorderSizePixel = 0,
                                            Size = UDim2.new(1, 0, 1, -navigation.getScreenProps("topBarHeight", 0) - (if var4 then height else 0)),
                                            LayoutOrder = 2,
                                            BackgroundTransparency = arg2.Tokens.Color.None.Transparency
                                        }, { Roact.createElement(ChatLandingContainer, {
                                                isShowingFilterBox = isShowingFilterBox,
                                                filterText = screenTopBar.filterText,
                                                navigateToConversation = arg1.navigateToConversation,
                                                navigateToCreateChat = arg1.navigateToCreateChat,
                                                navigateToPrivacy = arg1.navigateToPrivacy,
                                                navigateToSquadLobby = arg1.navigateToSquadLobby,
                                                navigateToToast = arg1.navigateToToast,
                                                navigateToAddFriends = arg1.props.navigation.getScreenProps("navigateToAddFriends", {}),
                                                key = "ChatLanding" .. param
                                            }) })
                                    })
                                })
                            end
                        })
                    }
                end
            }),
            Border = Roact.createElement("Frame", {
                BackgroundColor3 = arg2.Theme.Divider.Color,
                BackgroundTransparency = arg2.Theme.Divider.Transparency,
                BorderSizePixel = 0,
                Position = UDim2.new(0.37, 0, 0, 0),
                Size = UDim2.new(0, 1, 1, 0)
            }),
            RightContainerProviders = 0
        }
        local createElement = Roact.createElement
        local func1 = RightContainerTelemetryProviders
        local tbl2 = {}
        local tbl3 = { RightContainer = 0 }
        local createElement2 = Roact.createElement
        local str1 = "Frame"
        local tbl4 = {
            Size = UDim2.new(0.63, -1, 1, 0),
            Position = UDim2.new(0.37, 1, 0, 0),
            ClipsDescendants = true,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            [Roact.Ref] = arg1.rightContainerRef,
            SelectionGroup = if FFlagAppChatConsoleFocusFixes then true else nil,
            SelectionBehaviorDown = if FFlagAppChatConsoleFocusFixes then Enum.SelectionBehavior.Stop else nil,
            SelectionBehaviorUp = if FFlagAppChatConsoleFocusFixes then Enum.SelectionBehavior.Stop else nil
        }
        local tbl5 = { Content = 0 }
        local createElement3 = Roact.createElement
        local var3 = Provider
        local tbl6 = {
            value = {
                left = navigation.getScreenProps("appChatInnerPadding", 12),
                right = navigation.getScreenProps("appChatOuterPadding", 12)
            }
        }
        local tbl7 = {
            ConversationSwitchNavigator = Roact.createElement(
                conversationSwitchNavigator,
                {
                    navigation = navigation,
                    screenProps = if FFlagAppChatFoundationHeaderBar then arg1.props.screenProps else nil
                }
            )
        }
        tbl5.Content = createElement3(var3, tbl6, tbl7)
        tbl3.RightContainer = createElement2(str1, tbl4, tbl5)
        tbl1.RightContainerProviders = createElement(func1, tbl2, tbl3)

        return React.createElement(Context.Provider, {
            value = arg1.wideModeFocusValue
        }, {
            FocusListener = Roact.createElement(ConversationStackNavigationFocusListener, {
                navigation = navigation,
                leftContainerRef = arg1.leftContainerRef,
                rightContainerRef = arg1.rightContainerRef,
                conversationTopBarRef = arg1.conversationTopBarRef,
                conversationPanelRef = arg1.conversationPanelRef
            }, tbl1)
        })
    end)
end

function var1.didMount(arg1)
    Logger:info("{screen} mounted")

    local navigation = arg1.props.navigation
    local screenProps = navigation.getScreenProps("navigateToRootStack", nil)
    local screenProps2 = navigation.getScreenProps("isInExperience", false)
    local bool1 = not not screenProps
    local var2 = GetFFlagEnableAppChatInExperience() and screenProps2
    local screenProps3 = navigation.getScreenProps("appChatInnerPadding", 12)

    if SharedFlags.FFlagEnableHeaderBarButtonsUpdate then
        screenProps3 -= navigation.getScreenProps("topBarUtilityIconSideMargin", 0)
    end

    local headerText = UniversalAppPolicy.getAppFeaturePolicies().getCanSeeChatTerminology()
        and { raw = "CommonUI.Features.Label.Chat", shouldLocalize = true }
        or { raw = "Feature.Squads.Label.Party", shouldLocalize = true }

    arg1.setScreenTopBar({
        shouldRenderCenter = false,
        filterText = "",
        headerText = headerText,
        backButtonEnabled = false,
        closeButtonEnabled = var2 and bool1,
        isRoot = true,
        isTitleLeftAligned = true,
        leftPaddingOverride = navigation.getScreenProps("appChatOuterPadding", 12),
        rightPaddingOverride = screenProps3,
        shouldBoldHeader = true
    })

    if arg1.focusNavigationService then
        arg1.focusNavigationService:registerFocusBehavior(arg1.leftContainerRef.current, FocusBehaviors.mostRecent())
        arg1.focusNavigationService:registerFocusBehavior(arg1.rightContainerRef.current, FocusBehaviors.mostRecent())
    end
end

function var1.willUnmount(arg1)
    if arg1.ixpSubscription then
        arg1.ixpSubscription.remove()
    end
    if arg1.conversationRowsIxpSubscription then
        arg1.conversationRowsIxpSubscription.remove()
    end
    if arg1.conversationListIxpSubscription then
        arg1.conversationListIxpSubscription.remove()
    end
    if arg1.performanceIxpSubscription then
        arg1.performanceIxpSubscription.remove()
    end
    arg1.focusNavigationService:teardown()
end

return var1
