-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local IXPService = game:GetService("IXPService")

local BackHandlerContext = require(AppChat.Contexts.BackHandlerContext)
local EnumScreens = require(AppChat.EnumScreens)
local InputHandlers = require(AppChatParent.InputHandlers)
local React = require(AppChatParent.React)
local Roact = require(AppChatParent.Roact)
local ReactFocusNavigation = require(AppChatParent.ReactFocusNavigation)
local RoactNavigation = require(AppChatParent.RoactNavigation)
local FocusNavigationUtils = require(AppChatParent.FocusNavigationUtils)
local SharedFlags = require(AppChatParent.SharedFlags)

local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local FFlagAppChatFixRootChatBackNavigation = SharedFlags.FFlagAppChatFixRootChatBackNavigation

local bool1 = game:DefineFastFlag("AppChatFixRootChatBackNavigationIxpEnabled", false)

local layerName = game:DefineFastString("AppChatFixRootChatBackNavigationIxpLayer", "Party.LandingPage")

local GetTopBarStore = require(AppChat.Stores.GetTopBarStore)

local FFlagSignalsNavDeferProjection = SharedFlags.FFlagSignalsNavDeferProjection
local getIsChatVisibleNow = if FFlagSignalsNavDeferProjection then require(AppChat.Utils.getIsChatVisibleNow).getIsChatVisibleNow else nil
local FFlagAppChatFoundationHeaderBar = require(AppChat.Flags.FFlagAppChatFoundationHeaderBar)

local _types = require(AppChat.types)

