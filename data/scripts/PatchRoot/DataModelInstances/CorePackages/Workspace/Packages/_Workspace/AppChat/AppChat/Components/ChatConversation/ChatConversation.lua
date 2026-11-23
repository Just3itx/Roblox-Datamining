-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Foundation = require(AppChatParent.Foundation)
local React = require(AppChatParent.React)
local Roact = require(AppChatParent.Roact)
local withStyle = require(AppChatParent.UIBlox).Style.withStyle
local memoize = require(AppChatParent.AppCommonLib).memoize
local ReactFocusNavigation = require(AppChatParent.ReactFocusNavigation)
local CoreGui = ReactFocusNavigation.EngineInterface.CoreGui
local FocusNavigationService = ReactFocusNavigation.FocusNavigationService
local FocusBehaviors = require(AppChatParent.FocusBehaviors)
local UserInputService = game:GetService("UserInputService")
local IXPService = game:GetService("IXPService")
local RoactNavigation = require(AppChatParent.RoactNavigation)

local MessageList = require(script.Parent.MessageList)
local SignalsMigrationConfig = require(AppChat.Flags.SignalsMigrationConfig)
local ReplyComposeBarContainer = require(script.Parent.ReplyComposeBarContainer)
local var1 = if require(AppChat.Flags.FFlagAppChatNewChatInputBar) then require(script.Parent.ChatInputBar) else require(script.Parent.ChatInputBarDeprecated)
local UserTypingIndicator = require(script.Parent.UserTypingIndicator)
local var2 = require(AppChat.Logger):new(script.Name)
local withChatPagePadding = require(AppChat.Contexts.ChatPagePadding.withChatPagePadding)
local _ConversationChannels = require(AppChat.Models.ConversationChannels)
local StatusCodes = require(AppChatParent.Http).StatusCodes
local DateTime = require(AppChatParent.Time).DateTime
local ChatConversationMoreMenu = require(script.Parent.ChatConversationMoreMenu)
local KeyboardOffsetEventHandler = require(script.Parent.KeyboardOffsetEventHandler)
local GlobalLongPressSignal = require(script.Parent.Utils.GlobalLongPressSignal)
local ScrollToLatestButton = require(script.Parent.ScrollToLatest.ScrollToLatestButton)
local FFlagAppChatConsoleFocusFixes = require(AppChat.Flags.FFlagAppChatConsoleFocusFixes)
local FFlagAppChatScrollToLatest = require(AppChat.Flags.FFlagAppChatScrollToLatest)

local GetReplyingToStore = require(AppChat.Stores.GetReplyingToStore)
local FFlagAppChatSignalsReplyStore = require(AppChat.Flags.FFlagAppChatSignalsReplyStore)

local SmartSuggestionsChipRowContainer = require(script.Parent.SmartSuggestions.SmartSuggestionsChipRowContainer)
local FFlagAppChatSmartSuggestions = require(AppChat.Flags.FFlagAppChatSmartSuggestions)

local GetEmojiSetsStore = require(AppChat.Stores.GetEmojiSetsStore)
local FFlagAppChatEnableReactions = require(AppChatParent.SharedFlags).FFlagAppChatEnableReactions

local ConversationExitType = require(AppChat.Analytics.Enums.ConversationExitType)
local SendMessageError = require(AppChat.Analytics.Enums.SendMessageError)
local withRoactChatAnalytics = require(AppChat.LegacyAnalytics.withRoactChatAnalytics)
local connectTelemetry = require(AppChat.Telemetry.connectTelemetry)
local ChatConversationTelemetryEvents = require(script.Parent.ChatConversationTelemetryEvents)
local ChatConversationTelemetryLayer = require(AppChat.Telemetry.Layers.ChatConversationTelemetryLayer)
local bool1 = game:DefineFastFlag("AppChatNewChatInputBarIxpEnabled", false)
local layerName = game:DefineFastString("AppChatNewChatInputBarIxpLayer", "")
local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)
local FFlagAppChatMessageTTIMilestones = require(AppChat.Flags.FFlagAppChatMessageTTIMilestones)
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)

local ConversationTopModalContainer = require(script.Parent.ConversationTopModalContainer)
local ConversationBottomModalContainer = require(script.Parent.ConversationModal.ConversationBottomModalContainer)

