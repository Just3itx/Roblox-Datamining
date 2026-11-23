-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local EnumScreens = require(AppChat.EnumScreens)
local TopBarProvider = require(AppChat.TopBarProvider)
local ArgCheck = require(AppChatParent.ArgCheck)
local Roact = require(AppChatParent.Roact)
local RoactNavigation = require(AppChatParent.RoactNavigation)
local UniversalAppPolicy = require(AppChatParent.UniversalAppPolicy)

local ChatLandingContainer = require(script.Parent.ChatLandingContainer)
local Logger = require(script.Parent.Logger)
local getCurrentRoute = require(script.Parent.Utils.getCurrentRoute)
local ChatSearchBox = require(script.Parent.ChatSearchBox)
local CheckAndOpenChatPushUpsell = require(script.Parent.CheckAndOpenChatPushUpsell)
local ChatLandingPrompts = require(script.Parent.ChatLandingPrompts)

local resetForSquadLobbyForCompactMode = require(AppChat.Utils.resetForSquadLobbyForCompactMode)

local GetFFlagEnableAppChatInExperience = require(AppChatParent.SharedFlags).GetFFlagEnableAppChatInExperience
local FFlagEnablePartyQuickStartButton = require(AppChatParent.SharedFlags).FFlagEnablePartyQuickStartButton

local GetFFlagEnablePushNotificationsUpsellModalChat = require(AppChatParent.SharedFlags).GetFFlagEnablePushNotificationsUpsellModalChat
local SharedFlags = require(AppChatParent.SharedFlags)
local FFlagEnableHeaderBarButtonsUpdate = SharedFlags.FFlagEnableHeaderBarButtonsUpdate
local FFlagChatPushUpsellPromptsEnabled = SharedFlags.FFlagChatPushUpsellPromptsEnabled
local GetTopBarStore = require(AppChat.Stores.GetTopBarStore)

local FFlagAppChatIxpScreenExposure = require(AppChat.Flags.FFlagAppChatIxpScreenExposure)
local FFlagAppChatIxpParallelScreenLayers = require(AppChat.Flags.FFlagAppChatIxpParallelScreenLayers)

local FStringAppChatLandingConversationRowsIxpLayer = require(AppChat.Flags.FStringAppChatLandingConversationRowsIxpLayer)

local FStringAppChatLandingConversationListIxpLayer = require(AppChat.Flags.FStringAppChatLandingConversationListIxpLayer)
local FStringAppChatLandingPerformanceIxpLayer = require(AppChat.Flags.FStringAppChatLandingPerformanceIxpLayer)

local IXPNavigationUtils = require(AppChat.Utils.IXPNavigationUtils)

local var1 = Roact.PureComponent:extend("ChatLandingScreen")
var1.defaultProps = { navigation = nil }

function var1.navigationOptions(arg1)
    local navigation = arg1.navigation
    local screenProps = navigation.getScreenProps("navigateToRootStack", nil)

    local screenProps2 = navigation.getScreenProps("isInExperience", false)
    local bool1 = not not screenProps
    local var2 = GetFFlagEnableAppChatInExperience() and screenProps2
    local screenProps3 = if navigation.getScreenProps("wideMode", false) then navigation.getScreenProps("appChatInnerPadding", 12) else navigation.getScreenProps("appChatOuterPadding", 12)

    if FFlagEnableHeaderBarButtonsUpdate then
        screenProps3 -= navigation.getScreenProps("topBarUtilityIconSideMargin", 0)
    end

    return {
        headerText = UniversalAppPolicy.getAppFeaturePolicies().getCanSeeChatTerminology()
            and { raw = "CommonUI.Features.Label.Chat", shouldLocalize = true }
            or { raw = "Feature.Squads.Label.Party", shouldLocalize = true },
        backButtonEnabled = false,
        closeButtonEnabled = var2 and bool1,
        tabBarVisible = not screenProps or nil,
        isRoot = true,
        isTitleLeftAligned = true,
        leftPaddingOverride = navigation.getScreenProps("appChatOuterPadding", 12),
        rightPaddingOverride = screenProps3,
        shouldBoldHeader = true
    }
end

