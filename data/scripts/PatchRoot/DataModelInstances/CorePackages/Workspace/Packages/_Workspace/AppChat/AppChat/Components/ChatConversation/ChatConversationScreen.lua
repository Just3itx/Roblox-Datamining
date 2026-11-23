-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local EnumScreens = require(AppChat.EnumScreens)
local ArgCheck = require(AppChatParent.ArgCheck)
local Roact = require(AppChatParent.Roact)
local RoactNavigation = require(AppChatParent.RoactNavigation)
local Cryo = require(AppChatParent.Cryo)

local readingMessagesIsEnabled = require(script.Parent.Utils.readingMessagesIsEnabled)

local ChatConversationContainer = require(script.Parent.ChatConversationContainer)
local Logger = require(script.Parent.Logger)

local FFlagAppChatMomentShareCardNavigation = require(AppChatParent.SharedFlags).FFlagAppChatMomentShareCardNavigation
local FFlagAppChatIxpScreenExposure = require(AppChat.Flags.FFlagAppChatIxpScreenExposure)
local FFlagAppChatIxpParallelScreenLayers = require(AppChat.Flags.FFlagAppChatIxpParallelScreenLayers)
local FStringAppChatConversationComposerIxpLayer = require(AppChat.Flags.FStringAppChatConversationComposerIxpLayer)

local FStringAppChatConversationPerformanceIxpLayer = require(AppChat.Flags.FStringAppChatConversationPerformanceIxpLayer)
local FStringAppChatConversationMessagesIxpLayer = require(AppChat.Flags.FStringAppChatConversationMessagesIxpLayer)
local FFlagAppChatMomentShareCard = require(AppChat.Flags.FFlagAppChatMomentShareCard)

local IXPNavigationUtils = require(AppChat.Utils.IXPNavigationUtils)
local GetTopBarStore = require(AppChat.Stores.GetTopBarStore)
local FFlagAppChatFixBackButtonOnRotation = require(AppChat.Flags.FFlagAppChatFixBackButtonOnRotation)
local canPopParentStack = require(AppChat.Utils.canPopParentStack)

local function getBackButtonConfig(arg1) -- Luacid: unused: defined but never referenced
    local screenProps = arg1.getScreenProps("wideMode", false)
    if FFlagAppChatFixBackButtonOnRotation and canPopParentStack(arg1) then
        return true, false
    end
    return not screenProps, screenProps
end

local var1 = Roact.PureComponent:extend("ChatConversationScreen")
var1.defaultProps = { navigation = nil }

function var1.navigationOptions(arg1)
    local navigation = arg1.navigation
    local screenProps = navigation.getScreenProps("wideMode", false)
    local bool1

    if FFlagAppChatFixBackButtonOnRotation then
        if canPopParentStack(navigation) then
            bool1 = true
            screenProps = false
        else
            bool1 = not screenProps
        end
    else
        bool1 = not screenProps
    end

    return {
        tabBarVisible = false,
        lockIconEnabled = true,
        absorbInput = false,
        backButtonEnabled = bool1,
        isRoot = screenProps
    }
end