local var3 = Roact.PureComponent:extend("ChatConversation")
var3.defaultProps = {
    topBarHeight = 0,
    conversationId = nil,
    conversationTitle = nil,
    itemList = {},
    inputBoxRef = nil,
    wideMode = false,
    getOlderMessages = function() end,
    isDebugEnabled = false,
    sendMessage = function() end,
    navigateToToast = function() end,
    markConversationAsRead = function() end,
    postTypingStatus = function() end,
    navigateBack = function() end,
    openViewProfile = function() end,
    updateConversationTitle = function() end,
    openGameDetailsPage = function() end,
    navigateToSquadLobby = function() end,
    onChatInputBarReady = function() end,
    viewProfileOnAvatarPressed = true,
    chatInputPlaceholder = "Say something",
    usersTyping = {},
    invalidMessageTypeText = "PLACEHOLDER This message could not be displayed",
    messageDefaultNoticeText = "PLACEHOLDER Not everyone in this chat can see your message.",
    messageModeratedNoticeText = "PLACEHOLDER Your message was moderated and not sent.",
    newText = "New",
    networkErrorText = "PLACEHOLDER There was a network error, please try again later",
    unknownUserText = "PLACEHOLDER unknown user",
    oneUserTyping = "PLACEHOLDER {DISPLAY_NAME} is typing...",
    twoUsersTyping = "PLACEHOLDER {DISPLAY_NAME_1} and {DISPLAY_NAME_2} are typing...",
    severalUsersTyping = "PLACEHOLDER Several users are typing...",
    bottomModalText = "PLACEHOLDER At this time, Chat is not available with this user.",
    readingMessagesIsEnabled = true,
    onConversationUnmount = function() end,
    chatIsVisible = true,
    moreMenuEnabled = false,
    keyboardOffset = nil,
    replyingToMessageId = nil,
    replyingToMessage = nil,
    replyingToMessageDispatch = function() end,
    shouldShowChatInputBar = true,
    shouldDisableChatInputBar = false,
    shouldShowLegacyBottomModal = false,
    telemetry = {
        emit = function() end
    },
    scrollToTopOnInitialOsaLoad = false,
    isInitialMessageLoading = false,
    displayNamesAvailable = true,
    shouldHideMoreMenuButton = false
}

