-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Roact = require(AppChatParent.Roact)
local BidirectionalFlatList = require(AppChatParent.VirtualizedList).BidirectionalFlatList
local Promise = require(AppChatParent.Promise)
local ReactFocusNavigation = require(AppChatParent.ReactFocusNavigation)
local FocusNavigationService = ReactFocusNavigation.FocusNavigationService
local CoreGui = ReactFocusNavigation.EngineInterface.CoreGui

local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)
local FFlagAppChatScrollToLatest = require(AppChat.Flags.FFlagAppChatScrollToLatest)
local createScrollIntervalTracker = require(AppChat.Telemetry.createScrollIntervalTracker)
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)

local MessageModel = require(AppChat.Models.MessageModel)
local EnumMessageTypes = require(AppChat.Components.ChatConversation.EnumMessageTypes)
local MessageModel2 = require(AppChat.Models.MessageModel)
local getLastMessageWithFilter = require(script.Parent.Utils.getLastMessageWithFilter)
local isScrolledAwayFromLatest = require(script.Parent.ScrollToLatest.isScrolledAwayFromLatest)

local ChatMessage = require(script.Parent.ChatMessage)
local SystemMessage = require(script.Parent.SystemMessage)
local SystemMessageContainer = require(script.Parent.SystemMessageContainer)
local CustomMessageEntryContainer = require(script.Parent.CustomMessageEntryContainer)

local GetFFlagEnableSocialCards = require(AppChatParent.SharedFlags).GetFFlagEnableSocialCards
local FIntAppChatMessageInitialFetchMinMessages = require(AppChat.Flags.FIntAppChatMessageInitialFetchMinMessages)
local FIntAppChatInitialMessageFetchLimit = require(AppChat.Flags.FIntAppChatInitialMessageFetchLimit)
local FFlagAppChatGuardOsaScrollToIndex = require(AppChat.Flags.FFlagAppChatGuardOsaScrollToIndex)
local FIntAppChatOsaAutoScrollDelayMs = require(AppChat.Flags.FIntAppChatOsaAutoScrollDelayMs)

local FFlagAppChatConversationLoadingSkeleton = require(AppChat.Flags.FFlagAppChatConversationLoadingSkeleton)
local ConversationMessageSkeletonList = if FFlagAppChatConversationLoadingSkeleton then require(script.Parent.ConversationMessageSkeletonList) else nil
local FFlagAppChatEnableAutotranslation = require(AppChat.Flags.FFlagAppChatEnableAutotranslation)

local FFlagAppChatAutotranslationRespectsExperienceChatSetting = require(AppChat.Flags.FFlagAppChatAutotranslationRespectsExperienceChatSetting)

local windowSize = game:DefineFastInt("AppChatPerfChatConversationPaginationWindowSize", 2)

local num2 = game:DefineFastInt("AppChatPerfChatConversationPaginationInitialRender", 10)

local onStartReachedThreshold = game:DefineFastInt("AppChatPerfChatConversationPaginationOnStartReached", 64)

local onEndReachedThreshold = game:DefineFastInt("AppChatPerfChatConversationPaginationOnEndReached", 100)

local function isIncomingChatMessage(arg1)
    return arg1.isIncoming and (arg1.messageType == EnumMessageTypes.PlainText or arg1.messageType == EnumMessageTypes.Link)
end

local var1 = Roact.PureComponent:extend("MessageList")
var1.defaultProps = {
    Size = UDim2.new(1, 0, 1, 0),
    autoScrollMaxIndex = 3,
    bottomMargin = 10,
    conversationId = nil,
    initialFocusIndex = 1,
    isDebugEnabled = false,
    itemList = {},
    loadNext = function() end,
    markAsRead = function() end,
    messageListRef = nil,
    onDetailsOpened = function() end,
    openGameDetailsPage = function(_, _) end,
    openViewProfile = nil,
    wideMode = false,
    viewProfileOnAvatarPressed = true,
    closeKeyboard = function() end,
    inputBoxRef = nil,
    invalidMessageTypeText = "PLACEHOLDER This message could not be displayed",
    messageDefaultNoticeText = "PLACEHOLDER Not everyone in this chat can see your message.",
    messageModeratedNoticeText = "PLACEHOLDER Your message was moderated and not sent.",
    unknownUserText = "PLACEHOLDER unknown user",
    scrollToTopOnInitialOsaLoad = false
}

