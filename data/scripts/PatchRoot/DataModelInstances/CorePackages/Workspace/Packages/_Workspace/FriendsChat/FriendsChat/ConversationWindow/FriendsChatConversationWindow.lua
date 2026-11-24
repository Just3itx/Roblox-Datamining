-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local FriendsChat = script:FindFirstAncestor("FriendsChat")
local FriendsChatParent = FriendsChat.Parent

local React = require(FriendsChatParent.React)
local Signals = require(FriendsChatParent.Signals)
local SignalsReact = require(FriendsChatParent.SignalsReact)
local AppChatNetworking = require(FriendsChatParent.AppChatNetworking)
local ChatUIPrimitives = require(FriendsChatParent.ChatUIPrimitives)
local SharedFlags = require(FriendsChatParent.SharedFlags)

local _ConversationChannels = require(FriendsChatParent.AppChat.ConversationChannels)
local GetConversationMessageListStore = require(FriendsChatParent.AppChat.GetConversationMessageListStore)
local GetConversationStore = require(FriendsChatParent.AppChat.GetConversationStore)

local FFlagDebugFriendsChat = require(script.Parent.Parent.Flags.FFlagDebugFriendsChat)
local FFlagFriendsChatBubbleMessages = require(script.Parent.Parent.Flags.FFlagFriendsChatBubbleMessages)
local FFlagFriendsChatMessageListHeaderFade = require(script.Parent.Parent.Flags.FFlagFriendsChatMessageListHeaderFade)
local FFlagFriendsChatPaginateOlderMessages = require(script.Parent.Parent.Flags.FFlagFriendsChatPaginateOlderMessages)
local FIntFriendsChatBubbleMaxMessages = require(script.Parent.Parent.Flags.FIntFriendsChatBubbleMaxMessages)
local FFlagFriendsChatConversationListFocusNav = SharedFlags.FFlagFriendsChatConversationListFocusNav
local FStringDebugFriendsChatConversationId = require(script.Parent.Parent.Flags.FStringDebugFriendsChatConversationId)

local useInterpolatedClientSettings = require(FriendsChatParent.ExpChatIntegration.useInterpolatedClientSettings)
local useChatWindowSettings = require(FriendsChatParent.ExpChatIntegration.useChatWindowSettings)
local ExpChatConversationListAdapter = require(script.Parent.Parent.ConversationList.ExpChatConversationListAdapter)
local FriendsChatConversationHeaderBar = require(script.Parent.Parent.HeaderBar.FriendsChatConversationHeaderBar)
local FriendsChatBubbleMessageListContainer = require(script.Parent.FriendsChatBubbleMessageListContainer)
local FriendsChatChatWindowSlot = require(script.Parent.FriendsChatChatWindowSlot)
local FriendsChatInputBarHost = require(script.Parent.FriendsChatInputBarHost)
local useFocusInputBarOnWindowEnter = require(script.Parent.useFocusInputBarOnWindowEnter)
local FriendsChatOsaAcknowledgement = require(script.Parent.FriendsChatOsaAcknowledgement)
local useConversationHeaderFadeLayout = require(script.Parent.useConversationHeaderFadeLayout)
local useConversationHeaderProps = require(script.Parent.useConversationHeaderProps)
local useConversationModerationType = require(script.Parent.useConversationModerationType)
local useFetchAllOlderMessages = require(script.Parent.useFetchAllOlderMessages)
local useFetchNewestMessagePage = require(script.Parent.useFetchNewestMessagePage)
local resolveFade = require(script.Parent.Parent.Utils.resolveFade)
local LayoutConstants = require(FriendsChat.LayoutConstants)

local useFriendsChatConversationTelemetry = require(script.Parent.Parent.Telemetry.ChatConversation.useFriendsChatConversationTelemetry)