function var3.init(arg1)
    arg1.state = {
        inputBarHeight = 0,
        keyboardOffset = 0,
        conversationBannerHeight = 0,
        messageListHeight = 0,
        bottomModalHeight = 0,
        tooltipText = "",
        scrolledAwayFromLatestConversationId = nil
    }

    arg1.inputBoxRef = arg1.props.inputBoxRef or Roact.createRef()
    arg1.inputBarRef = Roact.createRef()
    arg1.conversationViewRef = Roact.createRef()
    arg1.messageListRef = Roact.createRef()

    arg1.scrollToLatestRef = { current = nil }

    function arg1.onScrolledAwayFromLatestChanged(bool2: boolean)
        local conversationId = if bool2 then arg1.props.conversationId else nil

        if arg1.isMounted == false then
            return
        end

        arg1:setState(function(arg2): {scrolledAwayFromLatestConversationId: number}?
            if arg2.scrolledAwayFromLatestConversationId == conversationId then
                return nil
            end
            return {
                scrolledAwayFromLatestConversationId = if conversationId ~= nil then conversationId else Roact.None
            }
        end)
    end

    function arg1.onScrollToLatestActivated()
        local current = arg1.scrollToLatestRef.current
        if current then
            current()
        end

        if arg1.focusNavigationService.focusedGuiObject:getValue() == nil then
            return
        end

        local value = arg1.inputBarRef:getValue()
        if value then
            arg1.focusNavigationService:focusGuiObject(value)
        end
    end

    function arg1.getKeyboardOffset()
        if UserInputService.OnScreenKeyboardVisible and arg1.inputBoxRef:getValue() and arg1.inputBoxRef:getValue():IsFocused() then
            if arg1.props.keyboardOffset ~= nil then
                return arg1.props.keyboardOffset
            end

            local value = arg1.conversationViewRef:getValue()
            if value then
                return value.AbsolutePosition.Y + value.AbsoluteSize.Y - UserInputService.OnScreenKeyboardPosition.Y
            end
        end

        return 0
    end

    function arg1.updateKeyboardOffset()
        if not arg1.isMounted then
            return
        end
        local keyboardOffset = arg1.getKeyboardOffset()
        if arg1.state.keyboardOffset ~= keyboardOffset then
            arg1:setState({ keyboardOffset = keyboardOffset })
        end
    end

    function arg1.onKeyboardOffsetChanged(keyboardOffset)
        if not arg1.isMounted then
            return
        end

        keyboardOffset = if arg1.inputBoxRef:getValue() and arg1.inputBoxRef:getValue():IsFocused() then keyboardOffset else 0

        if arg1.state.keyboardOffset ~= keyboardOffset then
            arg1:setState({ keyboardOffset = keyboardOffset })
        end
    end

    function arg1.clearKeyboardOffset()
        arg1:setState({ keyboardOffset = 0 })
    end

    arg1.loadNext = memoize(function(arg2, arg3)
        return function()
            local var4 = arg2(arg3)
            if var4 then
                var4:catch(function()
                    arg1.showNetworkErrorToast()
                end)
            end
        end
    end)

    arg1.markAsRead = memoize(function(callback, arg2)
        return function()
            if arg1.props.readingMessagesIsEnabled then
                callback(arg2)
            end
        end
    end)

    function arg1.showNetworkErrorToast()
        arg1.props.navigateToToast({ toastProps = { toastContent = { toastTitle = arg1.props.networkErrorText } } })
    end

    arg1.onSendChat = memoize(function(arg2, arg3, callback, arg4, arg5, arg6, callback2, arg7)
        return function(arg8)
            if arg5 and arg5.source == "friends" then
                var2:info("Creating a conversation for friend conversation {} via onSendChat", arg3)

                local var4, var5 = arg6(arg3, arg4):await()
                if not (var4 and var5) then
                    var2:error("Could not create conversation. Error: {}", tostring(var5))
                    return
                end

                var2:debug("Created conversation {} for friend conversation {} via onSendChat", var5.id, arg3)

                arg3 = var5.id
                callback2(var5.id)
            end

            var2:info("Sending message '{}' to conversationId {} via onSendChat", arg8, arg3)
            if FFlagAppChatPerfTracking then
                if FFlagAppChatMessageTTIMilestones then
                    AppChatPerfTracker.start(AppChatPerfTracker.Events.MessageSendTTI, { conversationId = tostring(arg3) })
                else
                    AppChatPerfTracker.start(AppChatPerfTracker.Events.MessageSendToPendingRender, { conversationId = tostring(arg3) })

                    AppChatPerfTracker.start(AppChatPerfTracker.Events.MessageSendToFinalRender, { conversationId = tostring(arg3) })
                end
            end

            local replyingToMessage = nil
            if FFlagAppChatSignalsReplyStore and arg1.props.replyingToMessageId then
                replyingToMessage = {
                    id = arg1.props.replyingToMessageId
                }
            elseif not FFlagAppChatSignalsReplyStore then
                replyingToMessage = arg1.props.replyingToMessage
            end
            local var4 = arg2(arg3, arg8, replyingToMessage)

            if var4 then
                var4:andThen(function(arg9)
                    if arg9 and arg9.StatusCode == StatusCodes.CONFLICT then
                        arg1.showNetworkErrorToast()
                    elseif callback then
                        callback(arg3)
                    end
                end)
            elseif callback then
                callback(arg3)
            end

            arg1.closeReplying()

            local tbl1 = {
                messageSentResult = SendMessageError.OtherFailure,
                recipientIds = arg1.props.recipientIdsSerialized
            }
            if not var4 then
                arg7.emit(ChatConversationTelemetryEvents.ConversationMessageSent, tbl1)
                return
            end

            var4:andThen(function(arg9)
                local id = nil

                local id2 = nil
                local senderUserId = nil
                local var5 = nil
                local contentLen = nil

                local statusCode = arg9 and arg9.StatusCode
                local var6

                if not arg9 then
                    var6 = SendMessageError.NoResponse
                elseif statusCode == StatusCodes.CONFLICT then
                    var6 = SendMessageError.Conflict
                elseif not arg9.responseBody then
                    var6 = SendMessageError.NoResponseBody
                elseif not arg9.responseBody.messages or #arg9.responseBody.messages == 0 then
                    var6 = SendMessageError.NoMessages
                elseif not arg9.responseBody.messages[1].status then
                    var6 = SendMessageError.NoMessageStatus
                else
                    var6 = arg9.responseBody.messages[1].status
                    id = arg9.responseBody.messages[1].id

                    if arg9.responseBody.messages[1].replies_to then
                        local repliesTo = arg9.responseBody.messages[1].replies_to

                        id2 = repliesTo.id
                        senderUserId = repliesTo.sender_user_id

                        var5 = tostring(DateTime.fromIsoDate(repliesTo.created_at).dateTime)
                        if repliesTo.content then
                            contentLen = #repliesTo.content
                        else
                            contentLen = nil
                        end
                    end
                end

                arg7.emit(ChatConversationTelemetryEvents.ConversationMessageSent, {
                    messageSentResult = var6,
                    messageId = id,
                    recipientIds = arg1.props.recipientIdsSerialized,
                    targetMessageId = id2,
                    targetMessageSenderId = senderUserId,
                    targetMessageSentAt = var5,
                    targetMessageLength = contentLen
                })
            end):catch(function()
                arg7.emit(ChatConversationTelemetryEvents.ConversationMessageSent, tbl1)
            end)
        end
    end)

    arg1.onSendBtnClicked = memoize(function(arg2): (string?) -> ()
        return function(sendBtnClickResult: string?)
            arg2.emit(ChatConversationTelemetryEvents.ConversationSendBtnClicked, { sendBtnClickResult = sendBtnClickResult })
        end
    end)

    function arg1.isMoreMenuEnabled()
        return arg1.props.moreMenuEnabled
    end

    arg1.reportInputBarReady = FFlagAppChatPerfTracking and function(num1: number)
        if arg1.props.onChatInputBarReady and arg1.props.shouldShowChatInputBar and num1 > 0 then
            arg1.props.onChatInputBarReady()
        end
    end or nil

    function arg1.onHeightChanged(arg2)
        if FFlagAppChatPerfTracking then
            arg1.reportInputBarReady(arg2.AbsoluteSize.Y)
        end

        arg1:setState(function(arg3, _)
            return if arg2.AbsoluteSize.Y == arg3.inputBarHeight then {} else {
                inputBarHeight = arg2.AbsoluteSize.Y
            }
        end)
    end
    arg1.lastTypingRequest = 0
    function arg1.chatInputTextChanged()
        if arg1.props.conversation and arg1.props.conversation.source == "friends" then
            return
        end

        local lastTypingRequest = tick()
        if lastTypingRequest - arg1.lastTypingRequest >= 3 then
            arg1.lastTypingRequest = lastTypingRequest
            arg1.props.postTypingStatus(arg1.props.conversationId, true)
        end
    end

    arg1.exitTypeForAnalytics = ConversationExitType.Default

    function arg1.fireAnalyticsEventOnUnmount()
        arg1.props.onConversationUnmount(arg1.exitTypeForAnalytics)

        arg1.exitTypeForAnalytics = ConversationExitType.Default
    end

    function arg1.closeKeyboard()
        if arg1.inputBoxRef:getValue() then
            arg1.inputBoxRef:getValue():ReleaseFocus()
        end
    end

    function arg1.closeReplying()
        if FFlagAppChatSignalsReplyStore then
            GetReplyingToStore(false).clear()
            return
        end
        arg1.props.replyingToMessageDispatch(nil)
    end

    function arg1.onPointerInput()
        GlobalLongPressSignal.dismiss()
        arg1.closeKeyboard()
    end

    function arg1.onSizeChange()
        arg1.updateKeyboardOffset()
    end

    function arg1.calculateScrollOffset(arg2)
        local canvasPositionY = arg2.CanvasPosition.Y
        local absoluteCanvasSizeY = arg2.AbsoluteCanvasSize.Y
        local absoluteWindowSizeY = arg2.AbsoluteWindowSize.Y
        return absoluteCanvasSizeY - canvasPositionY - absoluteWindowSizeY
    end

    function arg1.setBannerHeight(conversationBannerHeight)
        arg1:setState({ conversationBannerHeight = conversationBannerHeight })
    end

    function arg1.setBottomModalHeight(bottomModalHeight)
        arg1:setState({ bottomModalHeight = bottomModalHeight })
    end

    function arg1.onMessageListSizeChange(arg2)
        arg1:setState({ messageListHeight = arg2.AbsoluteSize.Y })
    end

    arg1.focusNavigationService = FocusNavigationService.new(CoreGui)