local function compareItemData(arg1, arg2): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1 == nil or arg2 == nil then
        return false
    end

    return arg1.stable_key ~= nil and arg1.stable_key == arg2.stable_key
        or not (arg1.messageId == nil) and arg1.messageId == arg2.messageId
end

function var1.init(arg1)
    arg1.state = {
        width = 0,
        startIndex = 1,
        firstItem = arg1.props.itemList[1]
    }

    arg1.focusIndex = arg1.props.initialFocusIndex

    if FFlagAppChatPerfTracking then
        arg1._scrollIntervalTracker = nil
    end

    function arg1.isValidMessageAndSenderType(arg2, arg3): boolean
        if arg3 == MessageModel.SenderTypes.System then
            return arg2 == EnumMessageTypes.System
        end

        if arg3 == MessageModel.SenderTypes.User then
            return arg2 == EnumMessageTypes.PlainText or arg2 == EnumMessageTypes.Link
        end

        return arg2 == EnumMessageTypes.Custom
    end

    arg1.ref = arg1.props.messageListRef or Roact.createRef()
    local chatTranslationEnabled = if FFlagAppChatAutotranslationRespectsExperienceChatSetting then game:GetService("TextChatService").ChatTranslationEnabled else false
    arg1.lastIncomingChatMessageId = nil
    if arg1.props.itemList then
        arg1.lastIncomingChatMessageId = getLastMessageWithFilter(arg1.props.itemList, isIncomingChatMessage)
    end

    function arg1.renderItem(arg2)
        if not arg1.isValidMessageAndSenderType(arg2.messageType, arg2.senderType) then
            return Roact.createElement(SystemMessage, { Text = arg1.props.invalidMessageTypeText })
        end

        local isDebugEnabled = arg1.props.isDebugEnabled and Roact.createElement("StringValue", { Value = tostring(arg2.messageId) })

        if arg2.messageType == EnumMessageTypes.Custom then
            return Roact.createElement(CustomMessageEntryContainer, {
                openViewProfile = arg1.props.openViewProfile,
                customEntryType = arg2.customEntryType,
                conversationId = arg1.props.conversationId
            })
        end

        if arg2.messageType == EnumMessageTypes.System then
            return Roact.createElement(SystemMessageContainer, {
                cards = if GetFFlagEnableSocialCards() then arg2.cards else nil,
                text = arg2.content,
                parentWidth = arg1.state.width,
                sent = arg2.sent,
                showDateTime = arg2.showDateTime,
                messageId = arg2.messageId,
                senderTargetId = if GetFFlagEnableSocialCards() then arg2.senderTargetId else nil,
                conversationId = arg1.props.conversationId,
                debugElement = isDebugEnabled
            })
        end

        local additionalProps = arg2.additionalProps
        if additionalProps then
            additionalProps.onDetailsOpened = arg1.props.onDetailsOpened
        end

        local var2 = additionalProps or {}

        var2.openGameDetailsPage = arg1.props.openGameDetailsPage
        var2.openMomentsDeepLink = arg1.props.openMomentsDeepLink
        var2.shareLink = arg2.shareLink
        local contentToDisplay = if FFlagAppChatEnableAutotranslation then if FFlagAppChatAutotranslationRespectsExperienceChatSetting then if chatTranslationEnabled then arg2.contentToDisplay else nil else arg2.contentToDisplay else nil
        return Roact.createElement(ChatMessage, {
            additionalProps = var2,
            content = arg2.content,
            debugElement = isDebugEnabled,
            failed = arg2.failed,
            filteredForReceivers = arg2.filteredForReceivers,
            isIncoming = arg2.isIncoming,
            isNewSender = arg2.isNewSender,
            isSending = arg2.isSending,
            isUnfiltered = arg2.moderationType == MessageModel2.ModerationTypes.TrustedComms,
            isLastMessageInMessageGroup = arg2.isLastMessageInMessageGroup,
            isLastIncomingChatMessage = arg2.messageId == arg1.lastIncomingChatMessageId,
            messageDefaultNoticeText = arg1.props.messageDefaultNoticeText,
            conversationId = arg1.props.conversationId,
            messageId = arg2.messageId,
            messageModeratedNoticeText = arg1.props.messageModeratedNoticeText,
            messageHiddenNoticeText = arg1.props.messageHiddenNoticeText,
            messageType = arg2.messageType,
            moderated = arg2.moderated,
            openViewProfile = arg1.props.openViewProfile,
            parentWidth = arg1.state.width,
            readingMessagesIsEnabled = true,
            senderUserId = arg2.senderTargetId,
            sent = arg2.sent,
            showDateTime = arg2.showDateTime,
            showDisplayName = arg2.showDisplayName,
            shouldShowName = arg2.sender.shouldShowName,
            thumbnail = arg2.sender.thumbnail,
            wideMode = arg1.props.wideMode,
            unknownUserText = arg1.props.unknownUserText,
            viewProfileOnAvatarPressed = arg1.props.viewProfileOnAvatarPressed,
            closeKeyboard = arg1.props.closeKeyboard,
            inputBoxRef = arg1.props.inputBoxRef,
            repliesTo = arg2.repliesTo,
            visibility = arg2.visibility,
            translatedText = contentToDisplay
        })
    end

    function arg1.updateWidth(arg2)
        if arg2.AbsoluteSize.X ~= arg1.state.width then
            arg1:setState({ width = arg2.AbsoluteSize.X })
        end
    end

    function arg1.changeFocus(arg2)
        arg1.isNearBottom = arg2.anchorIndex <= arg1.props.autoScrollMaxIndex + 1

        arg1.focusIndex = if arg1.isNearBottom then 1 else arg2.anchorIndex + 1

        if arg2.anchorIndex == 1 and not arg1.props.itemList[1].read then
            arg1.props.markAsRead()
        end
    end

    function arg1.identifier(arg2)
        return arg2.messageId .. "|" .. (arg2.position or "")
    end

    function arg1.getScrollRef()
        if arg1.ref.current == nil then
            return nil
        end

        local nativeScrollRef = arg1.ref.current._listRef._scrollRef.getNativeScrollRef()
        return if nativeScrollRef == nil then nil else nativeScrollRef._nativeRef.current
    end

    function arg1.calculateScrollOffset(arg2)
        local canvasPositionY = arg2.CanvasPosition.Y
        local absoluteCanvasSizeY = arg2.AbsoluteCanvasSize.Y
        local absoluteWindowSizeY = arg2.AbsoluteWindowSize.Y
        return absoluteCanvasSizeY - canvasPositionY - absoluteWindowSizeY
    end

    arg1.wasScrolledAwayFromLatest = false
    function arg1.setScrolledAwayFromLatest(wasScrolledAwayFromLatest: boolean)
        local onScrolledAwayFromLatestChanged = arg1.props.onScrolledAwayFromLatestChanged
        if onScrolledAwayFromLatestChanged ~= nil and wasScrolledAwayFromLatest ~= arg1.wasScrolledAwayFromLatest then
            arg1.wasScrolledAwayFromLatest = wasScrolledAwayFromLatest
            onScrolledAwayFromLatestChanged(wasScrolledAwayFromLatest)
        end
    end
    function arg1.reportScrolledAwayFromLatest(arg2)
        arg1.setScrolledAwayFromLatest(isScrolledAwayFromLatest(arg1.calculateScrollOffset(arg2), arg2.AbsoluteWindowSize.Y))
    end

    arg1.scrolledAwayConnections = nil
    function arg1.disconnectScrolledAwayListener()
        if arg1.scrolledAwayConnections == nil then
            return
        end
        for _, scrolledAwayConnection in arg1.scrolledAwayConnections do
            scrolledAwayConnection:Disconnect()
        end
        arg1.scrolledAwayConnections = nil
    end
    function arg1.connectScrolledAwayListener()
        if arg1.props.onScrolledAwayFromLatestChanged == nil then
            return
        end
        local scrollRef = arg1.getScrollRef()

        if scrollRef == nil then
            arg1.disconnectScrolledAwayListener()
            arg1.setScrolledAwayFromLatest(false)
            return
        end

        if arg1.scrolledAwayConnections ~= nil then
            return
        end

        local scrolledAwayConnections = {}
        arg1.scrolledAwayConnections = scrolledAwayConnections

        local bool1 = false
        local function report() -- Luacid: Inlined by compiler; 1 call site recovered
            if bool1 then
                return
            end
            bool1 = true
            task.defer(function()
                bool1 = false
                if arg1.scrolledAwayConnections == scrolledAwayConnections then
                    arg1.reportScrolledAwayFromLatest(scrollRef)
                end
            end)
        end

        for _, value in { "CanvasPosition", "AbsoluteCanvasSize", "AbsoluteWindowSize" } do
            local var2 = scrollRef:GetPropertyChangedSignal(value)
            table.insert(scrolledAwayConnections, var2:Connect(report))
        end

        report()
    end

    function arg1.scrollToLatest()
        local _listRef = arg1.ref.current and arg1.ref.current._listRef
        if _listRef then
            _listRef:scrollToOffset({ offset = 0, animated = false })
        end
    end

    function arg1.onScroll(arg2)
        if FFlagAppChatPerfTracking then
            if arg1._scrollIntervalTracker == nil then
                local scrollRef = arg1.getScrollRef()
                if scrollRef ~= nil then
                    arg1._scrollIntervalTracker = createScrollIntervalTracker(
                        AppChatPerfTracker.Events.ScrollMessageList,
                        scrollRef,
                        {
                            conversationId = arg1.props.conversationId
                        }
                    )
                end
            end

            if arg1._scrollIntervalTracker then
                arg1._scrollIntervalTracker.onScrollTick()
            end
        end

        local scrollOffset = arg1.calculateScrollOffset(arg2)
        if scrollOffset < 512 then
            arg1:setState(function(_, arg3)
                return {
                    firstItem = arg3.itemList[1]
                }
            end)
        end

        if scrollOffset < 64 then
            arg1.props.markAsRead()
        end
        arg1.isNearBottom = scrollOffset < 64

        if FFlagAppChatScrollToLatest then
            arg1.connectScrolledAwayListener()
        end
    end

    function arg1.onScrollToIndexFailed()
        local current = arg1.ref.current
        if current ~= nil then
            current:scrollToEnd({ animated = false })
        end
    end

    arg1.initialFetchesAttempted = 0
    arg1.focusNavigationService = FocusNavigationService.new(CoreGui)