local function FriendsChatConversationWindow(tbl1)
    local var1 = useChatWindowSettings()
    local var2 = React.useMemo(function()
        return {
            BackgroundColor3 = var1.ChatWindowBackgroundColor3,
            BackgroundTransparency = var1.ChatWindowBackgroundTransparency
        }
    end, { var1 })
    local chatWindowSettings = tbl1.chatWindowSettings or var2
    local var4 = useInterpolatedClientSettings(chatWindowSettings)

    local conversationId = tbl1.conversationId or ""
    if conversationId == "" and FFlagDebugFriendsChat then
        conversationId = FStringDebugFriendsChatConversationId
    end
    local hasConversationId = conversationId ~= ""

    local localPlayer = Players.LocalPlayer
    local localUserId = if localPlayer then localPlayer.UserId else 0

    local var5 = ExpChatConversationListAdapter.isFriendPlaceholder(conversationId)
    local isRealConversation = hasConversationId and not var5
    local var6 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local var6 = GetConversationStore(arg1).getConversation(conversationId, arg1)
            return if var6 then var6.osaAcknowledgementStatus else nil
        end)
    end, { conversationId })

    local shouldOpenToOsaSystemMessage = SignalsReact.useSignalState(var6) == AppChatNetworking.Constants.OsaAcknowledgementStatusResponse.Unacknowledged
        and not FriendsChatOsaAcknowledgement.hasSubmitted(conversationId)
    local var7 = useConversationHeaderProps(
        {
            conversationId = conversationId,
            hasConversationId = hasConversationId,
            localUserId = localUserId
        }
    )

    local conversationModerationType = useConversationModerationType({ conversationId = conversationId, hasConversationId = hasConversationId })

    React.useEffect(function()
        if hasConversationId then
            ExpChatConversationListAdapter.markConversationRead(conversationId)
        end
    end, { conversationId, hasConversationId })

    local var9 = useFetchNewestMessagePage(conversationId, isRealConversation, FFlagFriendsChatBubbleMessages)

    local var10 = FFlagFriendsChatPaginateOlderMessages and FFlagFriendsChatBubbleMessages

    if var10 then
        if FIntFriendsChatBubbleMaxMessages == 0 then
            var10 = isRealConversation and shouldOpenToOsaSystemMessage
        else
            var10 = false
        end
    end
    local var11 = not FFlagFriendsChatPaginateOlderMessages or useFetchAllOlderMessages(conversationId, var10 and var9)

    local getLoadedMessageCount = React.useCallback(function(): number
        if hasConversationId then
            return #GetConversationMessageListStore(false).getOrderedIds(conversationId, false)
        end

        return 0
    end, { conversationId, hasConversationId })

    local var13 = useFriendsChatConversationTelemetry({ conversationId = conversationId, getLoadedMessageCount = getLoadedMessageCount })

    local parentLayoutOrder = tbl1.parentLayoutOrder or 1

    local onOpenDetails = tbl1.onOpenDetails
    local fireInfoButtonClicked = var13.fireInfoButtonClicked
    local var14 = React.useCallback(function()
        fireInfoButtonClicked()
        onOpenDetails(conversationId)
    end, { fireInfoButtonClicked, onOpenDetails, conversationId })

    local fadeLayout = useConversationHeaderFadeLayout({ transparencyValue = tbl1.transparencyValue, conversationId = conversationId })

    local var16 = React.useRef(nil)
    if not FFlagFriendsChatConversationListFocusNav then
        var16 = nil
    end

    local var17 = React.useRef(nil)
    local var18 = React.useRef(nil)
    local ref = if FFlagFriendsChatConversationListFocusNav then var17 else nil
    local rootRef = if FFlagFriendsChatConversationListFocusNav then var18 else nil
    useFocusInputBarOnWindowEnter(var17, var18)

    local createElement = React.createElement
    local var21 = FriendsChatConversationHeaderBar
    local tbl2 = {
        layoutOrder = 1,
        backButtonRef = var16,
        localUserId = localUserId,
        participantUserIds = if var7 then var7.participantUserIds else nil,
        titleText = if var7 then var7.titleText else nil,
        chatWindowSettings = chatWindowSettings,
        suppressBackground = true,
        transparencyValue = tbl1.transparencyValue,
        onHovered = tbl1.onHovered,
        onUnhovered = tbl1.onUnhovered,
        onBack = tbl1.onBack,
        onActivated = 0,
        onAbsoluteSizeChanged = 0,
        interactable = 0,
        zIndex = 2
    }

    if not (tbl1.onOpenDetails and isRealConversation) then
        var14 = nil
    end

    tbl2.onActivated = var14
    tbl2.onAbsoluteSizeChanged = fadeLayout.onHeaderAbsoluteSizeChanged
    tbl2.interactable = fadeLayout.headerInteractable
    local header = createElement(var21, tbl2)
    local element2

    if FFlagFriendsChatBubbleMessages then
        element2 = React.createElement(FriendsChatBubbleMessageListContainer, {
            layoutOrder = 2,
            conversationId = conversationId,
            hasConversationId = hasConversationId,
            isRealConversation = isRealConversation,
            hasLoadedNewestPage = var9 and var11,
            shouldOpenToOsaSystemMessage = shouldOpenToOsaSystemMessage,
            topInset = if FFlagFriendsChatMessageListHeaderFade and ChatUIPrimitives.Flags.FFlagExpChatMessageListScrollParity then fadeLayout.headerVisibleHeight else fadeLayout.headerHeight,
            chatWindowSettings = chatWindowSettings,
            isSpatialUIEnabled = tbl1.isSpatialUIEnabled,
            textTransparency = tbl1.textTransparency,
            onHovered = tbl1.onHovered,
            onUnhovered = tbl1.onUnhovered,
            onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged,
            onAbsolutePositionChanged = tbl1.onAbsolutePositionChanged
        })
    else
        element2 = React.createElement(FriendsChatChatWindowSlot, {
            layoutOrder = 2,
            conversationId = conversationId,
            hasConversationId = hasConversationId,
            fadeLayout = fadeLayout,
            hostChatWindowSettings = tbl1.chatWindowSettings,
            chatWindowSettings = chatWindowSettings,
            transparencyValue = tbl1.transparencyValue,
            textTransparency = tbl1.textTransparency,
            isSpatialUIEnabled = tbl1.isSpatialUIEnabled,
            isChannelBarVisible = tbl1.isChannelBarVisible,
            shouldOpenToOsaSystemMessage = shouldOpenToOsaSystemMessage,
            onHovered = tbl1.onHovered,
            onUnhovered = tbl1.onUnhovered,
            onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged,
            onAbsolutePositionChanged = tbl1.onAbsolutePositionChanged
        })
    end
    return React.createElement(React.Fragment, nil, {
        friendsChatHeaderWindow = React.createElement("Frame", {
            Name = "FriendsChatHeaderWindow",
            LayoutOrder = parentLayoutOrder,
            BackgroundColor3 = var4.BackgroundColor3 or var4.BackgroundColor or var1.ChatWindowBackgroundColor3,
            BackgroundTransparency = resolveFade(var4.BackgroundTransparency, tbl1.transparencyValue),
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, LayoutConstants.PanelTopSpacerHeight),
            ref = ref
        }, {
            layout = React.createElement("UIListLayout", {
                Name = "FriendsChatHeaderWindowLayout",
                FillDirection = Enum.FillDirection.Vertical,
                Padding = fadeLayout.headerLayoutPadding,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            header = header,
            windowSlot = element2
        }),
        friendsChatInput = React.createElement(FriendsChatInputBarHost, {
            LayoutOrder = parentLayoutOrder + 1,
            conversationId = conversationId,
            conversationModerationType = conversationModerationType,
            onFriendPlaceholderConversationCreated = tbl1.onFriendPlaceholderConversationCreated,
            chatWindowSettings = tbl1.chatWindowSettings,
            transparencyValue = tbl1.transparencyValue,
            isSpatialUIEnabled = tbl1.isSpatialUIEnabled,
            onHovered = tbl1.onHovered,
            onUnhovered = tbl1.onUnhovered,
            backButtonRef = var16,
            rootRef = rootRef
        })
    })
end

return FriendsChatConversationWindow