end

function var3.didMount(arg1)
    arg1.isMounted = true
    arg1.markAsRead(arg1.props.markConversationAsRead, arg1.props.conversationId)()
    local value = arg1.conversationViewRef:getValue()
    local value2 = arg1.inputBarRef:getValue()
    arg1.focusNavigationService:registerFocusBehavior(
        value,
        if FFlagAppChatConsoleFocusFixes then FocusBehaviors.default(value2) else FocusBehaviors.mostRecentOrDefault(value2)
    )

    if not arg1.props.wideMode and arg1.focusNavigationService.focusedGuiObject:getValue() ~= nil then
        arg1.focusNavigationService:focusGuiObject(value2)
    end
    if bool1 and arg1.props.shouldShowChatInputBar then
        IXPService:LogFlagLinkedUserLayerExposure(layerName)
    end
    if FFlagAppChatEnableReactions then
        GetEmojiSetsStore(false).getAndFetchEmojiSets()
    end
end

function var3.willUpdate(arg1, arg2, _)
    if arg2.chatIsVisible ~= arg1.props.chatIsVisible and not arg2.chatIsVisible then
        arg1.closeKeyboard()
    end
end

function var3.didUpdate(arg1, arg2, arg3)
    if arg1.props.wideMode and arg1.props.navigation.getParam("navigatedWithFocus") then
        local value = arg1.inputBarRef:getValue()
        arg1.props.navigation.setParams({ navigatedWithFocus = false })
        arg1.focusNavigationService:focusGuiObject(value)
    end

    if FFlagAppChatConsoleFocusFixes and arg2.conversationId == arg1.props.conversationId then
        local var4 = if FFlagAppChatSignalsReplyStore then arg2.replyingToMessageId else arg2.replyingToMessage
        local var5 = if FFlagAppChatSignalsReplyStore then arg1.props.replyingToMessageId else arg1.props.replyingToMessage

        if var5 ~= nil and var5 ~= var4 and arg1.focusNavigationService.focusedGuiObject:getValue() ~= nil then
            local value = arg1.inputBarRef:getValue()
            if value then
                arg1.focusNavigationService:focusGuiObject(value)
            end
        end
    end

    if arg2.conversationId ~= arg1.props.conversationId then
        if FFlagAppChatPerfTracking then
            arg1.reportInputBarReady(arg1.state.inputBarHeight)
        end
        if arg1.inputBoxRef:getValue() then
            arg1.inputBoxRef:getValue().Text = ""
            arg1.inputBoxRef:getValue():ReleaseFocus()
        end
        arg1.closeReplying()

        if FFlagAppChatScrollToLatest then
            local conversationId = arg2.conversationId
            arg1:setState(function(arg4): {scrolledAwayFromLatestConversationId: any}?
                return if arg4.scrolledAwayFromLatestConversationId == conversationId then {
                    scrolledAwayFromLatestConversationId = Roact.None
                } else nil
            end)
        end

        arg1.markAsRead(arg1.props.markConversationAsRead, arg1.props.conversationId, false)()

        if FFlagAppChatEnableReactions then
            GetEmojiSetsStore(false).getAndFetchEmojiSets()
        end
    end

    if FFlagAppChatPerfTracking and arg2.shouldShowChatInputBar ~= arg1.props.shouldShowChatInputBar then
        arg1.reportInputBarReady(arg1.state.inputBarHeight)
    end

    local _listRef = arg1.messageListRef and arg1.messageListRef.current and arg1.messageListRef.current._listRef
    local nativeScrollRef = _listRef and _listRef._scrollRef and _listRef._scrollRef.getNativeScrollRef()
    local var4 = arg1.state.messageListHeight - arg3.messageListHeight
    if not _listRef or not nativeScrollRef or arg3.messageListHeight == 0 or var4 == 0 then
        return
    end

    local scrollOffset = arg1.calculateScrollOffset(nativeScrollRef._nativeRef.current)
    if scrollOffset <= 0 then
        return
    end
    _listRef:scrollToOffset({ offset = scrollOffset + var4 })