end

function var1.getDerivedStateFromProps(arg1, arg2)
    if arg2.firstItem == nil then
        return { startIndex = 1 }
    end

    local num5 = 1

    while num5 <= #arg1.itemList and not compareItemData(arg1.itemList[num5], arg2.firstItem) do
        num5 += 1
    end

    return if #arg1.itemList < num5 then { startIndex = 1 } else { startIndex = num5 }
end

function var1.didUpdate(arg1, arg2, _)
    if FFlagAppChatPerfTracking and #arg1.props.itemList > #arg2.itemList then
        AppChatPerfTracker.finish(
            AppChatPerfTracker.Events.PaginationMessageList,
            {
                conversationId = arg1.props.conversationId
            }
        )
    end
    if arg1.props.itemList and #arg1.props.itemList == 0 and arg2.itemList and #arg2.itemList > 0 then
        arg1.initialFetchesAttempted = 0
    end

    if arg1.props.itemList
        and arg1.props.itemList ~= arg2.itemList
        and arg1.initialFetchesAttempted < FIntAppChatInitialMessageFetchLimit
        and #arg1.props.itemList < FIntAppChatMessageInitialFetchMinMessages
        and arg1.props.loadNext
    then
        arg1.initialFetchesAttempted += 1
        arg1.props.loadNext()
    end

    if arg2.conversationId ~= arg1.props.conversationId then
        arg1.isNearBottom = true
    end

    local scrollRef = arg1.getScrollRef()
    if (if scrollRef == nil then 0 else arg1.calculateScrollOffset(scrollRef)) < 64 then
        arg1.isNearBottom = true

        if #arg1.props.itemList > 0 then
            arg1.props.markAsRead()
        end
    end

    if arg2.readingMessagesIsEnabled ~= arg1.props.readingMessagesIsEnabled
        and arg1.props.readingMessagesIsEnabled
        and arg1.isNearBottom
    then
        arg1.props.markAsRead()
    end

    if arg1.props.scrollToTopOnInitialOsaLoad and not arg2.scrollToTopOnInitialOsaLoad and #arg1.props.itemList > 0 then
        local current = arg1.ref and arg1.ref.current

        if current and current.scrollToEnd then
            task.delay(FIntAppChatOsaAutoScrollDelayMs / 1000, function()
                if not FFlagAppChatGuardOsaScrollToIndex then
                    current:scrollToIndex({ index = #arg1.props.itemList, animated = false })
                    return
                end

                local current2 = arg1.ref.current
                local index = #arg1:getRenderedItemList()
                if current2 ~= nil and index > 0 then
                    current2:scrollToIndex({ index = index, animated = false })
                end
            end)
        end
    end

    if arg1.props.itemList and not arg1.lastIncomingChatMessageId then
        arg1.lastIncomingChatMessageId = getLastMessageWithFilter(arg1.props.itemList, isIncomingChatMessage)
    end

    if FFlagAppChatScrollToLatest then
        arg1.connectScrolledAwayListener()
    end
end

function var1.didMount(arg1)
    if #arg1.props.itemList < FIntAppChatMessageInitialFetchMinMessages and arg1.props.loadNext then
        arg1.props.loadNext()
    end
    arg1.isNearBottom = true
    local scrollRef = arg1.getScrollRef()
    if scrollRef ~= nil then
        scrollRef.Selectable = false
    end
    if not FFlagAppChatScrollToLatest then
        return
    end

    if arg1.props.scrollToLatestRef then
        arg1.props.scrollToLatestRef.current = arg1.scrollToLatest
    end
    arg1.connectScrolledAwayListener()
end

function var1.willUnmount(arg1)
    if FFlagAppChatPerfTracking and arg1._scrollIntervalTracker then
        arg1._scrollIntervalTracker.cleanup()
    end
    if FFlagAppChatScrollToLatest then
        local scrollToLatestRef = arg1.props.scrollToLatestRef
        if scrollToLatestRef and scrollToLatestRef.current == arg1.scrollToLatest then
            scrollToLatestRef.current = nil
        end
        arg1.disconnectScrolledAwayListener()
    end
    arg1.focusNavigationService:teardown()
end

function var1.getRenderedItemList(arg1)
    local renderedItemList = {}
    local startIndex = arg1.state.startIndex
    if startIndex ~= 1 then
        local scrollRef = arg1.getScrollRef()
        startIndex = if (if scrollRef == nil then 0 else arg1.calculateScrollOffset(scrollRef)) < 128 then 1 else startIndex
    end

    if startIndex == 1 or compareItemData(arg1.props.itemList[1], arg1.state.firstItem) then
        return arg1.props.itemList
    end
    table.move(arg1.props.itemList, startIndex, #arg1.props.itemList, 1, renderedItemList)

    return renderedItemList
end

function var1.renderScrollingFrame(arg1)
    local renderedItemList = arg1:getRenderedItemList()

    local createElement = Roact.createElement
    local var2 = BidirectionalFlatList

    local tbl1 = {
        data = renderedItemList,
        renderItem = function(arg2)
            return arg1.renderItem(arg2.item)
        end,
        inverted = true,
        Size = arg1.props.Size,
        style = { BackgroundTransparency = 1, ScrollBarThickness = 0, Name = "MessageList" },
        contentContainerStyle = { BackgroundTransparency = 1 },
        keyExtractor = function(arg2, arg3)
            return arg2.stable_key or arg2.messageId or arg3
        end,
        windowSize = windowSize,
        initialNumToRender = arg1.props.scrollToTopOnInitialOsaLoad and #renderedItemList or num2,
        onScroll = arg1.onScroll,
        onScrollToIndexFailed = if FFlagAppChatGuardOsaScrollToIndex then arg1.onScrollToIndexFailed else nil
    }

    function tbl1.onEndReached()
        if FFlagAppChatPerfTracking then
            AppChatPerfTracker.start(
                AppChatPerfTracker.Events.PaginationMessageList,
                {
                    conversationId = arg1.props.conversationId
                }
            )
        end

        arg1.props.loadNext()
        return Promise.resolve()
    end
    tbl1.onEndReachedThreshold = onEndReachedThreshold
    tbl1.onStartReachedThreshold = onStartReachedThreshold
    tbl1.compareItemData = compareItemData
    tbl1.scrollEventThrottle = arg1.props.scrollEventThrottle or 75
    tbl1[Roact.Ref] = arg1.ref
    tbl1.autoscrollToTopThreshold = 33
    tbl1.enableAutoscrollToTop = true

    function tbl1.ListHeaderComponent()
        return Roact.createElement("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 10) })
    end

    tbl1.showDefaultLoadingIndicators = false
    function tbl1.onContentSizeChange(width: number, _: number)
        arg1:setState({ width = width })
    end

    tbl1.optimizeInvertedCanvasResize = true
    tbl1.UNSTABLE_forceSiblingLayoutUpdate = true
    return createElement(var2, tbl1)
end

function var1.renderEmptyMessageList(arg1)
    return Roact.createElement("Frame", { Size = arg1.props.Size, BackgroundTransparency = 1 })
end

function var1.render(arg1)
    if FFlagAppChatConversationLoadingSkeleton and arg1.props.isInitialMessageLoading then
        return Roact.createElement(ConversationMessageSkeletonList, { size = arg1.props.Size })
    elseif #arg1.props.itemList ~= 0 then
        return (arg1:renderScrollingFrame())
    end

    return (arg1:renderEmptyMessageList())
end

return var1
