-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IXPService = game:GetService("IXPService")
local UserInputService = game:GetService("UserInputService")
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local setTimeout = require(AppChatParent.LuauPolyfill).setTimeout
local React = require(AppChatParent.React)
local ReactFocusNavigation = require(AppChatParent.ReactFocusNavigation)
local useStyle = require(AppChatParent.UIBlox).Core.Style.useStyle
local useNavigation = require(AppChatParent.Navigation).useNavigation
local useGetConversationFromId = require(AppChat.Hooks.useGetConversationFromId)
local Options = require(AppChat.Components.ChatConversation.MessageInteraction.Options)
local OptionsEnum = require(AppChat.Components.ChatConversation.MessageInteraction.OptionsEnum)
local ChatMessageContainerConstants = require(script.Parent.ChatMessageContainerConstants)
local EnumScreens = require(AppChat.EnumScreens)
local Cryo = require(AppChatParent.Cryo)
local Foundation = require(AppChatParent.Foundation)
local Skeleton = Foundation.Skeleton
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local GetTextSize = require(AppChatParent.Style).GetTextSize

local useLocalUserId = require(AppChatParent.RobloxAppHooks).useLocalUserId
local Conversation = require(AppChat.Models.Conversation)
local getReplyLabelDescriptor = require(AppChat.Utils.getReplyLabelDescriptor)
local _EventNames = require(AppChat.Analytics.EventNames)

local useChatPagePadding = require(AppChat.Contexts.ChatPagePadding.useChatPagePadding)

local Logger = require(script.Parent.Logger)
local NoticeText = require(script.Parent.NoticeText)
local SystemMessage = require(script.Parent.SystemMessage)
local UserProfiles = require(AppChatParent.UserProfiles)
local DataStatus = require(AppChatParent.DataHydration).DataStatus
local useProfileNames = require(AppChat.Hooks.useProfileNames)
local getCombinedNameFromProfileNames = require(AppChat.Users.getCombinedNameFromProfileNames)
local FFlagAppChatUseUserProfileHydration = require(AppChat.Flags.FFlagAppChatUseUserProfileHydration)
local ChatConversationTelemetryEvents = require(AppChat.Components.ChatConversation.ChatConversationTelemetryEvents)
local ChatConversationTelemetryLayer = require(AppChat.Telemetry.Layers.ChatConversationTelemetryLayer)
local GlobalLongPressSignal = require(AppChat.Components.ChatConversation.Utils.GlobalLongPressSignal)
local MessageFtuxTooltip = require(script.Parent.MessageFtuxTooltip)
local MessageFtuxTooltip2 = MessageFtuxTooltip.MessageFtuxTooltip
local MessageFtuxTooltipVariant = MessageFtuxTooltip.MessageFtuxTooltipVariant
local MessageFtuxTooltipDismissSignal = MessageFtuxTooltip.MessageFtuxTooltipDismissSignal
local SwipeDirection = require(AppChat.Enums.SwipeDirection)

local getFFlagDebugAppChat = require(AppChat.Flags.getFFlagDebugAppChat)
local GetReplyingToStore = require(AppChat.Stores.GetReplyingToStore)

local useReplyingToMessageDispatch = require(AppChat.Components.ChatConversation.MessageInteraction.ReplyingContext.useReplyingToMessageDispatch)
local FFlagAppChatSignalsReplyStore = require(AppChat.Flags.FFlagAppChatSignalsReplyStore)
local FFlagAppChatMessageModelOnDemand = require(AppChat.Flags.FFlagAppChatMessageModelOnDemand)
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local useTelemetry = require(AppChat.Telemetry.useTelemetry)
local createTelemetryEmitter = require(AppChat.Telemetry.createTelemetryEmitter)
local useTriggerFeedback = require(AppChatParent.InteractionFeedback).useTriggerFeedback
local HapticFeedbackContext = require(AppChat.Utils.HapticFeedback).HapticFeedbackContext
local HapticFeedbackType = require(AppChat.Utils.HapticFeedback).HapticFeedbackType
local useSwipeGesture = require(AppChat.Hooks.useSwipeGesture)

local UserTile = require(AppChatParent.UserTile).UserTile
local LayoutMode = require(AppChatParent.UserTile).LayoutMode
local UserPresence = require(AppChatParent.Foundation).Enums.UserPresence

