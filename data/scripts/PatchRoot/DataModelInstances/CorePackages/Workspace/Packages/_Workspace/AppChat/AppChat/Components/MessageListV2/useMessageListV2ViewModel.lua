-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Signals = require(AppChatParent.Signals)
local SignalsReact = require(AppChatParent.SignalsReact)
local ViewRecycler = require(AppChatParent.ViewRecycler)

local EnumMessageTypes = require(AppChat.Components.ChatConversation.EnumMessageTypes)
local isScrolledAwayFromLatest = require(AppChat.Components.ChatConversation.ScrollToLatest.isScrolledAwayFromLatest)
local GetConversationMessageViewModelStore = require(AppChat.Stores.GetConversationMessageViewModelStore)
local ListItems = require(script.Parent.ListItems)
local _MessageListContext = require(script.Parent.MessageListContext)
local MessageRowTypes = require(script.Parent.MessageRowTypes)
local useDelayedScrollToStart = require(script.Parent.useDelayedScrollToStart)
local useInitialScrollAlignment = require(script.Parent.useInitialScrollAlignment)
local useMessageListLayout = require(script.Parent.useMessageListLayout)
local useViewportResizeCompensation = require(script.Parent.useViewportResizeCompensation)
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)
local createScrollIntervalTracker = require(AppChat.Telemetry.createScrollIntervalTracker)

local FFlagAppChatConversationLoadingSkeleton = require(AppChat.Flags.FFlagAppChatConversationLoadingSkeleton)
local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)
local FFlagAppChatScrollToLatest = require(AppChat.Flags.FFlagAppChatScrollToLatest)
local FIntAppChatInitialMessageFetchLimit = require(AppChat.Flags.FIntAppChatInitialMessageFetchLimit)
local FFlagAppChatMessageListV2ScrollToStartOnOpen = require(AppChat.Flags.FFlagAppChatMessageListV2ScrollToStartOnOpen)
local FFlagAppChatMessageListV2StableRowCallbacks = require(AppChat.Flags.FFlagAppChatMessageListV2StableRowCallbacks)
local FFlagAppChatMessageListV2ScrollParity = require(AppChat.Flags.FFlagAppChatMessageListV2ScrollParity)
local FFlagAppChatMessageListV2FollowIncoming = require(AppChat.Flags.FFlagAppChatMessageListV2FollowIncoming)
local FFlagAppChatMessageListV2ShowBeforeMeasured = require(AppChat.Flags.FFlagAppChatMessageListV2ShowBeforeMeasured)
local FIntAppChatMessageListV2OverscanRows = require(AppChat.Flags.FIntAppChatMessageListV2OverscanRows)

local FIntAppChatMessageListV2StartReachedViewports = require(AppChat.Flags.FIntAppChatMessageListV2StartReachedViewports)
local FIntAppChatMessageInitialFetchMinMessages = require(AppChat.Flags.FIntAppChatMessageInitialFetchMinMessages)

local startReachedThreshold = {
    viewportFraction = math.max(0, FIntAppChatMessageListV2StartReachedViewports)
}

local function noop() end

