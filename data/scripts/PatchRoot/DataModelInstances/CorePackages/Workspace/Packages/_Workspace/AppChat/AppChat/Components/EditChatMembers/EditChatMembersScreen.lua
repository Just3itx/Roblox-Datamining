-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local EnumScreens = require(AppChat.EnumScreens)
local ArgCheck = require(AppChatParent.ArgCheck)
local React = require(AppChatParent.React)
local Roact = require(AppChatParent.Roact)

local ParentContainerContext = require(AppChat.Contexts.ParentContainer.ParentContainerContext)
local GetTopBarStore = require(AppChat.Stores.GetTopBarStore)

local FFlagAppChatIxpScreenExposure = require(AppChat.Flags.FFlagAppChatIxpScreenExposure)

local IXPNavigationUtils = require(AppChat.Utils.IXPNavigationUtils)

local EditChatMembersContainer = require(script.Parent.EditChatMembersContainer)
local Logger = require(script.Parent.Logger)

local function renderContainer(arg1, conversation, navigateToConversation, navigateToToast, setSystemButtonActivated, setSystemButtonEnabled)
    return Roact.createElement(EditChatMembersContainer, {
        topBarHeight = arg1.getScreenProps("topBarHeight", 0),
        conversation = conversation,
        navigateToConversation = navigateToConversation,
        navigateToToast = navigateToToast,
        setSystemButtonActivated = setSystemButtonActivated,
        setSystemButtonEnabled = setSystemButtonEnabled
    })
end

local function RootedEditChatMembersContainer(arg1)
    local var1 = React.useContext(ParentContainerContext)
    local navigateToConversation = arg1.navigateToConversation
    local openFriendsChatConversation = var1.openFriendsChatConversation
    local navigateToConversation2 = React.useCallback(function(arg2)
        openFriendsChatConversation(arg2):andThen(function(arg3)
            if not arg3 then
                Logger:warning("Failed to navigate to Friends Chat conversation {}", arg2)
                navigateToConversation(arg2)
            end
        end)
    end, { navigateToConversation, openFriendsChatConversation })

    return renderContainer(
        arg1.navigation,
        arg1.conversation,
        navigateToConversation2,
        arg1.navigateToToast,
        arg1.setSystemButtonActivated,
        arg1.setSystemButtonEnabled
    )
end

local var1 = Roact.PureComponent:extend("EditChatMembersScreen")
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
        Logger:info("Navigate To Conversation: {} from {screen}", conversationId)
        arg1.props.navigation.navigate(
            EnumScreens.ChatConversation,
            {
                conversationId = conversationId,
                isRooted = arg1.props.navigation.getParam("isRooted", false)
            }
        )
    end
    function arg1.navigateToToast(arg2)
        Logger:info("Navigate To Toast from {screen}")
        arg1.props.navigation.navigate(EnumScreens.RoactChatToast, arg2)
    end

    function arg1.setSystemButtonActivated(systemButtonActivated)
        GetTopBarStore(false).setScreenTopBar(EnumScreens.EditChatMembers, { systemButtonActivated = systemButtonActivated })
    end

    function arg1.setSystemButtonEnabled(systemButtonEnabled)
        GetTopBarStore(false).setScreenTopBar(EnumScreens.EditChatMembers, { systemButtonEnabled = systemButtonEnabled })
    end
end

function var1.render(arg1)
    local navigation = ArgCheck.isNotNil(arg1.props.navigation, "navigation in EditChatMembersScreen")

    local conversation = navigation.getParam("conversation", nil)
    if not conversation then
        Logger:warning("Conversation info required to open {screen}")
        return nil
    elseif navigation.getParam("isRooted", false) then
        return Roact.createElement(RootedEditChatMembersContainer, {
            navigation = navigation,
            conversation = conversation,
            navigateToConversation = arg1.navigateToConversation,
            navigateToToast = arg1.navigateToToast,
            setSystemButtonActivated = arg1.setSystemButtonActivated,
            setSystemButtonEnabled = arg1.setSystemButtonEnabled
        })
    else
        return renderContainer(
            navigation,
            conversation,
            arg1.navigateToConversation,
            arg1.navigateToToast,
            arg1.setSystemButtonActivated,
            arg1.setSystemButtonEnabled
        )
    end
end

function var1.didMount(arg1)
    Logger:info("{screen} mounted")
    GetTopBarStore(false).setScreenTopBar(EnumScreens.EditChatMembers, {
        headerText = { raw = "Feature.Chat.Label.AddFriends", shouldLocalize = true },
        backButtonEnabled = true,
        systemButtonText = "Feature.Chat.Action.Add"
    })

    arg1.setSystemButtonEnabled(false)
end

function var1.willUnmount(arg1)
    GetTopBarStore(false).clearScreenTopBar(EnumScreens.EditChatMembers)
    if arg1.ixpSubscription then
        arg1.ixpSubscription.remove()
    end
end

return var1
