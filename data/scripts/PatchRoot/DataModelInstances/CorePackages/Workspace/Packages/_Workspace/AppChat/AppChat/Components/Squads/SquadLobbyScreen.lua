-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local EnumScreens = require(AppChat.EnumScreens)
local AppChatParent = AppChat.Parent
local SharedFlags = require(AppChatParent.SharedFlags)

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local _ModelTypes = require(AppChatParent.Squads.ModelTypes)
local SquadLobby = require(AppChatParent.Squads.SquadLobby)
local SquadAddFriendsIconButton = require(script.Parent.SquadAddFriendsIconButton)
local RoactNavigation = require(AppChatParent.RoactNavigation)

local var1 = React.PureComponent:extend("SquadLobbyScreen")

local ChatPlacementContext = require(AppChat.Contexts.ChatPlacementContext)
local withChatPlacementContext = ChatPlacementContext.withChatPlacementContext
local ParentContainerContext = require(AppChat.Contexts.ParentContainer.ParentContainerContext)

local FFlagEnablePartyVoiceChangersInLua = SharedFlags.FFlagEnablePartyVoiceChangersInLua
local FFlagAppChatIxpScreenExposure = require(AppChat.Flags.FFlagAppChatIxpScreenExposure)

local IXPNavigationUtils = require(AppChat.Utils.IXPNavigationUtils)
local GetTopBarStore = require(AppChat.Stores.GetTopBarStore)

local tbl1 = { EnumScreens.SquadLobby, EnumScreens.SquadInviteFriends, EnumScreens.SquadVoiceReportAbuse }

if FFlagEnablePartyVoiceChangersInLua then
    local squadVoiceChangers = EnumScreens.SquadVoiceChangers
    table.insert(tbl1, squadVoiceChangers)
end

local function navigationOptions(arg1)
    local navigation = arg1.navigation

    return {
        renderRight = function()
            return React.createElement(SquadAddFriendsIconButton, { navigation = navigation })
        end
    }
end

function var1.init(arg1)
    arg1.ixpSubscription = if FFlagAppChatIxpScreenExposure then IXPNavigationUtils.registerExposureOnFocus(arg1.props.navigation, "Party.PartyLobbyPage") else nil

    local navigation = arg1.props.navigation

    GetTopBarStore(false).setScreenTopBar(EnumScreens.SquadLobby, { backButtonEnabled = true })

    arg1.state = {
        isFocused = navigation.isFocused()
    }
    arg1.willFocusSubscription = navigation.addListener(RoactNavigation.Events.WillFocus, function()
        arg1:setState({ isFocused = true })
    end)
    arg1.didBlurSubscription = navigation.addListener(RoactNavigation.Events.DidBlur, function()
        arg1:setState({ isFocused = false })
    end)

    arg1.hasNavigatedAwayFromSquad = false

    function arg1.navigateToHomePage(_)
        local var2 = arg1.props.navigation.getScreenProps("navigateToLuaAppPages", {})[EnumScreens.Home]

        if var2 then
            var2()
        end
    end

    function arg1.openViewProfile(str1: string)
        local var2 = arg1.props.navigation.getScreenProps("navigateToLuaAppPages", {})[EnumScreens.ViewUserProfile]
        if var2 then
            var2(str1, {})
        end
    end

    function arg1.openSquadVoiceAbuseReport(reportData)
        arg1.props.navigation.navigate(EnumScreens.SquadVoiceReportAbuse, { reportData = reportData })
    end

    if FFlagEnablePartyVoiceChangersInLua then
        function arg1.openSquadVoiceChangers()
            arg1.props.navigation.navigate(EnumScreens.SquadVoiceChangers)
        end
    end

    function arg1.navigateToSquadInviteFriends(conversationId)
        arg1.props.navigation.navigate(EnumScreens.SquadInviteFriends, { conversationId = conversationId })
    end

    function arg1.navigateAwayFromSquad()
        if arg1.hasNavigatedAwayFromSquad then
            return
        end

        local var2 = arg1.props.navigation._dangerouslyGetParent()
        if not var2 then
            return
        end

        local state = var2.state
        if not state then
            return
        end
        local key = nil

        for i = state.index, 1, -1 do
            local var3 = state.routes[i]
            if not table.find(tbl1, var3.routeName) then
                if key then
                    arg1.hasNavigatedAwayFromSquad = true
                    arg1.props.navigation.goBack(key)
                end
                return
            end

            key = var3.key
        end
    end
end

function var1.willUnmount(arg1)
    if arg1.ixpSubscription then
        arg1.ixpSubscription.remove()
    end
    if arg1.willFocusSubscription then
        arg1.willFocusSubscription:remove()
    end
    if arg1.didBlurSubscription then
        arg1.didBlurSubscription:remove()
    end
end

function var1.render(arg1)
    return withChatPlacementContext(function(arg2)
        local isFocused = arg1.state.isFocused
        local isInExperience = ChatPlacementContext.isPlacementInExperience(arg2.chatPlacement)

        if not isFocused then
            return nil
        end

        local function func2(navigateToChat)
            return React.createElement(SquadLobby, {
                navigateToHomePage = arg1.navigateToHomePage,
                openViewProfile = arg1.openViewProfile,
                openSquadVoiceAbuseReport = arg1.openSquadVoiceAbuseReport,
                navigateAwayFromSquad = arg1.navigateAwayFromSquad,
                navigateToChat = navigateToChat,
                navigateToSquadInviteFriends = arg1.navigateToSquadInviteFriends,
                openSquadVoiceChangers = if FFlagEnablePartyVoiceChangersInLua then arg1.openSquadVoiceChangers else nil,
                isInExperience = isInExperience,
                isWideMode = arg1.props.isWideMode
            })
        end

        if not isInExperience then
            return func2(nil)
        end

        return React.createElement(ParentContainerContext.Consumer, {
            render = function(arg3)
                return func2(function(arg4)
                    return arg3.openFriendsChatConversation(arg4):andThen(function<T>(arg5: T): T
                        arg1.navigateAwayFromSquad()
                        return arg5
                    end)
                end)
            end
        })
    end)
end

local WideSquadLobbyScreen = React.PureComponent:extend("WideSquadLobbyScreen")
WideSquadLobbyScreen.navigationOptions = navigationOptions
function WideSquadLobbyScreen.init(_) end

function WideSquadLobbyScreen.render(arg1)
    return React.createElement(var1, Cryo.Dictionary.union(arg1.props, { isWideMode = true }))
end

local CompactSquadLobbyScreen = React.PureComponent:extend("CompactSquadLobbyScreen")
CompactSquadLobbyScreen.navigationOptions = navigationOptions
function CompactSquadLobbyScreen.init(_) end

function CompactSquadLobbyScreen.render(arg1)
    return React.createElement(var1, Cryo.Dictionary.union(arg1.props, { isWideMode = false }))
end

return {
    WideSquadLobbyScreen = WideSquadLobbyScreen,
    CompactSquadLobbyScreen = CompactSquadLobbyScreen
}