end

function var3.willUnmount(arg1)
    arg1.fireAnalyticsEventOnUnmount()
    arg1.closeReplying()
    arg1.keyboardConnections = {}
    arg1.isMounted = false
    arg1.focusNavigationService:teardown()
end

function var3.render(arg1)
    local displayNamesAvailable = #arg1.props.usersTyping > 0 and arg1.props.displayNamesAvailable
    local bool2 = if arg1.props.conversation then arg1.props.conversation.source == "friends" else false
    local str1 = "MessageList" .. tostring(arg1.props.conversationId)
    local onScrolledAwayFromLatestChanged = if FFlagAppChatScrollToLatest then arg1.onScrolledAwayFromLatestChanged else nil
    local scrollToLatestRef = if FFlagAppChatScrollToLatest then arg1.scrollToLatestRef else nil
    local element

    if SignalsMigrationConfig.shouldUseViewRecyclerMessageList and arg1.props.conversationId ~= nil then
        element = Roact.createElement(require(AppChat.Components.MessageListV2.MessageListV2Container), {
            conversationId = arg1.props.conversationId,
            itemList = arg1.props.itemList,
            loadNext = if bool2 then nil else arg1.loadNext(arg1.props.getOlderMessages, arg1.props.conversationId),
            markAsRead = arg1.markAsRead(arg1.props.markConversationAsRead, arg1.props.conversationId),
            closeKeyboard = arg1.closeKeyboard,
            onDetailsOpened = arg1.closeKeyboard,
            inputBoxRef = arg1.inputBoxRef,
            openGameDetailsPage = arg1.props.openGameDetailsPage,
            openMomentsDeepLink = arg1.props.openMomentsDeepLink,
            openViewProfile = arg1.props.openViewProfile,
            viewProfileOnAvatarPressed = arg1.props.viewProfileOnAvatarPressed,
            wideMode = arg1.props.wideMode,
            isDebugEnabled = arg1.props.isDebugEnabled,
            readingMessagesIsEnabled = arg1.props.readingMessagesIsEnabled,
            isInitialMessageLoading = arg1.props.isInitialMessageLoading,
            openAtStart = arg1.props.openMessageListAtStart,
            invalidMessageTypeText = arg1.props.invalidMessageTypeText,
            messageDefaultNoticeText = arg1.props.messageDefaultNoticeText,
            messageModeratedNoticeText = arg1.props.messageModeratedNoticeText,
            messageHiddenNoticeText = arg1.props.messageHiddenNoticeText,
            unknownUserText = arg1.props.unknownUserText,
            onScrolledAwayFromLatestChanged = onScrolledAwayFromLatestChanged,
            scrollToLatestRef = scrollToLatestRef
        })
    else
        element = nil
    end

    local element2

    if FFlagAppChatScrollToLatest
        and arg1.props.conversationId ~= nil
        and arg1.state.scrolledAwayFromLatestConversationId == arg1.props.conversationId
    then
        element2 = Roact.createElement(ScrollToLatestButton, {
            conversationId = arg1.props.conversationId,
            messageListVersion = if element == nil then "legacy" else "viewRecycler",
            onActivated = arg1.onScrollToLatestActivated
        })
    else
        element2 = nil
    end

    return withRoactChatAnalytics(function(arg2)
        return withStyle(function(arg3)
            return withChatPagePadding(function(arg4)
                local var4

                if arg1.isMoreMenuEnabled() then
                    var4 = UDim.new(0, math.max(arg4.right - 6, 0))
                    if arg1.props.shouldDisableChatInputBar then
                        var4 = UDim.new(0, arg4.right)
                    end
                else
                    var4 = nil
                end

                local createElement = Roact.createElement
                local str2 = "TextButton"
                local tbl1 = {
                    AutoButtonColor = false,
                    BackgroundColor3 = arg3.Theme.BackgroundDefault.Color,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 1, 0),
                    Text = "",
                    Transparency = arg3.Tokens.Color.None.Transparency,
                    [Roact.Event.TouchTap] = arg1.onPointerInput,
                    [Roact.Event.MouseButton1Down] = arg1.onPointerInput,
                    [Roact.Ref] = arg1.conversationViewRef,
                    Selectable = false
                }
                local tbl2 = {
                    KeyboardOffsetEventHandler = Roact.createElement(
                        KeyboardOffsetEventHandler,
                        {
                            onKeyboardOffsetChanged = arg1.onKeyboardOffsetChanged,
                            parentViewRef = arg1.conversationViewRef
                        }
                    ),
                    Layout = Roact.createElement("UIListLayout", {
                        HorizontalAlignment = if arg1.isMoreMenuEnabled() then nil else Enum.HorizontalAlignment.Right,
                        SortOrder = Enum.SortOrder.LayoutOrder
                    }),
                    ConversationTopModal = Roact.createElement(
                        ConversationTopModalContainer,
                        {
                            conversationId = arg1.props.conversationId,
                            setModalHeight = arg1.setBannerHeight,
                            layoutOrder = 1
                        }
                    ),
                    MessageListFrame = 0,
                    ReplyAndInputContainer = 0,
                    BottomModal = 0
                }

                local createElement2 = Roact.createElement
                local str3 = "Frame"
                local tbl3 = {
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 2,
                    [Roact.Change.AbsoluteSize] = arg1.onMessageListSizeChange,
                    Size = UDim2.new(
                        1,
                        0,
                        1,
                        -arg1.state.inputBarHeight - arg1.state.keyboardOffset - arg1.state.conversationBannerHeight - arg1.state.bottomModalHeight
                    )
                }
                local tbl4 = { MessageListV2 = element }
                local str4 = str1
                local element3

                if element == nil then
                    element3 = Roact.createElement(MessageList, {
                        Size = UDim2.new(1, 0, 1, 0),
                        bottomMargin = 28,
                        conversationId = arg1.props.conversationId,
                        isDebugEnabled = arg1.props.isDebugEnabled,
                        itemList = arg1.props.itemList,
                        loadNext = if bool2 then nil else arg1.loadNext(arg1.props.getOlderMessages, arg1.props.conversationId),
                        localUserId = arg1.props.localUserId,
                        markAsRead = arg1.markAsRead(arg1.props.markConversationAsRead, arg1.props.conversationId),
                        messageListRef = arg1.messageListRef,
                        openViewProfile = arg1.props.openViewProfile,
                        onDetailsOpened = arg1.closeKeyboard,
                        closeKeyboard = arg1.closeKeyboard,
                        inputBoxRef = arg1.inputBoxRef,
                        wideMode = arg1.props.wideMode,
                        viewProfileOnAvatarPressed = arg1.props.viewProfileOnAvatarPressed,
                        readingMessagesIsEnabled = arg1.props.readingMessagesIsEnabled,
                        invalidMessageTypeText = arg1.props.invalidMessageTypeText,
                        messageDefaultNoticeText = arg1.props.messageDefaultNoticeText,
                        messageModeratedNoticeText = arg1.props.messageModeratedNoticeText,
                        messageHiddenNoticeText = arg1.props.messageHiddenNoticeText,
                        unknownUserText = arg1.props.unknownUserText,
                        openGameDetailsPage = arg1.props.openGameDetailsPage,
                        openMomentsDeepLink = arg1.props.openMomentsDeepLink,
                        scrollToTopOnInitialOsaLoad = arg1.props.scrollToTopOnInitialOsaLoad,
                        isInitialMessageLoading = arg1.props.isInitialMessageLoading,
                        onScrolledAwayFromLatestChanged = onScrolledAwayFromLatestChanged,
                        scrollToLatestRef = scrollToLatestRef
                    })
                else
                    element3 = false
                end

                tbl4[str4] = element3

                tbl4.ScrollToLatestButton = element2
                tbl4.UserTypingIndicator = displayNamesAvailable
                    and Roact.createElement(UserTypingIndicator, {
                        AnchorPoint = Vector2.new(0, 1),
                        Position = UDim2.new(0, 0, 1, 0),
                        ZIndex = 2,
                        height = 28,
                        usersTyping = arg1.props.usersTyping,
                        oneUserTyping = arg1.props.oneUserTyping,
                        twoUsersTyping = arg1.props.twoUsersTyping,
                        severalUsersTyping = arg1.props.severalUsersTyping
                    })
                tbl2.MessageListFrame = createElement2(str3, tbl3, tbl4)

                local createElement3 = React.createElement
                local view = Foundation.View
                local tbl5 = {
                    LayoutOrder = 3,
                    tag = {
                        ["col size-full-0 auto-y gap-medium padding-y-medium"] = true,
                        ["bg-surface-100"] = if FFlagAppChatSignalsReplyStore then arg1.props.replyingToMessageId ~= nil else arg1.props.replyingToMessage
                    },
                    onAbsoluteSizeChanged = arg1.onHeightChanged,
                    padding = {
                        left = UDim.new(0, arg4.left),
                        right = var4
                    }
                }
                local tbl6 = {
                    SmartSuggestionsChipRow = if FFlagAppChatSmartSuggestions then React.createElement(SmartSuggestionsChipRowContainer, {
                        LayoutOrder = 0,
                        conversationId = arg1.props.conversationId,
                        sendMessage = arg1.props.sendMessage,
                        sendGameLinkChatMessage = arg1.props.sendGameLinkChatMessage
                    }) else nil,
                    ReplyComposeBar = if if FFlagAppChatSignalsReplyStore then arg1.props.replyingToMessageId else arg1.props.replyingToMessage then Roact.createElement(
                        ReplyComposeBarContainer,
                        {
                            LayoutOrder = 1,
                            message = if FFlagAppChatSignalsReplyStore then nil else arg1.props.replyingToMessage,
                            close = arg1.closeReplying,
                            inputBoxRef = arg1.inputBoxRef
                        }
                    ) else nil,
                    Divider = if arg1.isMoreMenuEnabled() and not (arg1.props.shouldShowChatInputBar or arg1.props.shouldHideMoreMenuButton) then React.createElement(Foundation.View, { LayoutOrder = 4, tag = "size-full-0 auto-y stroke-standard stroke-default" }) else nil,
                    ActionInputContainer = 0,
                    ChatInputBar = 0
                }
                local var6

                if arg1.isMoreMenuEnabled() then
                    local createElement4 = React.createElement
                    local view2 = Foundation.View
                    local tbl7 = {
                        LayoutOrder = 2,
                        tag = "size-full-0 row gap-small auto-y align-y-center"
                    }

                    local tbl8 = { MoreMenu = 0, ChatInputBar = 0 }
                    local element5

                    if arg1.props.shouldHideMoreMenuButton then
                        element5 = nil
                    else
                        element5 = Roact.createElement(ChatConversationMoreMenu, {
                            conversation = arg1.props.conversation,
                            conversationId = arg1.props.conversationId,
                            navigateToSquadLobby = arg1.props.navigateToSquadLobby,
                            layoutOrder = 1,
                            showButtonText = not arg1.props.shouldShowChatInputBar,
                            tooltipText = arg1.state.tooltipText
                        })
                    end

                    tbl8.MoreMenu = element5
                    local element6

                    if arg1.props.shouldShowChatInputBar then
                        element6 = Roact.createElement(var1, {
                            LayoutOrder = 2,
                            onFocusLost = arg1.clearKeyboardOffset,
                            conversationId = arg1.props.conversationId,
                            inputBoxRef = arg1.inputBoxRef,
                            inputBarRef = arg1.inputBarRef,
                            localUserId = arg1.props.localUserId,
                            messageListRef = arg1.messageListRef,
                            onSendChat = arg1.onSendChat(
                                arg1.props.sendMessage,
                                arg1.props.conversationId,
                                arg1.props.markConversationAsRead,
                                arg2,
                                arg1.props.conversation,
                                arg1.props.createFriendConversation,
                                arg1.props.navigateToChatConversation,
                                arg1.props.telemetry
                            ),
                            onSendBtnClicked = arg1.onSendBtnClicked(arg1.props.telemetry),
                            onTextChanged = arg1.chatInputTextChanged,
                            placeholderText = arg1.props.chatInputPlaceholder,
                            isDisabled = arg1.props.shouldDisableChatInputBar,
                            inputBarDisabledText = arg1.props.inputBarDisabledText,
                            disabledEndTimestampDisplay = arg1.props.inputBarDisabledEndTimestampDisplay,
                            onDisabledInputBarActivated = arg1.props.onDisabledInputBarActivated,
                            moreMenuEnabled = arg1.isMoreMenuEnabled()
                        })
                    else
                        element6 = nil
                    end

                    tbl8.ChatInputBar = element6
                    var6 = createElement4(view2, tbl7, tbl8)
                else
                    var6 = nil
                end

                tbl6.ActionInputContainer = var6
                local element5

                if arg1.isMoreMenuEnabled() or not arg1.props.shouldShowChatInputBar then
                    element5 = nil
                else
                    element5 = Roact.createElement(var1, {
                        LayoutOrder = 4,
                        onFocusLost = arg1.clearKeyboardOffset,
                        conversationId = arg1.props.conversationId,
                        inputBoxRef = arg1.inputBoxRef,
                        inputBarRef = arg1.inputBarRef,
                        localUserId = arg1.props.localUserId,
                        messageListRef = arg1.messageListRef,
                        onSendChat = arg1.onSendChat(
                            arg1.props.sendMessage,
                            arg1.props.conversationId,
                            arg1.props.markConversationAsRead,
                            arg2,
                            arg1.props.conversation,
                            arg1.props.createFriendConversation,
                            arg1.props.navigateToChatConversation,
                            arg1.props.telemetry
                        ),
                        onSendBtnClicked = arg1.onSendBtnClicked(arg1.props.telemetry),
                        onTextChanged = arg1.chatInputTextChanged,
                        placeholderText = arg1.props.chatInputPlaceholder,
                        isDisabled = arg1.props.shouldDisableChatInputBar,
                        inputBarDisabledText = arg1.props.inputBarDisabledText,
                        disabledEndTimestampDisplay = arg1.props.inputBarDisabledEndTimestampDisplay,
                        onDisabledInputBarActivated = arg1.props.onDisabledInputBarActivated,
                        moreMenuEnabled = arg1.isMoreMenuEnabled()
                    })
                end

                tbl6.ChatInputBar = element5
                tbl2.ReplyAndInputContainer = createElement3(view, tbl5, tbl6)

                tbl2.BottomModal = React.createElement(ConversationBottomModalContainer, {
                    conversationId = arg1.props.conversationId,
                    layoutOrder = 5,
                    onHeightChanged = arg1.setBottomModalHeight,
                    legacyBottomModalText = arg1.props.bottomModalText,
                    shouldShowLegacyBottomModal = arg1.props.shouldShowLegacyBottomModal,
                    shouldShowChatInputBar = arg1.props.shouldShowChatInputBar
                })
                return createElement(str2, tbl1, tbl2)
            end)
        end)
    end)
end

return connectTelemetry(ChatConversationTelemetryLayer.Context)(RoactNavigation.withNavigation(var3))
