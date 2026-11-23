-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local EnumScreens = require(AppChat.EnumScreens)

local Roact = require(AppChatParent.Roact)

local LeaveGroupDialogContainer = require(script.Parent.LeaveGroupDialogContainer)
local Logger = require(script.Parent.Logger)

local var1 = Roact.PureComponent:extend("LeaveGroupDialogScreen")
var1.defaultProps = { navigation = nil }

function var1.init(arg1)
    function arg1.onLeaveGroupDialogClose()
        arg1.props.navigation.goBack()
    end

    function arg1.onLeaveGroupSuccess()
        local navigation = arg1.props.navigation
        if navigation.getParam("isRooted", false) then
            Logger:info("Close rooted ChatDetails after leave from {screen}")
            local screenProps = navigation.getScreenProps("navigateToRootStack", nil)
            if screenProps then
                screenProps()
                return
            end

            if navigation.isFocused() then
                navigation.goBack()
            end
        elseif navigation.getScreenProps("wideMode", false) then
            Logger:info("Navigate To ChatLanding with EmptyConversation from {screen}")

            navigation.navigate(EnumScreens.EmptyConversation)
        else
            Logger:info("Navigate To ChatLanding from {screen}")
            navigation.navigate(EnumScreens.ChatLanding)
        end
    end
end

function var1.render(arg1)
    local navigation = arg1.props.navigation
    assert(type(navigation) ~= "nil", "LeaveGroupDialogScreen should be wrapped with Roact Navigation")

    local conversationId = navigation.getParam("conversationId", nil)
    if conversationId == nil then
        Logger:warning("ConversationId is required to open {screen}")
        return nil
    end

    local isRooted = navigation.getParam("isRooted", false)

    return Roact.createElement(LeaveGroupDialogContainer, {
        conversationId = conversationId,
        isRooted = isRooted,
        onModalClose = arg1.onLeaveGroupDialogClose,
        onLeaveSuccess = arg1.onLeaveGroupSuccess
    })
end

function var1.didMount(_)
    Logger:info("{screen} mounted")
end

return var1
