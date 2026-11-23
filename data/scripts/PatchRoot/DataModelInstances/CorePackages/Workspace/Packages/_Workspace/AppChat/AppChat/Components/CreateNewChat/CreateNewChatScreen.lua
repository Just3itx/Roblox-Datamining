-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local EnumScreens = require(AppChat.EnumScreens)
local ArgCheck = require(AppChatParent.ArgCheck)
local Roact = require(AppChatParent.Roact)
local UniversalAppPolicy = require(AppChatParent.UniversalAppPolicy)

local GetTopBarStore = require(AppChat.Stores.GetTopBarStore)

local CreateNewChatContainer = require(script.Parent.CreateNewChatContainer)
local Logger = require(script.Parent.Logger)

local GetFFlagIsSquadEnabled = require(AppChatParent.SharedFlags).GetFFlagIsSquadEnabled
local FFlagAppChatIxpScreenExposure = require(AppChat.Flags.FFlagAppChatIxpScreenExposure)

local IXPNavigationUtils = require(AppChat.Utils.IXPNavigationUtils)

local var1 = Roact.PureComponent:extend("CreateNewChatScreen")
var1.defaultProps = {}

local function getTabBarVisible(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local navigation = arg1 and arg1.navigation
    if navigation and navigation.getScreenProps then
        return (navigation.getScreenProps("wideMode", false))
    end

    return false
end

function var1.navigationOptions(arg1)
    return {
        tabBarVisible = getTabBarVisible(arg1)
    }
end

function var1.init(arg1)
    arg1.ixpSubscription = if FFlagAppChatIxpScreenExposure then IXPNavigationUtils.registerExposureOnFocus(arg1.props.navigation, "Party.ChatMembersPage") else nil

    function arg1.navigateToConversation(conversationId)
        local navigation = arg1.props.navigation
        Logger:info("Navigate To Conversation: {} from {screen}", conversationId)

        if navigation.getScreenProps("wideMode", false) then
            navigation.navigate(EnumScreens.ChatConversation, { conversationId = conversationId })
            return
        end
        navigation.replace(EnumScreens.ChatConversation, { conversationId = conversationId })
    end

    function arg1.navigateToToast(arg2)
        Logger:info("Navigate To Toast from {screen}")
        arg1.props.navigation.navigate(EnumScreens.RoactChatToast, arg2)
    end

    function arg1.setSystemButtonActivated(systemButtonActivated)
        GetTopBarStore(false).setScreenTopBar(EnumScreens.CreateNewChat, { systemButtonActivated = systemButtonActivated })
    end

    function arg1.setSystemButtonEnabled(systemButtonEnabled)
        GetTopBarStore(false).setScreenTopBar(EnumScreens.CreateNewChat, { systemButtonEnabled = systemButtonEnabled })
    end
end

function var1.render(arg1)
    local var2 = ArgCheck.isNotNil(arg1.props.navigation, "navigation in CreateNewChatScreen")

    return Roact.createElement(CreateNewChatContainer, {
        topBarHeight = var2.getScreenProps("topBarHeight", 0),
        navigateToConversation = arg1.navigateToConversation,
        navigateToToast = arg1.navigateToToast,
        setSystemButtonActivated = arg1.setSystemButtonActivated,
        setSystemButtonEnabled = arg1.setSystemButtonEnabled
    })
end

function var1.didMount(arg1)
    Logger:info("{screen} mounted")
    GetTopBarStore(false).setScreenTopBar(EnumScreens.CreateNewChat, {
        headerText = {
            raw = if GetFFlagIsSquadEnabled() then if UniversalAppPolicy.getAppFeaturePolicies().getCanSeeChatTerminology() then "Feature.Chat.Title.NewChat" else "Feature.Chat.Heading.PartyWithFriends" else "Feature.Chat.Heading.ChatWithConnections",
            shouldLocalize = true
        },
        backButtonEnabled = true,
        systemButtonText = if GetFFlagIsSquadEnabled() then "Feature.Chat.Action.Create" else "Feature.Chat.Action.StartChatWithFriends"
    })

    arg1.setSystemButtonEnabled(false)
end

function var1.willUnmount(arg1)
    GetTopBarStore(false).clearScreenTopBar(EnumScreens.CreateNewChat)
    if arg1.ixpSubscription then
        arg1.ixpSubscription.remove()
    end
end

return var1