function var1.init(arg1)
    arg1.ixpSubscription = if FFlagAppChatIxpScreenExposure then IXPNavigationUtils.registerExposureOnFocus(arg1.props.navigation, "Party.ConversationPage") else nil

    arg1.composerIxpSubscription = if FFlagAppChatIxpScreenExposure and FFlagAppChatIxpParallelScreenLayers then IXPNavigationUtils.registerExposureOnFocus(arg1.props.navigation, FStringAppChatConversationComposerIxpLayer) else nil

    arg1.performanceIxpSubscription = if FFlagAppChatIxpScreenExposure and FFlagAppChatIxpParallelScreenLayers then IXPNavigationUtils.registerExposureOnFocus(arg1.props.navigation, FStringAppChatConversationPerformanceIxpLayer) else nil

    arg1.messagesIxpSubscription = if FFlagAppChatIxpScreenExposure and FFlagAppChatIxpParallelScreenLayers then IXPNavigationUtils.registerExposureOnFocus(arg1.props.navigation, FStringAppChatConversationMessagesIxpLayer) else nil

    arg1.toastProps = nil
    arg1.inputBoxRef = Roact.createRef()

    arg1.lastHeaderText = nil
    arg1.lastIsPrivateConversation = nil

    local navigation = arg1.props.navigation
    local conversationId = navigation.getParam and navigation.getParam("conversationId", nil)

    function arg1.navigateToConversationOverlay()
        Logger:info("Navigate To ConversationOverlay: {} from {screen}", conversationId)
        local param = arg1.props.navigation.getParam and arg1.props.navigation.getParam("conversationId", nil)
        navigation.navigate(EnumScreens.ConversationOverlay, { conversationId = param, isOverlay = true })
    end

    function arg1.navigateToChatDetails()
        local param = arg1.props.navigation.getParam and arg1.props.navigation.getParam("conversationId", nil)
        Logger:info("Navigate To ChatDetails: {} from {screen}", param)
        navigation.navigate(
            EnumScreens.ChatDetails,
            {
                conversationId = param,
                isRooted = arg1.props.navigation.getParam("isRooted", false)
            }
        )
    end
    local screenProps = navigation.getScreenProps("wideMode", false)
    local screenProps2 = navigation.getScreenProps("wideMode", false)
    local bool1

    if FFlagAppChatFixBackButtonOnRotation then
        if canPopParentStack(navigation) then
            bool1 = true
            screenProps2 = false
        else
            bool1 = not screenProps2
        end
    else
        bool1 = not screenProps2
    end

    GetTopBarStore(false).setScreenTopBar(EnumScreens.ChatConversation, {
        navigateToChatDetails = arg1.navigateToChatDetails,
        conversationId = conversationId,
        backButtonEnabled = bool1,
        isRoot = screenProps2,
        leftPaddingOverride = if screenProps then navigation.getScreenProps("appChatInnerPadding", 12) else navigation.getScreenProps("appChatOuterPadding", 12),
        rightPaddingOverride = navigation.getScreenProps("appChatOuterPadding", 12)
    })

    function arg1.writeScreenTopBar()
        local param = if arg1.props.navigation.getParam then arg1.props.navigation.getParam("conversationId", nil) else nil
        local screenProps3 = arg1.props.navigation.getScreenProps("wideMode", false)
        local navigation2 = arg1.props.navigation
        local screenProps4 = navigation2.getScreenProps("wideMode", false)
        local bool2

        if FFlagAppChatFixBackButtonOnRotation then
            if canPopParentStack(navigation2) then
                bool2 = true
                screenProps4 = false
            else
                bool2 = not screenProps4
            end
        else
            bool2 = not screenProps4
        end

        local tbl1 = {
            navigateToChatDetails = arg1.navigateToChatDetails,
            conversationId = param,
            backButtonEnabled = bool2,
            isRoot = screenProps4,
            leftPaddingOverride = if screenProps3 then arg1.props.navigation.getScreenProps("appChatInnerPadding", 12) else arg1.props.navigation.getScreenProps("appChatOuterPadding", 12),
            rightPaddingOverride = arg1.props.navigation.getScreenProps("appChatOuterPadding", 12)
        }
        if arg1.lastHeaderText ~= nil then
            tbl1.headerText = arg1.lastHeaderText
        end
        if arg1.lastIsPrivateConversation ~= nil then
            tbl1.isPrivateConversation = arg1.lastIsPrivateConversation
        end
        GetTopBarStore(false).setScreenTopBar(EnumScreens.ChatConversation, tbl1)
    end

    function arg1.queueNavigationToToast(toastProps)
        if arg1.props.navigation.isFocused() then
            arg1.navigateToToast(toastProps)

            arg1.toastProps = nil
            return
        end
        arg1.toastProps = toastProps
    end

    function arg1.onDidFocus()
        arg1.writeScreenTopBar()

        arg1.setInputBarCloseCallback(arg1.releaseFocus)

        if arg1.toastProps then
            arg1.navigateToToast(arg1.toastProps)
            arg1.toastProps = nil
        end
    end

    function arg1.releaseFocus()
        if arg1.inputBoxRef and arg1.inputBoxRef:getValue() then
            arg1.inputBoxRef:getValue():ReleaseFocus()
        end
    end

    function arg1.onWillBlur()
        arg1.releaseFocus()

        arg1.setInputBarCloseCallback()
    end

    function arg1.navigateToToast(arg2)
        Logger:info("Navigate To Toast from {screen}")

        arg1.props.navigation.navigate(EnumScreens.RoactChatToast, Cryo.Dictionary.union(arg2, { isOverlay = true }))
    end

    function arg1.openViewProfile(arg2)
        local var2 = arg1.props.navigation.getScreenProps("navigateToLuaAppPages", {})[EnumScreens.ViewUserProfile]
        if var2 then
            Logger:info("Navigate To UserProfile from {screen}")

            var2(arg2, {})
            return
        end
        Logger:warning("UserProfile page was not set in navigateToLuaAppPages screenProps")
    end

    function arg1.openGameDetailsPage(arg2, arg3)
        local var2 = arg1.props.navigation.getScreenProps("navigateToLuaAppPages", {})[EnumScreens.GameDetail]

        if var2 then
            Logger:info("Navigate To GameDetail from " .. tostring(arg3))

            var2(arg2, arg3)
            return
        end
        Logger:warning("GameDetail page was not set in navigateToLuaAppPages screenProps")
    end

    function arg1.getOpenMomentsImmersive()
        return arg1.props.navigation.getScreenProps("navigateToLuaAppPages", {})[EnumScreens.MomentsImmersive]
    end

    function arg1.navigateToChatConversation(conversationId2)
        Logger:info("Navigate To Conversation: {} from {screen}", conversationId2)
        arg1.props.navigation.navigate(EnumScreens.ChatConversation, { conversationId = conversationId2 })
    end

    function arg1.navigateToScreen(arg2, arg3, isOverlay)
        Logger:info("Navigate To Screen: {} from {screen}", arg2)
        local navigation2 = arg1.props.navigation
        local param = navigation2 and navigation2.getParam and navigation2.getParam("conversationId", nil)

        if arg3 then
            arg1.props.navigation.navigate(arg2, Cryo.Dictionary.union({ conversationId = param, isOverlay = isOverlay }, arg3))
            return
        end

        arg1.props.navigation.navigate(arg2, { conversationId = param })
    end

    function arg1.navigateBack()
        if arg1.props.navigation.isFocused() then
            arg1.props.navigation.goBack()
        end
    end

    function arg1.navigateToChatLanding()
        Logger:info("Navigate To ChatLanding from {screen}")
        if arg1.props.navigation.getScreenProps("wideMode", false) then
            arg1.props.navigation.navigate(EnumScreens.EmptyConversation)
            return
        end
        arg1.props.navigation.navigate(EnumScreens.ChatLanding)
    end

    function arg1.navigateToSquadLobby(conversationId2)
        Logger:info("Navigate To SquadLobby from {screen}")
        arg1.props.navigation.navigate(EnumScreens.SquadLobby, { conversationId = conversationId2 })
    end

    function arg1.updateConversationTitle(raw)
        local var2 = raw and { raw = raw, shouldLocalize = false } or {
            raw = "CommonUI.Features.Label.Chat",
            shouldLocalize = true
        }

        arg1.lastHeaderText = var2
        GetTopBarStore(false).setScreenTopBar(EnumScreens.ChatConversation, { headerText = var2 })
    end

    function arg1.setInputBarCloseCallback(closeInputBar)
        GetTopBarStore(false).setScreenTopBar(EnumScreens.ChatLanding, { closeInputBar = closeInputBar })
    end

    function arg1.getReadingMessagesIsEnabled()
        return readingMessagesIsEnabled(arg1.props.navigation)
    end

    function arg1.updatePrivateConversationTopBar(arg2)
        arg1.lastIsPrivateConversation = arg2
        GetTopBarStore(false).setScreenTopBar(EnumScreens.ChatConversation, { isPrivateConversation = arg2 })
    end
