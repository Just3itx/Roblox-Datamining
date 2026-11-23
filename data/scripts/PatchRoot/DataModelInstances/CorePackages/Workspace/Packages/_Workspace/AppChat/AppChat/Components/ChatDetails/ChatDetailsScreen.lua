-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local EnumScreens = require(AppChat.EnumScreens)
local Roact = require(AppChatParent.Roact)

local ChatDetailsContainer = require(script.Parent.ChatDetailsContainer)
local ChatDetailsNavigationOptions = require(script.Parent.ChatDetailsNavigationOptions)
local Logger = require(script.Parent.Logger)

local FFlagAppChatIxpScreenExposure = require(AppChat.Flags.FFlagAppChatIxpScreenExposure)

local IXPNavigationUtils = require(AppChat.Utils.IXPNavigationUtils)
local GetTopBarStore = require(AppChat.Stores.GetTopBarStore)
local GetRootedNavigationStore = require(AppChat.Stores.GetRootedNavigationStore)

local var1 = Roact.PureComponent:extend("ChatDetailsScreen")
var1.defaultProps = { navigation = nil }

var1.navigationOptions = ChatDetailsNavigationOptions.getNavigationOptions

function var1.init(arg1)
    arg1.ixpSubscription = if FFlagAppChatIxpScreenExposure then IXPNavigationUtils.registerExposureOnFocus(arg1.props.navigation, "Party.ChatDetailsPage") else nil

    function arg1.navigateToEditChatMembers(conversation)
        Logger:info("Navigate To EditChatMembers from {screen}")
        arg1.props.navigation.navigate(
            EnumScreens.EditChatMembers,
            {
                conversation = conversation,
                isRooted = arg1.props.navigation.getParam("isRooted", false)
            }
        )
    end
    function arg1.navigateToToast(arg2)
        Logger:info("Navigate To Toast from {screen}")
        arg1.props.navigation.navigate(EnumScreens.RoactChatToast, arg2)
    end

    function arg1.navigateToDialog(arg2, arg3)
        Logger:info("Navigate To {} from {screen}", arg2)
        arg1.props.navigation.navigate(arg2, arg3)
    end

    function arg1.closeRootedChatDetails()
        local screenProps = arg1.props.navigation.getScreenProps("navigateToRootStack", nil)
        if screenProps then
            screenProps()
        elseif arg1.props.navigation.isFocused() then
            arg1.props.navigation.goBack()
        end
    end

    function arg1.navigateBack()
        if not arg1.props.navigation.isFocused() then
            return
        end

        if arg1.props.navigation.getParam("isRooted", false) then
            arg1.closeRootedChatDetails()
            return
        end
        arg1.props.navigation.goBack()
    end

    function arg1.navigateToConversation(conversationId)
        Logger:info("Navigate To Conversation from {screen}")
        arg1.props.navigation.navigate(
            EnumScreens.ChatConversation,
            {
                conversationId = conversationId,
                isRooted = arg1.props.navigation.getParam("isRooted", false)
            }
        )
    end
    function arg1.navigateToChatLanding()
        Logger:info("Navigate To ChatLanding from {screen}")
        if arg1.props.navigation.getParam("isRooted", false) then
            arg1.closeRootedChatDetails()
            return
        end

        if arg1.props.navigation.getScreenProps("wideMode", false) then
            arg1.props.navigation.navigate(EnumScreens.EmptyConversation)
        else
            arg1.props.navigation.navigate(EnumScreens.ChatLanding)
        end
    end
end

function var1.render(arg1)
    local navigation = arg1.props.navigation
    assert(type(navigation) ~= "nil", "ChatDetailsScreen should be wrapped with Roact Navigation")

    local conversationId = navigation.getParam("conversationId", nil)
    if conversationId == nil then
        Logger:warning("ConversationId is required to open {screen}")
        return nil
    end

    return Roact.createElement(ChatDetailsContainer, {
        topBarHeight = navigation.getScreenProps("topBarHeight", 0),
        wideMode = navigation.getScreenProps("wideMode", false),
        conversationId = conversationId,
        navigateBack = arg1.navigateBack,
        navigateToEditChatMembers = arg1.navigateToEditChatMembers,
        navigateToDialog = arg1.navigateToDialog,
        navigateToToast = arg1.navigateToToast,
        navigateToConversation = arg1.navigateToConversation,
        navigateToChatLanding = arg1.navigateToChatLanding
    })
end

function var1.didMount(arg1)
    Logger:info("{screen} mounted")

    GetTopBarStore(false).setScreenTopBar(
        EnumScreens.ChatDetails,
        ChatDetailsNavigationOptions.getTopBarConfig(arg1.props.navigation)
    )

    if arg1.props.navigation.getParam("isRooted", false) then
        GetRootedNavigationStore(false).completeNavigation(arg1.props.navigation.getParam("rootedNavigationRequestId", nil))
    end
end

function var1.willUnmount(arg1)
    if arg1.ixpSubscription then
        arg1.ixpSubscription.remove()
    end
end

return var1