local FFlagAppChatEnableMessageContextMenu = require(AppChat.Flags.FFlagAppChatEnableMessageContextMenu)
local FFlagAppChatConsoleFocusFixes = require(AppChat.Flags.FFlagAppChatConsoleFocusFixes)
local FFlagAppChatAlignAvatarToMessageGroupBottom = require(AppChat.Flags.FFlagAppChatAlignAvatarToMessageGroupBottom)
local useDescendantSelected = require(script.Parent.Hooks.useDescendantSelected).useDescendantSelected
local MessageReactionChip = require(script.Parent.MessageReactions.MessageReactionChip)
local useIsInExperience = require(AppChat.Hooks.useIsInExperience)
local FFlagAppChatEnableReactions = require(AppChatParent.SharedFlags).FFlagAppChatEnableReactions

local bool1 = game:DefineFastFlag("AppChatEnableRepliesUIIxpEnabled2", false)

local layerName = game:DefineFastString("AppChatEnableRepliesUIIxpLayer1", "Party.ConversationPage")
local num1 = game:DefineFastInt("AppChatMessageLongPressDistanceThreshold", 25)
local MessageModel = require(AppChat.Models.MessageModel)
local bool2 = game:DefineFastFlag("AppChatUseSymmetricSwipe", false)
local iconOffset = game:DefineFastInt("AppChatReplyIconSwipeOffset", 25)
local var1 = require(AppChat.Flags.SignalsMigrationConfig).shouldReadMessageListFromSignalsStore or FFlagAppChatSignalsReplyStore
local GetConversationMessageViewModelStore = if var1 then require(AppChat.Stores.GetConversationMessageViewModelStore) else nil
local uDim2 = UDim2.new(0, 0, 0.5, 0)
local uDim2_2 = UDim2.new(1, 0, 0.5, 0)
local vector2 = Vector2.new(0, 0.5)
local vector2_2 = Vector2.new(1, 0.5)

local tbl1 = {
    failed = false,
    filteredForReceivers = false,
    Font = Enum.Font.Gotham,
    isIncoming = false,
    isNewSender = false,
    parentWidth = 0,
    messageId = "",
    conversationId = "",
    messageType = nil,
    messageTypePaddingOffset = 0,
    moderated = false,
    messageMaxWidth = 0,
    openViewProfile = function()
        Logger:warning("openViewProfile was not passed to ChatMessage")
    end,
    renderMessage = function()
        Logger:warning("renderMessage was not passed to ChatMessage")
    end,
    closeKeyboard = function() end,
    inputBoxRef = nil,
    viewProfileOnAvatarPressed = true,
    messageDefaultNoticeText = "PLACEHOLDER Not everyone in this chat can see your message.",
    messageModeratedNoticeText = "PLACEHOLDER Your message was moderated and not sent.",
    messageHiddenNoticeText = "PLACEHOLDER This message is not available",
    unknownUserKey = "Feature.Chat.Label.UnknownUser",
    isPending = false,
    visibility = nil,
    unitTestTouchEnabled = false
}

