-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local SocialLibraries = require(AppChat.SocialLibraries)
local _types = require(AppChat.types)

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local memo = React.memo
local useCallback = React.useCallback
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useEffectOnMount = require(AppChatParent.RoactUtils).Hooks.useEffectOnMount
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local useState = React.useState
local useTelemetry = require(AppChat.Telemetry.useTelemetry)
local ChatDetailsTelemetryEvents = require(AppChat.Components.ChatDetails.ChatDetailsTelemetryEvents)
local ChatDialogTelemetryLayer = require(AppChat.Telemetry.Layers.ChatDialogTelemetryLayer)

local ResponseIndicator = SocialLibraries.Components.ResponseIndicator

local LeaveGroupDialog = require(script.Parent.LeaveGroupDialog)
local RemovedConversation = require(AppChat.Conversations.Actions.RemovedConversation)

local GetFFlagIsSquadEnabled = require(AppChatParent.SharedFlags).GetFFlagIsSquadEnabled

local tbl1 = {
    isRooted = false,
    onModalClose = function() end,
    onLeaveSuccess = function() end,
    titleKey = "Feature.Chat.Heading.LeaveGroup",
    cancelKey = "Feature.Chat.Action.Stay",
    confirmKey = "Feature.Chat.Action.Leave",
    bodyKey = if GetFFlagIsSquadEnabled() then "Feature.Chat.Message.LeaveGroup.V2" else "Feature.Chat.Message.LeaveGroup",
    failureTitleKey = "Feature.Chat.Heading.FailedToLeaveGroup",
    failureBodyKey = if GetFFlagIsSquadEnabled() then "Feature.Chat.Message.FailedToLeaveGroup.V2" else "Feature.Chat.Message.FailedToLeaveGroup",
    failureButtonKey = "Feature.Chat.Action.Confirm"
}

function LeaveGroupDialogContainer(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2, var3 = useState(true)
    local var4, var5 = useState(false)
    local displayFailed, var7 = useState(false)
    local var8 = useTelemetry(ChatDialogTelemetryLayer.Context)

    useEffectOnMount(function()
        var8.emit(ChatDetailsTelemetryEvents.LeaveGroupDialogRendered, {})
    end)

    local var9 = useDispatch()
    local var10 = useCallback(function(arg1, arg2)
        return var9(AppChatNetworking.rodux.RemoveUserFromConversation.API(arg2, arg1))
    end, { var9 })

    local var11 = useSelector(function(arg1)
        local var11 = arg1.ChatAppReducer.Conversations[var1.conversationId] or {
            title = nil,
            hasGroupUp = nil
        }

        return {
            localUserId = arg1.LocalUserId,
            conversationTitle = var11.title,
            hasGroupUp = if GetFFlagIsSquadEnabled() then var11.hasGroupUp else nil
        }
    end)

    local onActivated = useCallback(function(): boolean
        var5(true)
        var3(false)
        var8.emit(ChatDetailsTelemetryEvents.LeaveGroupDialogLeaveClicked, {})

        if var1.conversationId then
            var10(var11.localUserId, var1.conversationId):andThen(function()
                if var1.isRooted then
                    var9(RemovedConversation(var1.conversationId))
                end
                var1.onModalClose()
                var1.onLeaveSuccess()
            end):catch(function()
                var5(false)
                var3(true)
                var7(true)
            end)
        end

        return true
    end, {
        var11.localUserId,
        var11.hasGroupUp,
        var1.conversationId,
        var1.isRooted,
        var1.onModalClose,
        var1.onLeaveSuccess,
        var9,
        var10,
        var8
    })

    local onModalClose = useCallback(function(...)
        var8.emit(ChatDetailsTelemetryEvents.LeaveGroupDialogStayClicked, {})
        var1.onModalClose(...)
    end, { var1.onModalClose, var1.conversationId, var8 })

    local var14 = useLocalization({
        titleText = var1.titleKey,
        cancelText = var1.cancelKey,
        confirmText = var1.confirmKey,
        bodyText = var1.bodyKey,
        failureTitleText = var1.failureTitleKey,
        failureBodyText = {
            var1.failureBodyKey,
            CONVERSATION_TITLE = var11.conversationTitle
        },
        failureButtonText = var1.failureButtonKey
    })

    return React.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1
    }, {
        LeaveGroupDialog = var2
            and React.createElement(
                LeaveGroupDialog,
                Cryo.Dictionary.join(
                    var1,
                    var14,
                    var11,
                    {
                        onActivated = onActivated,
                        displayFailed = displayFailed,
                        onModalClose = onModalClose
                    }
                )
            ),
        ResponseIndicator = var4
            and React.createElement(ResponseIndicator, { soakAreaColor3 = Color3.fromRGB(25, 25, 25), soakAreaTransparency = 0.8 })
    })
end

return memo(LeaveGroupDialogContainer)
