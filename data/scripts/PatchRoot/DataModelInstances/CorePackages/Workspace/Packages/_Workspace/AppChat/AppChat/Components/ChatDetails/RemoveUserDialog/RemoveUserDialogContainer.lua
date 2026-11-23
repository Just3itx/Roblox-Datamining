-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local populateUserWithState = require(AppChat.Users.populateUserWithState)
local _types = require(AppChat.types)

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local memo = React.memo
local useCallback = React.useCallback
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local useState = React.useState

local RemoveUserDialogLayout = require(script.Parent.RemoveUserDialogLayout)

local GetFFlagIsSquadEnabled = require(AppChatParent.SharedFlags).GetFFlagIsSquadEnabled

local tbl1 = {
    participantId = nil,
    onModalClose = function() end,
    titleKey = "Feature.Chat.Action.RemoveUser",
    messageKey = if GetFFlagIsSquadEnabled() then "Feature.Chat.Message.RemoveUser.V2" else "Feature.Chat.Message.RemoveUser",
    cancelTitleKey = "Feature.Chat.Action.Cancel",
    confirmationTitleKey = "Feature.Chat.Action.Remove",
    failureTitleKey = "Feature.Chat.Heading.FailedToRemoveUser",
    failureBodyKey = if GetFFlagIsSquadEnabled() then "Feature.Chat.Message.FailedToRemoveUser.V2" else "Feature.Chat.Message.FailedToRemoveUser",
    failureButtonKey = "Feature.Chat.Action.Confirm"
}

function RemoveUserDialogContainer(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local isModalVisible, var3 = useState(true)
    local isLoading, var5 = useState(false)
    local displayFailed, var7 = useState(false)

    local var8 = useDispatch()
    local var9 = useCallback(function(arg1, arg2)
        return var8(AppChatNetworking.rodux.RemoveUserFromConversation.API(arg2, arg1))
    end, { var8 })

    local var10 = useSelector(function(arg1)
        local var10 = arg1.ChatAppReducer.Conversations[var1.conversationId] or { title = nil }

        local user = arg1.Users[var1.participantId]

        return {
            conversationTitle = var10.title,
            targetUser = populateUserWithState(arg1, user)
        }
    end)

    local onActivated = useCallback(function(): boolean
        var5(true)
        var3(false)

        local conversationId = var1.conversationId
        if conversationId then
            var9(var1.participantId, conversationId):andThen(function()
                var1.onModalClose()
            end):catch(function()
                var5(false)
                var3(true)
                var7(true)
            end)
        end

        return true
    end, { var1.participantId, var1.conversationId })

    local var12 = useLocalization({
        titleText = var1.titleKey,
        bodyText = {
            var1.messageKey,
            USERNAME = var10.targetUser.displayName
        },
        cancelText = var1.cancelTitleKey,
        confirmText = var1.confirmationTitleKey,
        failureTitleText = "Feature.Chat.Heading.FailedToRemoveUser",
        failureBodyText = {
            var1.failureBodyKey,
            USERNAME = var10.targetUser.displayName,
            CONVERSATION_TITLE = var10.conversationTitle
        },
        failureButtonText = "Feature.Chat.Action.Confirm"
    })

    return React.createElement(
        RemoveUserDialogLayout,
        Cryo.Dictionary.join(
            var1,
            var12,
            var10,
            {
                onActivated = onActivated,
                displayFailed = displayFailed,
                isModalVisible = isModalVisible,
                isLoading = isLoading
            }
        )
    )
end
return memo(RemoveUserDialogContainer)
