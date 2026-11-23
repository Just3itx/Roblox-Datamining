-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _types = require(AppChat.types)

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local useStyle = require(AppChatParent.UIBlox).Core.Style.useStyle

local EnumScreens = require(AppChat.EnumScreens)
local configureTopBarWithNavigationOptions = require(AppChat.configureTopBarWithNavigationOptions)
local conversationStackNavigator = require(script.Parent.conversationStackNavigator)
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local ChatConversationTopBar = require(AppChat.Components.TopBar.ChatConversationTopBar)
local ChatTopBarBase = require(AppChat.Components.TopBar.ChatTopBarBase)
local SystemMenuTopBar = require(AppChat.Components.TopBar.SystemMenuTopBar)
local SquadAddFriendsIconButton = require(AppChat.Components.Squads.SquadAddFriendsIconButton)
local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)
local FFlagAppChatConsoleFocusFixes = require(AppChat.Flags.FFlagAppChatConsoleFocusFixes)
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)
local useChatWideModeFocus = require(AppChat.Contexts.ChatWideModeFocus.useChatWideModeFocus)

local tbl1 = {
    configureTopBar = configureTopBarWithNavigationOptions,
    createNewNavigator = conversationStackNavigator
}

function ConversationStackNavigatorConnector(arg1)
    local var1 = Cryo.Dictionary.union(tbl1, arg1)

    local var2 = useStyle()
    local var3 = useChatWideModeFocus()

    local var4, var5 = React.useState(UserGameSettings.ReducedMotion)

    React.useEffect(function()
        local connection = UserGameSettings:GetPropertyChangedSignal("ReducedMotion"):Connect(function()
            var5(UserGameSettings.ReducedMotion)
        end)
        return function()
            connection:Disconnect()
        end
    end, {})

    local var6 = React.useMemo(function()
        local newNavigator = var1.createNewNavigator({ cardColor3 = var2.Theme.BackgroundDefault.Color, transparent = true }, var4)

        var1.setRouter(newNavigator.router)
        return newNavigator
    end, {
        var2.Theme.BackgroundDefault.Color,
        var4,
        var1.createNewNavigator,
        var1.setRouter
    })
    local element = nil
    if FFlagAppChatPerfTracking then
        AppChatPerfTracker.start(AppChatPerfTracker.Events.TopBarRenderInterval)
    end
    local state = var1.navigation and var1.navigation.state
    local routeName = state and state.routes and state.index and state.routes[state.index] and state.routes[state.index].routeName or nil

    if routeName == EnumScreens.ChatConversation then
        element = React.createElement(ChatConversationTopBar, { screenName = EnumScreens.ChatConversation, navigation = var1.navigation })
    elseif routeName == EnumScreens.ChatDetails then
        element = React.createElement(ChatTopBarBase, { screenName = EnumScreens.ChatDetails, navigation = var1.navigation })
    elseif routeName == EnumScreens.SquadLobby then
        element = React.createElement(ChatTopBarBase, {
            screenName = EnumScreens.SquadLobby,
            navigation = var1.navigation,
            renderRight = function()
                return React.createElement(SquadAddFriendsIconButton, { navigation = var1.navigation })
            end
        })
    elseif routeName == EnumScreens.SquadInviteFriends then
        element = React.createElement(SystemMenuTopBar, { screenName = EnumScreens.SquadInviteFriends, navigation = var1.navigation })
    end

    local var7 = element or var1.configureTopBar(var1.navigation)

    local screenProps = var1.navigation.getScreenProps("topBarHeight", 0)

    local createElement = React.createElement
    local fragment = React.Fragment
    local var8 = nil
    local tbl2 = {
        layout = React.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
        topBar = 0,
        navigatorFrame = 0
    }
    if FFlagAppChatConsoleFocusFixes then
        var7 = React.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, screenProps),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            LayoutOrder = -1,
            ref = var3 and var3.conversationTopBarRef
        }, { Content = var7 })
    end

    tbl2.topBar = var7

    tbl2.navigatorFrame = React.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, -screenProps),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ref = if FFlagAppChatConsoleFocusFixes and var3 then var3.conversationPanelRef else nil
    }, {
        navigator = React.createElement(var6, var1)
    })
    return createElement(fragment, var8, tbl2)
end

local var1 = React.PureComponent:extend("ConversationStackNavigatorConnectorWrapper")

var1.router = conversationStackNavigator().router

function var1.init(arg1)
    function arg1.setRouter(router)
        var1.router = router
    end
end

function var1.render(arg1)
    return React.createElement(
        ConversationStackNavigatorConnector,
        Cryo.Dictionary.join(arg1.props, { setRouter = arg1.setRouter })
    )
end

return var1
