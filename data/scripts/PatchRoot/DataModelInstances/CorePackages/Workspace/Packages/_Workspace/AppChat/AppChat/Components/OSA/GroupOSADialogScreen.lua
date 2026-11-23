-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useNavigation = require(AppChatParent.Navigation).useNavigation

local API = require(AppChatParent.AppChatNetworking).rodux.GetConversationDetails.API
local RemovedConversation = require(AppChat.Conversations.Actions.RemovedConversation)

local EnumScreens = require(AppChat.EnumScreens)
local GroupOSADialog = require(script.Parent.GroupOSADialog)

local function GroupOSADialogScreen()
    local var1 = useNavigation()
    local var2 = useDispatch()
    local conversationId = var1.getParam("conversationId", nil)
    local impressionId = var1.getParam("impressionId", nil)
    local modalVariant = var1.getParam("modalVariant", nil)

    local onClose = React.useCallback(function()
        if var1.isFocused() then
            var1.goBack()
        end
    end, { var1 })

    local onJoin = React.useCallback(function()
        if conversationId then
            var2(API(conversationId))
        end
        var1.navigate(EnumScreens.ChatConversation, { conversationId = conversationId, isNavigatedFromGroupOSAJoin = true })
    end, { var1, conversationId, var2 })

    local onDecline = React.useCallback(function()
        if conversationId then
            var2(RemovedConversation(conversationId))
        end
        if var1.isFocused() then
            var1.goBack()
        end
    end, { var1, var2, conversationId })

    return React.createElement(GroupOSADialog, {
        conversationId = conversationId,
        onClose = onClose,
        onJoin = onJoin,
        onDecline = onDecline,
        impressionId = impressionId,
        modalVariant = modalVariant
    })
end

return GroupOSADialogScreen