local function isIncomingChatMessage(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1.isIncoming == true and (arg1.messageType == EnumMessageTypes.PlainText or arg1.messageType == EnumMessageTypes.Link)
end

local function findNewestIncomingChatMessageId(items) -- Luacid: Inlined by compiler; 1 call site recovered
    for i = #items, 1, -1 do
        if isIncomingChatMessage(items[i]) then
            return items[i].messageId
        end
    end
    return nil
end

local function useStableRowCallbacks(tbl2, bool1: boolean)
    local var1 = React.useMemo(function()
        local function forward(str1: string) -- Luacid: Inlined by compiler; 5 call sites recovered
            return function(...)
                local var1 = tbl2.current[str1]
                if var1 ~= nil then
                    return var1(...)
                end
                return nil
            end
        end

        return {
            closeKeyboard = forward("closeKeyboard"),
            onDetailsOpened = forward("onDetailsOpened"),
            openGameDetailsPage = forward("openGameDetailsPage"),
            openMomentsDeepLink = forward("openMomentsDeepLink"),
            openViewProfile = forward("openViewProfile")
        }
    end, {})
    return {
        closeKeyboard = var1.closeKeyboard,
        onDetailsOpened = var1.onDetailsOpened,
        openGameDetailsPage = var1.openGameDetailsPage,
        openMomentsDeepLink = if bool1 then var1.openMomentsDeepLink else nil,
        openViewProfile = var1.openViewProfile
    }
end

local function useMessageListV2ViewModel(current)
    local var1 = React.useRef(current)
    var1.current = current
    local conversationId = current.conversationId

    local var2 = React.useRef(nil)
    local var3 = React.useMemo(function()
        return ListItems.build(current.itemList, var2.current)
    end, { current.itemList })
    var2.current = var3
    local items = var3.items
    local itemsLen = #items

    local var4 = React.useRef(nil)
    if var4.current == nil then
        var4.current = findNewestIncomingChatMessageId(items)
    end
    local current2 = var4.current

    local var5 = React.useRef(itemsLen)
    React.useEffect(function()
        if FFlagAppChatPerfTracking and itemsLen > var5.current then
            AppChatPerfTracker.finish(AppChatPerfTracker.Events.PaginationMessageList, { conversationId = conversationId })
        end

        var5.current = itemsLen
    end, { itemsLen, conversationId })

    local var6 = React.useRef(0)

    local item = items[itemsLen]
    local key = if item == nil then nil else ListItems.getKey(item)
    local var7 = React.useRef(key)
    React.useEffect(function()
        local current3 = var7.current
        var7.current = key
        if current3 ~= nil and key ~= nil and key ~= current3 and var6.current < 64 then
            var1.current.markAsRead()
        end
    end, { key })

    local var8 = React.useRef(nil)

    local var9 = React.useMemo(function()
        return Signals.createComputed(function(arg1): boolean
            local var9 = GetConversationMessageViewModelStore(false).conversationMessageListStore.getMetadata(conversationId, arg1)
            return not (var9 == nil) and var9.isLoading == true
        end)
    end, { conversationId })
    local var10 = SignalsReact.useSignalState(var9)
    React.useEffect(function()
        if not var10 then
            var8.current = nil
        end
    end, { var10 })
    local var11 = React.useCallback(function()
        local loadNext = var1.current.loadNext
        if loadNext == nil then
            return
        end
        local items2 = var2.current.items
        local item2 = items2[1]
        local str1 = `{#items2}:{if item2 == nil then "" else ListItems.getKey(item2)}`
        if var8.current == str1 then
            return
        end
        var8.current = str1
        if FFlagAppChatPerfTracking then
            AppChatPerfTracker.start(AppChatPerfTracker.Events.PaginationMessageList, { conversationId = conversationId })
        end

        loadNext()
    end, { conversationId })

    local bool1 = current.openAtStart == true
    local var12 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local conversationMessageListStore = GetConversationMessageViewModelStore(false).conversationMessageListStore
            local metadata = conversationMessageListStore.getMetadata(conversationId, arg1)
            if metadata ~= nil and metadata.fetchedOldest == true then
                return nil
            end
            local num1 = #conversationMessageListStore.getOrderedIds(conversationId, arg1)
            return if bool1 or not (FIntAppChatMessageInitialFetchMinMessages <= num1) then num1 else nil
        end)
    end, { conversationId, bool1 })
    local var13 = SignalsReact.useSignalState(var12)
    local bool2 = current.loadNext ~= nil
    local bool3 = bool2 and var13 ~= nil

    local var14 = React.useRef(0)

    local var15 = React.useRef(nil)
    local var16 = React.useRef(false)
    local var17, var18 = React.useState(false)
    React.useEffect(function()
        if not bool3 or bool1 or not (var14.current < FIntAppChatInitialMessageFetchLimit) then
            return
        end
        local var19 = var14
        var19.current += 1
        var15.current = var13
        var16.current = false
        var11()

        local var20 = GetConversationMessageViewModelStore(false).conversationMessageListStore.getMetadata(conversationId)
        if var20 == nil or var20.isLoading ~= true then
            var18(true)
        end
    end, {
        conversationId,
        var13,
        bool3,
        bool1,
        var11
    })

    React.useEffect(function()
        if var10 then
            var16.current = true
            return
        end
        if not var16.current then
            return
        end
        if var13 == var15.current then
            var18(true)
            return
        end

        if var14.current >= FIntAppChatInitialMessageFetchLimit then
            var18(true)
        end
    end, { var10, var13 })

    local listRef = React.useRef(nil)
    local var20 = React.useRef(nil)
    local var21, var22 = React.useState(nil)

    local var23 = if FFlagAppChatMessageListV2ScrollParity then useViewportResizeCompensation(listRef, var21) else nil

    React.useEffect(function()
        if not FFlagAppChatPerfTracking or var21 == nil then
            return nil
        end
        local scrollIntervalTracker = createScrollIntervalTracker(AppChatPerfTracker.Events.ScrollMessageList, var21, { conversationId = conversationId })

        var20.current = scrollIntervalTracker
        return function()
            scrollIntervalTracker.cleanup()
            var20.current = nil
        end
    end, { var21, conversationId })

    local var24 = React.useRef(false)
    local var25 = React.useCallback(function(arg1)
        local onScrolledAwayFromLatestChanged = var1.current.onScrolledAwayFromLatestChanged
        if onScrolledAwayFromLatestChanged == nil then
            return
        end
        local var19 = isScrolledAwayFromLatest(arg1.distanceFromEnd, arg1.viewportLength)
        if var19 ~= var24.current then
            var24.current = var19
            onScrolledAwayFromLatestChanged(var19)
        end
    end, {})

    local scrollToLatestRef = current.scrollToLatestRef
    React.useEffect(function()
        if not FFlagAppChatScrollToLatest or scrollToLatestRef == nil then
            return nil
        end
        local function scrollToLatest()
            local current3 = listRef.current
            if current3 ~= nil then
                current3.scrollToEnd()
            end
        end
        scrollToLatestRef.current = scrollToLatest
        return function()
            if scrollToLatestRef.current == scrollToLatest then
                scrollToLatestRef.current = nil
            end
        end
    end, { scrollToLatestRef })

    local onScrollOffsetChanged = React.useCallback(function()
        if var20.current ~= nil then
            var20.current.onScrollTick()
        end
        local current3 = listRef.current
        if current3 == nil then
            return
        end
        local scrollState = current3.getScrollState()
        local distanceFromEnd = scrollState.distanceFromEnd
        var6.current = distanceFromEnd
        if var23 ~= nil then
            var23.onScrolled(distanceFromEnd)
        end
        if distanceFromEnd < 64 and #var2.current.items > 0 then
            var1.current.markAsRead()
        end
        if FFlagAppChatScrollToLatest then
            var25(scrollState)
        end
    end, { var23 })

    local var27 = React.useCallback(function()
        local current3 = listRef.current
        if current3 ~= nil then
            var25(current3.getScrollState())
        end
    end, {})
    local onContentLengthChanged = React.useCallback(function()
        if var23 ~= nil then
            var23.onContentLengthChanged()
        end
        var27()
    end, { var23 })

    local readingMessagesIsEnabled = current.readingMessagesIsEnabled
    local var29 = React.useRef(readingMessagesIsEnabled)
    React.useEffect(function()
        local current3 = var29.current
        var29.current = readingMessagesIsEnabled
        if readingMessagesIsEnabled and not current3 and var6.current < 64 then
            var1.current.markAsRead()
        end
    end, { readingMessagesIsEnabled })

    local width, var31 = React.useState(0)
    local onViewportChanged = React.useCallback(function(vector2: Vector2)
        var31(vector2.X)
        if var23 ~= nil then
            var23.onViewportChanged(vector2.Y)
        end
        if FFlagAppChatScrollToLatest then
            var27()
        end
    end, { var23 })

    local scrollingFrameRef = React.useCallback(function(arg1)
        if arg1 ~= nil then
            arg1.Selectable = false
        end
        if var23 ~= nil then
            var23.onScrollingFrameChanged(arg1)
        end
        var22(arg1)
    end, { var23 })

    local isLoading = current.isInitialMessageLoading == true or bool3 and (bool1 or not var17)

    local var34 = React.useRef(nil)
    if var34.current == nil and not isLoading then
        var34.current = if bool1 then ViewRecycler.ScrollAlignment.Start else ViewRecycler.ScrollAlignment.End
    end

    local current3 = var34.current

    local var35 = React.useRef(var3.byKey)
    local var36 = React.useRef(false)

    local var37 = React.useRef(nil)
    local var38 = React.useRef(nil)
    if FFlagAppChatMessageListV2FollowIncoming and var38.current ~= var3 then
        var38.current = var3
        local current4 = listRef.current
        var37.current = if current4 == nil then nil else current4.getScrollState().distanceFromEnd
    end
    React.useEffect(function()
        local current4 = var35.current
        var35.current = var3.byKey
        local current5 = var36.current
        var36.current = not isLoading
        local item2 = var3.items[#var3.items]
        local current6 = listRef.current
        if not current5 or current6 == nil or item2 == nil or current4[ListItems.getKey(item2)] ~= nil then
            return
        end

        local current7 = var37.current
        if item2.isIncoming ~= true then
            current6.scrollToEnd()
        elseif FFlagAppChatMessageListV2FollowIncoming and current7 ~= nil and current7 < 33 then
            current6.scrollToEnd()
        end
    end, { var3, isLoading })

    if FFlagAppChatMessageListV2ScrollToStartOnOpen then
        current3 = useInitialScrollAlignment(bool1, isLoading, listRef, var21)
    end

    if FFlagAppChatMessageListV2ScrollParity then
        useDelayedScrollToStart(bool1, isLoading, listRef)
    end

    local var39, var40 = React.useState(false)
    local var41 = React.useCallback(function()
        var40(true)
    end, {})
    local var42 = useMessageListLayout

    if FFlagAppChatMessageListV2ShowBeforeMeasured then
        var41 = nil
    end

    local layout = var42(var41)

    local var44 = React.useRef(false)
    local var45 = FFlagAppChatMessageListV2ShowBeforeMeasured or var44.current or var39 or itemsLen == 0
    if not isLoading then
        var44.current = var45
    end
    local listProps = React.useMemo(function()
        local var46 = table.clone(ViewRecycler.ChatPreset.create({ startReachedThreshold = startReachedThreshold }))

        var46.initialScrollAlignment = current3 or var46.initialScrollAlignment
        var46.data = {
            items = items,
            getItemKey = ListItems.getKey
        }
        var46.layout = layout
        var46.axis = ViewRecycler.Axis.Y
        var46.itemType = MessageRowTypes.MessageRowType
        var46.pinnedEndItem = MessageRowTypes.EndSpacerItem
        var46.listRef = listRef
        var46.overscan = FIntAppChatMessageListV2OverscanRows
        var46.onStartReached = if bool2 then var11 else nil
        var46.onScrollOffsetChanged = onScrollOffsetChanged
        if var23 ~= nil then
            var46.onContentLengthChanged = var23.onContentLengthChanged
        end
        if FFlagAppChatScrollToLatest then
            var46.onContentLengthChanged = onContentLengthChanged
        end
        var46.onViewportChanged = onViewportChanged
        var46.scrollingFrameRef = scrollingFrameRef
        var46.scrollingFrameProps = {
            Name = "MessageList",
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 0,
            Visible = var45
        }
        return var46
    end, {
        scrollingFrameRef,
        bool2,
        current3,
        var45,
        items,
        layout,
        onContentLengthChanged,
        onScrollOffsetChanged,
        onViewportChanged,
        var11,
        var23
    })

    local tbl2 = current
    if FFlagAppChatMessageListV2StableRowCallbacks then
        tbl2 = useStableRowCallbacks(var1, current.openMomentsDeepLink ~= nil)
    end

    return {
        contextValue = React.useMemo(function()
            return {
                conversationId = conversationId,
                width = width,
                wideMode = current.wideMode == true,
                isDebugEnabled = current.isDebugEnabled == true,
                lastIncomingChatMessageId = current2,
                viewProfileOnAvatarPressed = current.viewProfileOnAvatarPressed ~= false,
                inputBoxRef = current.inputBoxRef,
                closeKeyboard = tbl2.closeKeyboard or noop,
                onDetailsOpened = tbl2.onDetailsOpened or noop,
                openGameDetailsPage = tbl2.openGameDetailsPage or noop,
                openMomentsDeepLink = tbl2.openMomentsDeepLink,
                openViewProfile = tbl2.openViewProfile or noop,
                invalidMessageTypeText = current.invalidMessageTypeText,
                messageDefaultNoticeText = current.messageDefaultNoticeText,
                messageModeratedNoticeText = current.messageModeratedNoticeText,
                messageHiddenNoticeText = current.messageHiddenNoticeText,
                unknownUserText = current.unknownUserText
            }
        end, {
            conversationId,
            width,
            current2,
            current.wideMode,
            current.isDebugEnabled,
            current.viewProfileOnAvatarPressed,
            current.inputBoxRef,
            tbl2.closeKeyboard,
            tbl2.onDetailsOpened,
            tbl2.openGameDetailsPage,
            tbl2.openMomentsDeepLink,
            tbl2.openViewProfile,
            current.invalidMessageTypeText,
            current.messageDefaultNoticeText,
            current.messageModeratedNoticeText,
            current.messageHiddenNoticeText,
            current.unknownUserText
        }),
        listProps = listProps,
        isLoading = isLoading,
        isListVisible = var45,
        showLoadingSkeleton = FFlagAppChatConversationLoadingSkeleton
    }
end

return useMessageListV2ViewModel