function var1.init(arg1)
    arg1.ixpSubscription = if FFlagAppChatIxpScreenExposure then IXPNavigationUtils.registerExposureOnFocus(arg1.props.navigation, "Party.LandingPage") else nil

    arg1.conversationRowsIxpSubscription = if FFlagAppChatIxpScreenExposure and FFlagAppChatIxpParallelScreenLayers then IXPNavigationUtils.registerExposureOnFocus(arg1.props.navigation, FStringAppChatLandingConversationRowsIxpLayer) else nil

    arg1.conversationListIxpSubscription = if FFlagAppChatIxpScreenExposure and FFlagAppChatIxpParallelScreenLayers then IXPNavigationUtils.registerExposureOnFocus(arg1.props.navigation, FStringAppChatLandingConversationListIxpLayer) else nil

    arg1.performanceIxpSubscription = if FFlagAppChatIxpScreenExposure and FFlagAppChatIxpParallelScreenLayers then IXPNavigationUtils.registerExposureOnFocus(arg1.props.navigation, FStringAppChatLandingPerformanceIxpLayer) else nil

    function arg1.navigateToConversation(conversationId)
        Logger:info("Navigate To Conversation: {} from {screen}", conversationId)
        arg1.props.navigation.navigate(
            EnumScreens.ChatConversation,
            { conversationId = conversationId, navigatedWithFocus = false }
        )

        arg1.resetScreenTopBar()
    end

    function arg1.navigateToCreateChat()
        Logger:info("Navigate To CreateNewChat from {screen}")
        arg1.props.navigation.push(EnumScreens.CreateNewChat)
    end

    function arg1.navigateToToast(arg2)
        Logger:info("Navigate To Toast from {screen}")
        arg1.props.navigation.navigate(EnumScreens.RoactChatToast, arg2)
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
            resetForSquadLobbyForCompactMode(arg1.props.navigation, conversationId)
            return
        end
        arg1.props.navigation.reset({ RoactNavigation.Actions.navigate({ routeName = EnumScreens.ChatLanding }), RoactNavigation.Actions.navigate(
                {
                    routeName = EnumScreens.ChatConversation,
                    params = { conversationId = conversationId }
                }
            ), RoactNavigation.Actions.navigate({ routeName = EnumScreens.SquadLobby, params = { conversationId = conversationId } }) }, 3)
    end

    function arg1.setScreenTopBar(arg2)
        GetTopBarStore(false).setScreenTopBar(EnumScreens.ChatLanding, arg2)
    end

    function arg1.resetScreenTopBar()
        local var2 = GetTopBarStore(false).getScreenTopBar(EnumScreens.ChatLanding)(false) or {}
        if var2.filterText == "" and var2.shouldRenderCenter then
            arg1.setScreenTopBar({ shouldRenderCenter = false, isSecondary = false })
        end
    end
end

function var1.render(arg1)
    Logger:info("{screen} render")
    local var2 = ArgCheck.isNotNil(arg1.props.navigation, "navigation in ChatLandingScreen")
    local param = var2 and var2.getParam("key", "") or ""
    local screenProps = var2.getScreenProps("showSearchRow", true)
    local height = var2.getScreenProps("topBarHeight", 0)

    return Roact.createElement(TopBarProvider, {
        screenName = EnumScreens.ChatLanding,
        render = function(arg2)
            local screenTopBar = arg2.getScreenTopBar(EnumScreens.ChatLanding)
            ArgCheck.isType(screenTopBar, "table", "screenTopBar")

            local element = Roact.createElement(ChatLandingContainer, {
                isShowingFilterBox = screenTopBar.shouldRenderCenter or screenProps,
                filterText = screenTopBar.filterText,
                topBarHeight = var2.getScreenProps("topBarHeight", 0),
                navigateToAddFriends = arg1.props.navigation.getScreenProps("navigateToAddFriends", {}),
                navigateToConversation = arg1.navigateToConversation,
                navigateToCreateChat = arg1.navigateToCreateChat,
                navigateToPrivacy = arg1.navigateToPrivacy,
                navigateToSquadLobby = arg1.navigateToSquadLobby,
                navigateToToast = arg1.navigateToToast,
                key = "ChatLanding" .. param
            })

            if not screenProps then
                if FFlagChatPushUpsellPromptsEnabled then
                    local renderPrompts = var2.getScreenProps("renderChatLandingPrompts", nil)
                    if renderPrompts then
                        return Roact.createFragment(
                            {
                                element,
                                ChatLandingPrompts = Roact.createElement(ChatLandingPrompts, { renderPrompts = renderPrompts })
                            }
                        )
                    end
                end

                if GetFFlagEnablePushNotificationsUpsellModalChat() and not FFlagChatPushUpsellPromptsEnabled then
                    return Roact.createFragment({ element, CheckAndOpenChatPushUpsell = Roact.createElement(CheckAndOpenChatPushUpsell) })
                end

                return element
            end

            return Roact.createElement("Frame", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1
            }, {
                UIListLayout = Roact.createElement("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Vertical,
                    VerticalAlignment = Enum.VerticalAlignment.Top,
                    VerticalFlex = Enum.UIFlexAlignment.Fill,
                    Padding = UDim.new(0, 0)
                }),
                ChatSearchBox = Roact.createElement(ChatSearchBox, {
                    height = height,
                    initialText = screenTopBar.filterText,
                    onFilter = function(filterText)
                        arg2.setScreenTopBar(EnumScreens.ChatLanding, { filterText = filterText })
                    end
                }),
                element
            })
        end
    })
end

function var1.didMount(arg1)
    Logger:info("{screen} mounted")

    local navigation = arg1.props.navigation
    local screenProps = navigation.getScreenProps("navigateToRootStack", nil)
    local screenProps2 = navigation.getScreenProps("isInExperience", false)
    local bool1 = not not screenProps
    local var2 = GetFFlagEnableAppChatInExperience() and screenProps2
    local screenProps3 = if navigation.getScreenProps("wideMode", false) then navigation.getScreenProps("appChatInnerPadding", 12) else navigation.getScreenProps("appChatOuterPadding", 12)

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
end

return var1