local str1 = if getFFlagDebugAppChat() then "TextButton" else "Frame"
function ChatMessageContainer(arg1)
    local var2 = Cryo.Dictionary.join(tbl1, arg1)
    local bool3 = if var2.visibility then var2.visibility == MessageModel.VisibilityTypes.Hidden else false
    local bool4 = if FFlagAppChatEnableReactions then not useIsInExperience() else false

    local onActivated = React.useCallback(function()
        if var2.viewProfileOnAvatarPressed then
            var2.openViewProfile(var2.senderUserId)
        end
    end, { var2.senderUserId, if FFlagAppChatConsoleFocusFixes then var2.openViewProfile else nil, if FFlagAppChatConsoleFocusFixes then var2.viewProfileOnAvatarPressed else nil })

    local var4 = useStyle()
    local shouldShowName = var2.shouldShowName
    local var5 = useChatPagePadding()

    local var6 = Foundation.Hooks.useTokens()

    local var7 = React.useMemo(function()
        if not bool2 then
            return {
                direction = SwipeDirection.Right,
                iconName = Foundation.Enums.IconName.ArrowThickToRight,
                messagePosition = uDim2,
                iconOffset = iconOffset,
                iconAnchorPoint = vector2
            }
        end

        return {
            direction = if var2.isIncoming then SwipeDirection.Right else SwipeDirection.Left,
            iconName = if var2.isIncoming then Foundation.Enums.IconName.ArrowThickToRight else Foundation.Enums.IconName.ArrowThickToLeft,
            messagePosition = if var2.isIncoming then uDim2 else uDim2_2,
            iconOffset = if var2.isIncoming then iconOffset else -iconOffset,
            iconAnchorPoint = if var2.isIncoming then vector2 else vector2_2
        }
    end, { var2.isIncoming })

    local var8 = nil
    local var9 = React.useRef(nil)
    local var10 = React.useRef(nil)
    local var11 = React.useRef(Vector2.zero)
    local var12

    if FFlagAppChatMessageModelOnDemand then
        local var13 = React.useContext(ChatConversationTelemetryLayer.Context)
        var12 = React.useMemo(function()
            return createTelemetryEmitter(var13)
        end, { var13 })
    else
        var12 = useTelemetry(ChatConversationTelemetryLayer.Context)
    end
    local var13 = useTriggerFeedback()
    local var14, var15 = React.useState(false)
    local isPressed = var14
    local var17, var18 = React.useState(false)
    local var19, var20 = React.useState(false)
    local var21 = nil
    local var22 = nil
    if FFlagAppChatConsoleFocusFixes then
        var21, var22 = useDescendantSelected()
    end
    local var23 = nil
    if FFlagAppChatConsoleFocusFixes then
        local var24 = ReactFocusNavigation.useFocusGuiObject()

        var23 = React.useCallback(function()
            local current = var10.current
            if current then
                var24(current)
            end
        end, { var10, var24 })
    end
    React.useEffect(function()
        local connection = GlobalLongPressSignal.dismissed:connect(function()
            var20(false)
        end)
        return function()
            connection:disconnect()
        end
    end)

    local var24 = React.useMemo(function()
        return {
            conversationId = var2.conversationId,
            targetMessageSenderId = var2.senderUserId,
            targetMessageId = var2.messageId,
            targetMessageSentAt = if var2.sent then var2.sent.dateTime else nil,
            targetMessageLength = var2.content and #var2.content or nil,
            targetMessageVisibility = var2.visibility
        }
    end, {
        var2.conversationId,
        var2.senderUserId,
        var2.messageId,
        var2.sent,
        var2.content,
        var2.visibility
    })

    local var25 = if FFlagAppChatConsoleFocusFixes then React.useMemo(function()
        return not bool3 and (var17 or var21)
    end, { var17, bool3, var21 }) else React.useMemo(function()
        return not bool3 and var17
    end, { var17, bool3 })

    React.useEffect(function()
        if var25 and var2.isLastIncomingChatMessage then
            MessageFtuxTooltipDismissSignal.dismiss(MessageFtuxTooltipVariant.Replies)
        end
    end, { var25, var2.isLastIncomingChatMessage })
    local emitImpressionTelemetryEvent = React.useCallback(function()
        var12.emit(ChatConversationTelemetryEvents.ConversationMessageReplyIconImpression, var24)
    end, { var12, var24 })
    local var27 = useNavigation()
    local var28 = useGetConversationFromId(var2.conversationId)
    local replyingToStore = if FFlagAppChatSignalsReplyStore then GetReplyingToStore(false) else nil
    local var29 = nil
    local var30 = nil
    if FFlagAppChatMessageModelOnDemand and var1 and GetConversationMessageViewModelStore then
        var30 = GetConversationMessageViewModelStore(false).conversationMessageStore.messages[var2.messageId]
    elseif var1 and GetConversationMessageViewModelStore then
        local var31 = GetConversationMessageViewModelStore(false).conversationMessageStore.messages[var2.messageId]

        if var31 then
            var29 = MessageModel.fromChannelsApi(var31, var2.conversationId)
        else
            var29 = nil
        end
    elseif var28 and var28.messages then
        var29 = var28.messages:Get(var2.messageId)
    end
    local var31 = if FFlagAppChatMessageModelOnDemand then React.useCallback(function()
        if var30 then
            return MessageModel.fromChannelsApi(var30, var2.conversationId)
        end
        return var29
    end, { var30, var29, var2.conversationId }) else nil

    local var32 = useReplyingToMessageDispatch()
    local var33 = useLocalUserId()

    local onSwipeThresholdReached = React.useCallback(function()
        if not bool3 then
            var13(HapticFeedbackContext.Default, HapticFeedbackType.Press)
        end
    end, { bool3, var13 })

    local useCallback = React.useCallback
    local function func1()
        var12.emit(ChatConversationTelemetryEvents.ConversationMessageSwiped, var24)
        if bool3 then
            return
        end

        if FFlagAppChatSignalsReplyStore and replyingToStore then
            replyingToStore.setReplyingTo(var2.messageId)
            return
        end
        var32(if FFlagAppChatMessageModelOnDemand then var31() else var29)
    end

    local var35 = var29
    local var36 = var12
    local var37 = if FFlagAppChatSignalsReplyStore then replyingToStore else nil
    local messageId = if FFlagAppChatSignalsReplyStore then var2.messageId else nil
    local var38 = if FFlagAppChatMessageModelOnDemand then var31 else nil
    local onSwipeComplete = useCallback(func1, { var32, var35, var36, var24, bool3, var37, messageId, var38 })

    local var40 = useSwipeGesture(
        {
            onSwipeThresholdReached = onSwipeThresholdReached,
            onSwipeComplete = onSwipeComplete,
            direction = var7.direction
        }
    )
    local var41 = React.useCallback(function()
        var27.navigate(
            EnumScreens.MessageContextMenu,
            {
                messageId = var2.messageId,
                conversationId = var2.conversationId,
                inputBoxRef = var2.inputBoxRef
            }
        )
    end, {
        var27.navigate,
        var2.messageId,
        var2.conversationId,
        var2.inputBoxRef
    })
    local var42 = React.useCallback(function(arg2, arg3, num3: number)
        if arg3 then
            var11.current = Vector2.new(arg3.Position.X, arg3.Position.Y)
        end
        setTimeout(function()
            local magnitude

            if arg3 then
                local current = var11.current
                magnitude = (Vector2.new(arg3.Position.X, arg3.Position.Y) - current).Magnitude
            else
                magnitude = 0
            end

            if arg3
                and (arg3.UserInputState == Enum.UserInputState.Begin or arg3.UserInputState == Enum.UserInputState.Change)
                and magnitude < num1
            then
                var8(arg2, arg3)
            end
        end, num3)
    end, { var8 })

    local useCallback2 = React.useCallback
    local function func2(arg2, arg3, str2: string?)
        if var2.isPending then
            return
        end

        if UserInputService.MouseEnabled then
            if arg2 == React.Event.MouseEnter then
                var18(true)
            end

            if arg2 == React.Event.MouseLeave then
                var18(false)
            end

            if arg2 == React.Event.MouseButton1Down then
                var2.closeKeyboard()
            end
        end

        if UserInputService.GamepadEnabled or UserInputService.TouchEnabled or var2.unitTestTouchEnabled then
            if arg2 == React.Event.TouchLongPress then
                var12.emit(ChatConversationTelemetryEvents.ConversationMessageLongPressed, var24)

                if not bool3 then
                    var20(true)
                    if FFlagAppChatEnableMessageContextMenu then
                        var41()
                    end
                    var42(React.Event.InputEnded, arg3, ChatMessageContainerConstants.PEEK_VIEW_ANIMATION_MILLISEC)
                end
            end

            if arg2 == React.Event.InputBegan and arg3 then
                var12.emit(ChatConversationTelemetryEvents.ConversationMessagePressed, var24)
                if not (bool3 or var19) then
                    GlobalLongPressSignal.dismiss()
                end

                var42(React.Event.TouchLongPress, arg3, ChatMessageContainerConstants.LONG_PRESS_DELAY_MILLISEC)
            end

            if arg2 == React.Event.TouchTap then
                var2.closeKeyboard()
            end
        end
        if arg2 ~= React.Event.Activated then
            return
        end

        GlobalLongPressSignal.dismiss()
        if str2 == OptionsEnum.MessageContextMenu then
            if ChatConversationTelemetryEvents.ConversationMessageOpenMenuIconClicked then
                var12.emit(ChatConversationTelemetryEvents.ConversationMessageOpenMenuIconClicked, var24)
            end

            var41()
        end

        if str2 ~= OptionsEnum.Reply then
            return
        end

        var12.emit(ChatConversationTelemetryEvents.ConversationMessageReplyIconClicked, var24)

        var13(HapticFeedbackContext.Default, HapticFeedbackType.Press)
        if FFlagAppChatSignalsReplyStore and replyingToStore then
            replyingToStore.setReplyingTo(var2.messageId)
            return
        end
        var32(if FFlagAppChatMessageModelOnDemand then var31() else var29)
    end

    local isPending = var2.isPending
    local unitTestTouchEnabled = var2.unitTestTouchEnabled
    local mouseEnabled = UserInputService.MouseEnabled
    local touchEnabled = UserInputService.TouchEnabled

    local var43 = var12
    local var44 = if FFlagAppChatSignalsReplyStore then replyingToStore else nil
    local var45 = if FFlagAppChatSignalsReplyStore then nil else var29
    local messageId2 = if FFlagAppChatSignalsReplyStore then var2.messageId else nil
    var8 = useCallback2(func2, {
        isPending,
        unitTestTouchEnabled,
        mouseEnabled,
        touchEnabled,
        var42,
        var18,
        var20,
        var15,
        var43,
        var41,
        var32,
        var13,
        bool3,
        var44,
        var45,
        messageId2,
        if FFlagAppChatMessageModelOnDemand and not FFlagAppChatSignalsReplyStore then var31 else nil,
        if FFlagAppChatMessageModelOnDemand then var24 else nil,
        if FFlagAppChatMessageModelOnDemand then var2.closeKeyboard else nil
    })

    local var46 = React.useCallback(function(arg2, arg3)
        if UserInputService.TouchEnabled and var40 then
            var40.onInputBegan(arg2, arg3)

            MessageFtuxTooltipDismissSignal.dismiss(MessageFtuxTooltipVariant.Replies)
        end
        var42(React.Event.InputBegan, arg3, ChatMessageContainerConstants.INPUT_BEGAN_DELAY_MILLISEC)
    end, { var42, var40 })

    local var47 = React.useCallback(function(_)
        var8(React.Event.InputEnded)
    end, { var8 })

    local var48 = React.useCallback(function(_)
        var8(React.Event.MouseEnter)
    end, { var8 })

    local var49 = React.useCallback(function(_)
        var8(React.Event.MouseLeave)
    end, { var8 })

    local var50 = React.useCallback(function(_)
        var8(React.Event.TouchTap)
    end, { var8 })

    local var51 = React.useCallback(function(_)
        var8(React.Event.MouseButton1Down)
    end, { var8 })

    local senderTargetId = var2.repliesTo and var2.repliesTo.senderTargetId

    local function getDisplayNameText(senderName: string, repliedToName: string)
        local senderIsLocalUser = var33 == var2.senderUserId
        local senderRepliedToSelf = var2.senderUserId == var2.repliesTo.senderTargetId
        local senderRepliedToLocalUser = var33 == var2.repliesTo.senderTargetId

        if not senderTargetId then
            return senderName
        end

        local conversationType = var28 and var28.conversationType

        if conversationType ~= Conversation.Type.ONE_TO_ONE_CONVERSATION
            and conversationType ~= Conversation.Type.MULTI_USER_CONVERSATION
        then
            return var2.unknownUserKey
        end

        return getReplyLabelDescriptor({
            senderIsLocalUser = senderIsLocalUser,
            senderRepliedToSelf = senderRepliedToSelf,
            senderRepliedToLocalUser = senderRepliedToLocalUser,
            isGroup = conversationType == Conversation.Type.MULTI_USER_CONVERSATION,
            senderName = senderName,
            repliedToName = repliedToName
        })
    end
    local userIds = { var2.senderUserId }

    if senderTargetId then
        table.insert(userIds, var2.repliesTo.senderTargetId)
    end

    local var52 = nil
    local var53 = nil
    if FFlagAppChatUseUserProfileHydration then
        var53 = useProfileNames(userIds)
    else
        var52 = UserProfiles.Hooks.useUserProfilesFetch(
            {
                userIds = userIds,
                query = UserProfiles.Queries.userProfilesCombinedNameAndUsernameByUserIds
            }
        )
    end

    local bool5, var54

    if FFlagAppChatUseUserProfileHydration then
        local combinedNameFromProfileNames = getCombinedNameFromProfileNames(var53, var2.senderUserId)
        local combinedNameFromProfileNames2 = if senderTargetId then getCombinedNameFromProfileNames(var53, var2.repliesTo.senderTargetId) else nil
        bool5 = not (var53 == nil or var53.status == DataStatus.Ready)
            and (combinedNameFromProfileNames == nil or senderTargetId and combinedNameFromProfileNames2 == nil)
        if bool5 then
            var54 = nil
        elseif senderTargetId then
            var54 = getDisplayNameText(
                combinedNameFromProfileNames or var2.unknownUserKey,
                combinedNameFromProfileNames2 or var2.unknownUserKey
            )
        else
            var54 = combinedNameFromProfileNames or var2.unknownUserKey
        end
    elseif var52.data then
        bool5 = false
        var54 = UserProfiles.Selectors.getCombinedNameFromId(var52.data, var2.senderUserId) or var2.unknownUserKey

        if senderTargetId then
            var54 = getDisplayNameText(
                var54,
                UserProfiles.Selectors.getCombinedNameFromId(var52.data, var2.repliesTo.senderTargetId) or var2.unknownUserKey
            )
        end
    else
        bool5 = true
        var54 = nil
    end

    local var55 = useLocalization(senderTargetId and { displayName = var54 } or {}).displayName or var54

    local var56 = React.useCallback(function(): UDim2
        local var56 = Vector2.new(math.max(1, var2.messageMaxWidth - ChatMessageContainerConstants.TAIL_WIDTH), math.huge)
        local textSize = GetTextSize(
            var55,
            var4.Font.BaseSize * var4.Font.Footer.RelativeSize,
            var6.Typography.CaptionSmall.Font,
            var56,
            { addTemporaryPadding = false }
        )
        return UDim2.new(0, textSize.X, 0, textSize.Y)
    end, {
        var4.Font.BaseSize * var4.Font.Footer.RelativeSize,
        var4.Font.Footer.Font,
        var2.messageMaxWidth - ChatMessageContainerConstants.TAIL_WIDTH,
        var55,
        var6.Typography.CaptionSmall.Font
    })

    local offset = if var2.showDateTime then 0 else (if var2.isNewSender or senderTargetId then ChatMessageContainerConstants.CHAT_MESSAGE_MAX_SPACE else ChatMessageContainerConstants.CHAT_MESSAGE_MIN_SPACE) + var2.messageTypePaddingOffset

    local left = var5.left
    local var57 = left + var6.Size.Size_700
    local horizontalAlignment = var2.isIncoming and Enum.HorizontalAlignment.Left or Enum.HorizontalAlignment.Right

    local var58, var59 = React.useState(false)
    local var60 = React.useCallback(function()
        if getFFlagDebugAppChat() then
            var59(function(arg2): boolean
                return not arg2
            end)
        end
    end, { var59 })

    local var61 = var58 or var2.moderated or var2.filteredForReceivers or bool3
    local var62 = if var58 then var2.messageId elseif bool3 then var2.messageHiddenNoticeText else var2.moderated and var2.messageModeratedNoticeText or var2.messageDefaultNoticeText

    local var63 = React.useMemo(function()
        return React.createElement(Foundation.Icon, {
            name = Foundation.Enums.IconName.TriangleExclamation,
            size = Foundation.Enums.IconSize.Large,
            style = var6.Color.System.Alert,
            LayoutOrder = if var2.isIncoming then 0 else 3
        })
    end, { var6, var4, var2.isIncoming })

    local icons = if var2.failed or var2.moderated then var63 elseif var25 then React.createElement(Options, {
        LayoutOrder = if var2.isIncoming then 2 else 1,
        isIncoming = var2.isIncoming,
        handleEvent = var8,
        emitImpressionTelemetryEvent = emitImpressionTelemetryEvent
    }) else nil
    local isIncoming = var2.isIncoming

    local style = if var40 and var40.swipeProgress then var40.swipeProgress:map(function(num3: number)
        local num4 = 1 - math.pow(num3, 3)
        return {
            Color3 = var6.Color.Content.Default.Color3,
            Transparency = num4
        }
    end) else nil

    local var66 = if var40 and var40.swipeOffset then var40.swipeOffset:map(function(xOffset: number): UDim2
        if var7.direction ~= SwipeDirection.Right then
            xOffset = -xOffset
        end

        return UDim2.new(0, xOffset, 0, 0)
    end) else nil

    local var67 = if var40 and var40.swipeProgress then var40.swipeProgress:map(function(num3: number)
        return var7.messagePosition + UDim2.new(0, num3 * var7.iconOffset, 0, 0)
    end) else nil

    local function renderMessage()
        local createElement = React.createElement
        local str2 = "Frame"
        local tbl3 = {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 2,
            Size = UDim2.new(1, 0, 0, 0),
            Position = var66,
            [React.Event.MouseEnter] = var48,
            [React.Event.MouseLeave] = var49
        }
        local tbl4 = {
            Padding = React.createElement("UIPadding", {
                PaddingTop = UDim.new(0, offset),
                PaddingLeft = UDim.new(0, var2.thumbnail and left or var57),
                PaddingRight = UDim.new(0, var5.right - 0)
            }),
            Layout = React.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = horizontalAlignment
                }
            ),
            AvatarContainer = 0,
            MessageWithDisplayName = 0
        }
        local element

        if var2.thumbnail then
            element = React.createElement(Foundation.View, {
                tag = {
                    ["col auto-x size-0-full"] = true,
                    ["align-y-top"] = false,
                    ["align-y-bottom"] = FFlagAppChatAlignAvatarToMessageGroupBottom
                },
                LayoutOrder = 1
            }, {
                Avatar = React.createElement(Foundation.View, { tag = "size-700-700" }, {
                    AvatarCircle = React.createElement(UserTile, {
                        userId = var2.senderUserId,
                        layoutMode = LayoutMode.compact,
                        userPresenceType = UserPresence.None,
                        layoutOrder = 1,
                        onActivated = onActivated
                    })
                })
            })
        else
            element = nil
        end

        tbl4.AvatarContainer = element

        local createElement2 = React.createElement
        local str3 = "Frame"
        local tbl5 = {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            LayoutOrder = 2,
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.new(1, var2.isIncoming and -var57 or 0, 0, 0)
        }
        local tbl6 = {
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = horizontalAlignment,
                SortOrder = if FFlagAppChatEnableReactions then Enum.SortOrder.LayoutOrder else nil
            }),
            Padding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, var2.isIncoming and var6.Size.Size_200 or 0) }),
            DisplayNameContainer = 0,
            MessageWithIcons = 0,
            MessageReactionChip = 0
        }
        local var68 = shouldShowName

        if var68 then
            local createElement3 = React.createElement
            local str4 = "Frame"
            local tbl7 = {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.new(0, var2.messageMaxWidth - ChatMessageContainerConstants.TAIL_WIDTH, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 1
            }
            local tbl8 = {
                Padding = React.createElement("UIPadding", {
                    PaddingLeft = UDim.new(0, ChatMessageContainerConstants.GROUPED_MESSAGE_DISPLAY_NAME_LEFT_PADDING),
                    PaddingRight = if isIncoming then UDim.new(0, 0) else UDim.new(0, ChatMessageContainerConstants.TAIL_WIDTH),
                    PaddingBottom = if senderTargetId then UDim.new(0, ChatMessageContainerConstants.REPLIED_DISPLAY_NAME_BOTTOM_PADDING) else UDim.new(0, ChatMessageContainerConstants.GROUPED_MESSAGE_DISPLAY_NAME_BOTTOM_PADDING)
                }),
                DisplayName = 0,
                ShimmerName = 0
            }
            local element2

            if bool5 then
                element2 = nil
            else
                element2 = React.createElement("TextLabel", {
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    FontFace = normalizeFontFace(var6.Typography.CaptionSmall.Font),
                    Size = var56(),
                    AnchorPoint = if isIncoming then Vector2.new(0, 0) else Vector2.new(1, 0),
                    Position = if isIncoming then UDim2.fromScale(0, 0) else UDim2.fromScale(1, 0),
                    Text = var55,
                    TextColor3 = var4.Theme.TextDefault.Color,
                    TextSize = var4.Font.BaseSize * var4.Font.Footer.RelativeSize,
                    TextTransparency = var4.Theme.TextDefault.Transparency,
                    TextXAlignment = if isIncoming then Enum.TextXAlignment.Left else Enum.TextXAlignment.Right,
                    TextYAlignment = Enum.TextYAlignment.Top
                })
            end

            tbl8.DisplayName = element2
            local element3

            if bool5 then
                element3 = React.createElement(Skeleton, {
                    AnchorPoint = if isIncoming then Vector2.new(0, 0) else Vector2.new(1, 0),
                    Position = if isIncoming then UDim2.fromScale(0, 0) else UDim2.fromScale(1, 0),
                    Size = UDim2.new(0, ChatMessageContainerConstants.SHIMMER_WIDTH, 0, ChatMessageContainerConstants.SHIMMER_HEIGHT),
                    LayoutOrder = 2
                })
            else
                element3 = nil
            end

            tbl8.ShimmerName = element3
            var68 = createElement3(str4, tbl7, tbl8)
        end

        tbl6.DisplayNameContainer = var68

        local createElement3 = React.createElement
        local str4 = "Frame"
        local tbl7 = {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            LayoutOrder = 2,
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = if FFlagAppChatConsoleFocusFixes then UDim2.new(1, 0, 0, 0) else UDim2.new(1, var2.isIncoming and -var57 or 0, 0, 0),
            Selectable = if FFlagAppChatConsoleFocusFixes then not bool3 else nil,
            ref = if FFlagAppChatConsoleFocusFixes then var22 else nil,
            [React.Event.SelectionGained] = if FFlagAppChatConsoleFocusFixes then var23 else nil
        }
        local tbl8 = {
            Layout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = horizontalAlignment,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, 10),
                ItemLineAlignment = Enum.ItemLineAlignment.Center
            }),
            Message = var2.renderMessage(
                {
                    LayoutOrder = if var2.isIncoming then 1 else 2,
                    [React.Event.InputBegan] = var46,
                    [React.Event.InputEnded] = var47,
                    [React.Event.TouchTap] = var50,
                    [React.Event.MouseButton1Down] = var51
                },
                {
                    isPressed = isPressed,
                    Icons = icons,
                    bubbleRef = if FFlagAppChatConsoleFocusFixes then var10 else nil,
                    ref = var9
                }
            ),
            MessageFtuxTooltip = if var2.isLastIncomingChatMessage and not bool3 then React.createElement(
                MessageFtuxTooltip2,
                {
                    variant = MessageFtuxTooltipVariant.Replies,
                    messageRef = var9,
                    isReversed = var2.isIncoming
                }
            ) else nil
        }
        tbl6.MessageWithIcons = createElement3(str4, tbl7, tbl8)

        tbl6.MessageReactionChip = if bool4 then React.createElement(MessageReactionChip, { messageId = var2.messageId, isIncoming = var2.isIncoming, layoutOrder = 3 }) else nil
        tbl4.MessageWithDisplayName = createElement2(str3, tbl5, tbl6)
        local content = createElement(str2, tbl3, tbl4)

        if bool3 then
            return content
        end

        return React.createElement(
            Foundation.View,
            { tag = "size-full-0 auto-y", ClipsDescendants = false, LayoutOrder = 2, ZIndex = 2 },
            {
                ReplyIconFilled = React.createElement(Foundation.Icon, {
                    name = var7.iconName,
                    size = Foundation.Enums.IconSize.Medium,
                    variant = Foundation.Enums.IconVariant.Filled,
                    AnchorPoint = var7.iconAnchorPoint,
                    Position = var67,
                    style = style,
                    ZIndex = 1
                }),
                Content = content
            }
        )
    end
    React.useEffect(function()
        if bool1 and var2.isLastIncomingChatMessage then
            IXPService:LogFlagLinkedUserLayerExposure(layerName)
        end
    end, { var2.isLastIncomingChatMessage })
    local createElement = React.createElement
    local str2 = str1
    local tbl3 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
        Text = if getFFlagDebugAppChat() then "" else nil
    }
    local activated = React.Event.Activated

    if not getFFlagDebugAppChat() then
        var60 = nil
    end

    tbl3[activated] = var60
    local tbl4 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = horizontalAlignment,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        DateTime = var2.showDateTime
            and React.createElement(
                SystemMessage,
                {
                    LayoutOrder = 1,
                    Text = var2.sent:GetLongRelativeTime(),
                    maxWidth = ChatMessageContainerConstants.DATETIME_MAX_WIDTH
                }
            ),
        MessageWithAvatar = renderMessage(),
        Notice = 0,
        debug = 0
    }

    if var61 then
        var61 = React.createElement(NoticeText, {
            Font = var2.Font,
            HorizontalAlignment = horizontalAlignment,
            LayoutOrder = 3,
            Text = var62,
            TextColor3 = if bool3 then var6.Color.Content.Muted.Color3 else var2.moderated and var4.Theme.Alert.Color or var4.Theme.UIDefault.Color,
            TextTransparency = if bool3 then var6.Color.Content.Muted.Transparency else var2.moderated and var4.Theme.Alert.Transparency or var4.Theme.UIDefault.Transparency,
            TextXAlignment = var2.isIncoming and Enum.TextXAlignment.Left or Enum.TextXAlignment.Right,
            TextSize = var6.Typography.CaptionSmall.FontSize,
            margin = {
                top = var6.Padding.Small,
                left = var2.isIncoming and var57 + ChatMessageContainerConstants.NOTICE_HORIZONTAL_PADDING or 0,
                right = if var2.isIncoming then 0 else var5.right or 0,
                bottom = 0
            },
            maxWidth = var2.parentWidth,
            width = UDim.new(1, var2.isIncoming and -var57 or 0)
        })
    end

    tbl4.Notice = var61

    tbl4.debug = var2.debugElement or nil
    return createElement(str2, tbl3, tbl4)
end

return ChatMessageContainer
