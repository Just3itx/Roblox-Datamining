-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Foundation = require(AppChatParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local ChatConversationTelemetryEvents = require(script.Parent.ChatConversationTelemetryEvents)
local ChatConversationTelemetryLayer = require(AppChat.Telemetry.Layers.ChatConversationTelemetryLayer)
local useTelemetry = require(AppChat.Telemetry.useTelemetry)

local ConversationFacePile = require(AppChat.Components.Cells.ConversationFacePile)
local useGetConversationFromId = require(AppChat.Hooks.useGetConversationFromId)
local useGetUserFromId = require(AppChat.Hooks.useGetUserFromId)
local Conversation = require(AppChat.Models.Conversation)
local ConversationChannels = require(AppChat.Models.ConversationChannels)
local getOtherParticipants = require(AppChat.Conversations.getOtherParticipants)
local useLocalUserId = require(AppChatParent.RobloxAppHooks).useLocalUserId
local DataHydration = require(AppChatParent.DataHydration)
local Signals = require(AppChatParent.Signals)
local SignalsReact = require(AppChatParent.SignalsReact)
local FFlagUserTileUnfilteredChatIndicator = require(AppChatParent.SharedFlags).FFlagUserTileUnfilteredChatIndicator
local var1 = if FFlagUserTileUnfilteredChatIndicator then DataHydration.TrustedConnections.TrustedConnectionsStore.get() else nil

return function(tbl1)
    local var2 = useTokens()
    local var3 = useTelemetry(ChatConversationTelemetryLayer.Context)
    local onActivated = React.useCallback(function()
        var3.emit(ChatConversationTelemetryEvents.ConversationInfoBtnClicked, {})
        tbl1.navigateToChatDetails()
    end, { tbl1.navigateToChatDetails, var3 })

    local var5 = nil

    local titleText = tbl1.titleText
    local var6 = useGetConversationFromId(tbl1.conversationId)
    local var7 = useLocalUserId()

    local var8 = var6 and var6.conversationType == Conversation.Type.ONE_TO_ONE_CONVERSATION
    local var9 = if var8 then getOtherParticipants(var6, var7)[1] else nil
    local var10 = useGetUserFromId(var9)
    local var11

    if FFlagUserTileUnfilteredChatIndicator then
        local var12 = React.useMemo(function()
            return Signals.createComputed(function(arg1)
                if var9 ~= nil and var9 ~= "" then
                    return (var1.getIsTrustedConnection(var9).data(arg1))
                end

                return nil
            end)
        end, { var9 })
        var11 = SignalsReact.useSignalState(var12)
    else
        var11 = nil
    end

    if var10 then
        titleText = var6.title
        if FFlagUserTileUnfilteredChatIndicator and var11 then
            var5 = ""
        else
            var5 = `@{var10.name}`
        end
    end
    return React.createElement(Foundation.View, {
        Size = UDim2.new(1, 0, 1, 0)
    }, {
        TitleContainer = React.createElement(
            Foundation.View,
            {
                Size = UDim2.new(1, 0, 1, 0),
                Position = UDim2.new(0, 0, 0, 0),
                cornerRadius = UDim.new(0, var2.Radius.Medium)
            },
            {
                ConversationFacePile = React.createElement(ConversationFacePile, {
                    conversationId = tbl1.conversationId,
                    titleText = titleText,
                    titleStyle = var2.Typography.TitleLarge,
                    onActivated = onActivated,
                    subtitleText = var5,
                    trustedConnectionIndicatorEnabled = not not var8,
                    shouldShowUnfilteredChatIndicator = if FFlagUserTileUnfilteredChatIndicator
                        and var6 ~= nil
                        and var6.moderationType == ConversationChannels.ModerationType.TrustedComms then true else nil
                })
            }
        )
    })
end