end

function var1.didUpdate(arg1, arg2)
    local param = arg2.navigation and arg2.navigation.getParam and arg2.navigation.getParam("conversationId", nil)
    local conversationId = arg1.props.navigation and arg1.props.navigation.getParam and arg1.props.navigation.getParam("conversationId", nil)
    if param == conversationId then
        return
    end

    arg1.lastHeaderText = nil
    arg1.lastIsPrivateConversation = nil
    GetTopBarStore(false).setScreenTopBar(EnumScreens.ChatConversation, { conversationId = conversationId })
end

function var1.render(arg1)
    local var2 = ArgCheck.isNotNil(arg1.props.navigation, "navigation in ChatConversationScreen")
    local openMomentsDeepLink = if FFlagAppChatMomentShareCard and FFlagAppChatMomentShareCardNavigation then arg1.getOpenMomentsImmersive() else nil
    local eventsAdapter = Roact.createElement(RoactNavigation.NavigationEvents, { onDidFocus = arg1.onDidFocus, onWillBlur = arg1.onWillBlur })

    local param = var2.getParam("conversationId", nil)
    local conversationId = param and tostring(param) or nil

    return Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1
    }, {
        container = Roact.createElement(ChatConversationContainer, {
            topBarHeight = var2.getScreenProps("topBarHeight", 0),
            wideMode = var2.getScreenProps("wideMode", false),
            openGameDetailsPage = arg1.openGameDetailsPage,
            openMomentsDeepLink = openMomentsDeepLink,
            getReadingMessagesIsEnabled = arg1.getReadingMessagesIsEnabled,
            conversationId = conversationId,
            inputBoxRef = arg1.inputBoxRef,
            updateConversationTitle = arg1.updateConversationTitle,
            updatePrivateConversationTopBar = arg1.updatePrivateConversationTopBar,
            releaseInputBarFocus = arg1.releaseFocus,
            navigateBack = arg1.navigateBack,
            navigateToToast = arg1.queueNavigationToToast,
            openViewProfile = arg1.openViewProfile,
            navigateToChatConversation = arg1.navigateToChatConversation,
            navigateToChatLanding = arg1.navigateToChatLanding,
            navigateToScreen = arg1.navigateToScreen,
            navigateToSquadLobby = arg1.navigateToSquadLobby,
            navigateToConversationOverlay = arg1.navigateToConversationOverlay,
            navigation = arg1.props.navigation
        }),
        eventsAdapter = eventsAdapter
    })
end

function var1.didMount(arg1)
    Logger:info("{screen} mounted")
    local navigation = arg1.props.navigation
    local screenProps = navigation.getScreenProps("wideMode", false)
    GetTopBarStore(false).setScreenTopBar(EnumScreens.ChatConversation, {
        leftPaddingOverride = if screenProps then navigation.getScreenProps("appChatInnerPadding", 12) else navigation.getScreenProps("appChatOuterPadding", 12),
        rightPaddingOverride = navigation.getScreenProps("appChatOuterPadding", 12)
    })
end

function var1.willUnmount(arg1)
    GetTopBarStore(false).clearScreenTopBar(EnumScreens.ChatConversation)
    if arg1.ixpSubscription then
        arg1.ixpSubscription.remove()
    end
    if arg1.composerIxpSubscription then
        arg1.composerIxpSubscription.remove()
    end
    if arg1.performanceIxpSubscription then
        arg1.performanceIxpSubscription.remove()
    end
    if arg1.messagesIxpSubscription then
        arg1.messagesIxpSubscription.remove()
    end
end

return var1