local function getActiveChildParams(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local index = arg1.index
    local var1 = arg1.routes and arg1.routes[index]
    if var1 then
        return getActiveChildParams(var1)
    end
    return arg1.params
end

local function getActiveChildNavigationOptions(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local state = arg1.state
    local index = state.index
    local var1 = state.routes and state.routes[index]

    if not (var1 and var1.routes) then
        return RoactNavigation.getActiveChildNavigationOptions(arg1)
    end

    local childNavigation = arg1.getChildNavigation(var1.key)
    return getActiveChildNavigationOptions(childNavigation)
end

local function getActiveConversationId(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1 then
        if arg1.conversation then
            return arg1.conversation.id
        end

        return arg1.conversationId
    end

    return nil
end

local function RoactChatStackNavigatorWithFocusNavigation(arg1)
    local var1 = React.useCallback(InputHandlers.onRelease(function(arg2)
        if arg1.shouldSuppressNavigateBack(arg2) then
            arg2:cancel()
            return
        end

        if arg1.onNavigateBack() then
            arg2:cancel()
        end
    end), { arg1.onNavigateBack, arg1.shouldSuppressNavigateBack })

    local ref = ReactFocusNavigation.useEventHandler(FocusNavigationEventNameEnum.NavigateBack, var1)

    local createFragment = Roact.createFragment
    local tbl1 = { FocusNavigationContainer = 0 }
    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ref = ref
    }
    local tbl3 = {
        navigator = Roact.createElement(
            arg1.navigator,
            {
                navigation = arg1.navigation,
                screenProps = if FFlagAppChatFoundationHeaderBar then arg1.screenProps else nil
            }
        )
    }
    tbl1.FocusNavigationContainer = createElement(str1, tbl2, tbl3)
    return createFragment(tbl1)
end

local function RoactChatStackNavigatorWithBackHandler(arg1)
    local createElement = Roact.createElement
    local provider = BackHandlerContext.Provider
    local tbl1 = {
        value = arg1.registerBackHandler
    }
    local tbl2 = {
        FocusNavigation = Roact.createElement(RoactChatStackNavigatorWithFocusNavigation, {
            navigation = arg1.navigation,
            screenProps = if FFlagAppChatFoundationHeaderBar then arg1.screenProps else nil,
            navigator = arg1.navigator,
            onNavigateBack = arg1.onNavigateBack,
            shouldSuppressNavigateBack = arg1.shouldSuppressNavigateBack
        })
    }
    return createElement(provider, tbl1, tbl2)
end

return function(navigator, callback, arg1, arg2)
    local var1 = Roact.PureComponent:extend("RoactChatStackNavigator")

    var1.defaultProps = {
        navigation = nil,
        parameters = nil,
        setActiveConversationId = function() end,
        setBackButtonEnabled = function() end,
        setTabBarVisible = function() end,
        notificationCount = 0
    }

    function var1.init(arg3)
        arg3.backButtonConnection = nil
        arg3.backHandler = nil
        arg3.suppressNextButtonBRelease = false
        function arg3.registerBackHandler(backHandler)
            arg3.backHandler = backHandler

            return function()
                if arg3.backHandler == backHandler then
                    arg3.backHandler = nil
                end
            end
        end

        function arg3.shouldSuppressNavigateBack(arg4): boolean
            if not arg3.suppressNextButtonBRelease then
                return false
            end

            arg3.suppressNextButtonBRelease = false
            return not (arg4.eventData == nil) and arg4.eventData.KeyCode == Enum.KeyCode.ButtonB
        end

        function arg3.onBackButtonPressed(): boolean
            if arg3.backHandler then
                arg3.backHandler()
                return true
            end

            local activeChildNavigationOptions = getActiveChildNavigationOptions(arg3.props.navigation)
            if not (callback and activeChildNavigationOptions.isRoot) then
                arg3.props.navigation.pop()
                return true
            end

            if bool1 then
                IXPService:LogFlagLinkedUserLayerExposure(layerName)
            end
            arg3.props.navigation.navigate(EnumScreens.EmptyConversation)
            callback()

            if not FFlagAppChatFixRootChatBackNavigation and arg2 and arg3.props.chatIsVisible then
                arg2.showExitDialog()
            end

            return false
        end

        function arg3.onDirectBackButtonPressed()
            arg3.suppressNextButtonBRelease = arg3.backHandler ~= nil

            return arg3.onBackButtonPressed()
        end
    end

    function var1.willUpdate(arg3, arg4)
        local activeChildParams = getActiveChildParams(arg3.props.navigation.state)
        local activeChildParams2 = getActiveChildParams(arg4.navigation.state)
        local activeConversationId = getActiveConversationId(activeChildParams)
        local activeConversationId2 = getActiveConversationId(activeChildParams2)

        if activeConversationId ~= activeConversationId2 then
            arg3.props.setActiveConversationId(activeConversationId2)
        end

        if not (if FFlagSignalsNavDeferProjection then getIsChatVisibleNow() else arg4.chatIsVisible) then
            return
        end

        local state = arg4.navigation.state
        local var2 = state.routes[state.index]
        local activeChildNavigationOptions = getActiveChildNavigationOptions(arg4.navigation)
        local var3 = GetTopBarStore(false).getScreenTopBar(var2.routeName)()
        if var3.backButtonEnabled ~= nil then
            arg3.props.setBackButtonEnabled(var3.backButtonEnabled)
        end

        if activeChildNavigationOptions and activeChildNavigationOptions.tabBarVisible ~= nil then
            arg3.props.setTabBarVisible(activeChildNavigationOptions.tabBarVisible)
        end
    end

    function var1.didMount(arg3)
        if arg1 and callback then
            arg3.backButtonConnection = arg1:connect(arg3.onDirectBackButtonPressed)
        end

        local parameters = arg3.props.parameters
        local conversationId = parameters and parameters.conversationId
        if conversationId then
            arg3.props.navigation.navigate(EnumScreens.ChatConversation, { conversationId = conversationId })
        end
    end

    function var1.willUnmount(arg3)
        arg3.props.setActiveConversationId(nil)
        arg3.backHandler = nil
        arg3.suppressNextButtonBRelease = false
        if arg3.backButtonConnection then
            arg3.backButtonConnection:disconnect()
        end
    end

    function var1.render(arg3)
        local navigation = arg3.props.navigation
        return Roact.createElement(RoactChatStackNavigatorWithBackHandler, {
            navigation = navigation,
            screenProps = if FFlagAppChatFoundationHeaderBar then arg3.props.screenProps else nil,
            navigator = navigator,
            onNavigateBack = arg3.onBackButtonPressed,
            registerBackHandler = arg3.registerBackHandler,
            shouldSuppressNavigateBack = arg3.shouldSuppressNavigateBack
        })
    end

    var1.router = navigator.router

    return var1
end
