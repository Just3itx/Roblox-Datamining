-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IXPService = game:GetService("IXPService")

local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatPerfExperimentation = require(AppChatParent.SocialExperiments).AppChatPerfExperimentation
local AppPage = require(AppChatParent.RobloxAppEnums).AppPage
local CoreGui = require(AppChatParent.ReactFocusNavigation).EngineInterface.CoreGui
local FocusNavigationService = require(AppChatParent.ReactFocusNavigation).FocusNavigationService
local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local ReactOtter = require(AppChatParent.ReactOtter)
local SharedFlags = require(AppChatParent.SharedFlags)
local Signal = require(AppChatParent.AppCommonLib).Signal
local Signals = require(AppChatParent.Signals)
local SocialCarousel = require(AppChatParent.SocialCarousel)
local SocialExperiments = require(AppChatParent.SocialExperiments)
local Foundation = require(AppChatParent.Foundation)
local ViewRecycler = require(AppChatParent.ViewRecycler)
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local FFlagAppChatConversationListViewRecyclerConsoleProps = require(AppChat.Flags.FFlagAppChatConversationListViewRecyclerConsoleProps)
local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)

local FFlagFriendsChatUseViewRecyclerConversationList = require(AppChat.Flags.FFlagFriendsChatUseViewRecyclerConversationList)
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)
local createScrollIntervalTracker = require(AppChat.Telemetry.createScrollIntervalTracker)

local Constants = SocialCarousel.Constants
local Enums = SocialCarousel.Enums

local SquadQuickStartExperimentation = SocialExperiments.SquadQuickStartExperimentation

local ConversationListViewRecyclerItems = require(script.Parent.ConversationListViewRecyclerItems)
local num1 = game:DefineFastInt("AppChatChatLandingInitialFetchLimit", 5)
local FFlagAppIaScrollAway = SharedFlags.FFlagAppIaScrollAway

local num2 = game:DefineFastInt("AppChatChatLandingInitialFetchMinimumConversations", 30)

local FFlagAppChatRemoveConversationListDividerIxpEnabled = require(AppChat.Flags.FFlagAppChatRemoveConversationListDividerIxpEnabled)

local FStringAppChatRemoveConversationListDividerIxpLayer = require(AppChat.Flags.FStringAppChatRemoveConversationListDividerIxpLayer)

local num3 = game:DefineFastInt("AppChatPerfChatLandingPaginationOnStartReachedUnits", 1)

local num4 = game:DefineFastInt("AppChatPerfChatLandingPaginationOnEndReachedUnits", 10)

local PartyPageCarouselExperimentation = require(AppChatParent.SocialExperiments).PartyPageCarouselExperimentation

local var1 = require(script.Parent.Logger):new(script.Name)

local num5 = game:DefineFastInt("AppChatConversationListScrollBarIdleHideMs", 1500) / 1000
local tbl1 = {
    dampingRatio = 1,
    frequency = 2,
    restingVelocityLimit = 0.1,
    restingPositionLimit = 0.1
}

local function noop() end

local tbl2 = {
    entryHeight = 64,
    itemList = {},
    Size = UDim2.fromScale(1, 1),
    LayoutOrder = 1,
    onScrollUpdate = noop,
    navigateToConversationFromUserId = noop,
    navigateToQuickStartSquadInviteFriends = noop,
    navigateToSquadLobby = noop,
    fireConversationImpressionEvent = noop,
    fireConversationClickedEvent = noop,
    showHeaderEntries = true,
    rowProps = {}
}

local function getAutoLoadNextRequestKey(itemList: boolean): string -- Luacid: Inlined by compiler; 1 call site recovered
    local id = if itemList[1] == nil then nil else itemList[1].id
    local id2 = if itemList[#itemList] == nil then nil else itemList[#itemList].id
    return `{#itemList}:{tostring(id)}:{tostring(id2)}`
end

local function buildConversationItems(itemList, get)
    local var2 = table.create(#itemList)
    for value, value2 in itemList do
        var2[value] = ConversationListViewRecyclerItems.conversation(value2.id, get)
    end
    return var2
end

local function concatItems<T>(tbl3: {T}, tbl4: {T}): {T}
    local var2 = table.create(#tbl3 + #tbl4)
    table.move(tbl3, 1, #tbl3, 1, var2)
    table.move(tbl4, 1, #tbl4, #tbl3 + 1, var2)
    return var2
end

local function usePresentationSignal(arg1)
    local var2 = React.useState(function()
        local get, set = Signals.createSignal(arg1)
        return { get = get, set = set }
    end)

    React.useLayoutEffect(function()
        var2.set(arg1)
    end, { var2, arg1 })

    return var2.get
end

local function usePagination(arg1, itemList: boolean)
    local var2 = React.useRef(0)
    local var3 = React.useRef(nil)
    local var4 = React.useRef(false)
    local current = React.useMemo(function(): string
        return getAutoLoadNextRequestKey(itemList)
    end, { itemList })

    local bool1 = not (arg1.loadNext == nil) and not (arg1.isLoadingNext or arg1.oldestConversationIsFetched)

    React.useEffect(function()
        if var4.current and not arg1.isLoadingNext then
            var3.current = nil
        end
        var4.current = arg1.isLoadingNext == true
    end, { arg1.isLoadingNext })

    local var6 = React.useCallback(function(): boolean
        if not bool1 or var3.current == current then
            return false
        end

        var3.current = current
        arg1.loadNext()
        return true
    end, { bool1, current, arg1.loadNext })

    React.useEffect(function()
        if not bool1 or not (var2.current < num1) or not (#itemList < num2) then
            return
        end
        local var5 = var2.current + 1
        if var6() then
            var2.current = var5
            var1:info(
                "Loading more conversations because the list (count: {} out of {}) is not enough (attempt {} out of {})",
                #itemList,
                num2,
                var2.current,
                num1
            )
        end
    end, { itemList, bool1, var6 })

    local var7 = React.useCallback(function()
        if var6() then
            var1:debug("ViewRecycler onEndReached - Loading more conversations")
        end
    end, { var6 })

    return bool1, var6, React.useCallback(function()
        if arg1.loadPrevious ~= nil and not arg1.isLoadingPrevious then
            var1:debug("ViewRecycler onStartReached - Loading previous conversations")
            arg1.loadPrevious()
        end
    end, { arg1.loadPrevious, arg1.isLoadingPrevious }), var7
end

local function useUnderfillPagination(arg1)
    local var2 = React.useRef(0)
    local var3 = React.useRef(0)
    local var4 = React.useCallback(function()
        if var3.current > 0 and var2.current > 0 and var3.current <= var2.current and arg1() then
            var1:info("Loading more conversations because ViewRecycler content does not fill the viewport")
        end
    end, { arg1 })

    return React.useCallback(function(arg2)
        var2.current = arg2.Y
        var4()
    end, { var4 }), (React.useCallback(function(current)
        var3.current = current
        var4()
    end, { var4 }))
end

local function useScrollTracking<T>(callback: T, callback2: T)
    local var2 = React.useMemo(function()
        return Signal.new()
    end, {})
    local var3 = React.useRef(nil)
    local var4, var5 = React.useState(nil)

    local var6 = React.useCallback(function(y: number?)
        if FFlagAppChatPerfTracking and var3.current then
            var3.current.onScrollTick()
        end
        if callback2 ~= nil then
            callback2()
        end

        var2:fire()
        callback({ CanvasPosition = Vector2.new(0, y) })
    end, { var2, callback, callback2 })

    local var7 = React.useCallback(function(arg1)
        var5(arg1)
    end, {})

    React.useEffect(function()
        local var8 = var4
        if var8 == nil then
            return nil
        end

        var8.Selectable = false
        if FFlagAppChatPerfTracking then
            var3.current = createScrollIntervalTracker(AppChatPerfTracker.Events.ScrollConversationList, var8)
        end

        return function()
            if var3.current then
                var3.current.cleanup()
                var3.current = nil
            end
        end
    end, { var4 })

    return var2, var7, var6
end

local function useMeasuredLayout(estimatedItemLength)
    local var2 = React.useState(function()
        return ViewRecycler.Layout.measured({ estimatedItemLength = estimatedItemLength })
    end)

    React.useEffect(function()
        return function()
            var2.destroy()
        end
    end, { var2 })

    return var2
end

local function useConversationListScrollbar(bool1: boolean, scrollbarThickness, scrollBarImageColor3)
    local var2 = React.useRef(nil)
    local var3, var4 = ReactOtter.useAnimatedBinding(1)

    local var5 = React.useCallback(function()
        if not bool1 then
            return
        end
        if var2.current ~= nil then
            pcall(task.cancel, var2.current)
            var2.current = nil
        end

        var4(ReactOtter.instant(0))
        var2.current = task.delay(num5, function()
            var2.current = nil
            var4(ReactOtter.spring(1, tbl1))
        end)
    end, { bool1, var4 })

    React.useEffect(function()
        return function()
            if var2.current ~= nil then
                pcall(task.cancel, var2.current)
                var2.current = nil
            end
        end
    end, {})

    local tbl3 = {
        ScrollBarThickness = bool1 and (scrollbarThickness or 8) or 0,
        ScrollBarImageColor3 = 0,
        ScrollBarImageTransparency = 0
    }

    if not bool1 then
        scrollBarImageColor3 = nil
    end

    tbl3.ScrollBarImageColor3 = scrollBarImageColor3
    if not bool1 then
        var3 = nil
    end

    tbl3.ScrollBarImageTransparency = var3

    return tbl3, var5
end

local function useListData<T>(arg1: T, arg2: T)
    local items = React.useMemo(function()
        return (concatItems(arg1, arg2))
    end, { arg1, arg2 })

    return React.useMemo(function()
        return {
            items = items,
            getItemKey = ConversationListViewRecyclerItems.getItemKey
        }
    end, { items }), items
end

local function useCanvasBottomPadding<T>(arg1: T, canvasBottomPadding: T, none: T) -- Luacid: Inlined by compiler; 1 call site recovered
    return React.useMemo(function()
        if canvasBottomPadding == nil or canvasBottomPadding <= 0 then
            return arg1
        end
        return (concatItems(arg1, { ConversationListViewRecyclerItems.canvasBottomPadding(canvasBottomPadding, none) }))
    end, { arg1, canvasBottomPadding, none })
end

local function useLegacyListRef(listRef, bool1: boolean, callback)
    local _nativeRef = React.useMemo(function(): {current: nil}?
        return if bool1 then { current = nil } else nil
    end, { bool1 })

    React.useLayoutEffect(function()
        if listRef == nil then
            return nil
        end
        local getNativeScrollRef = _nativeRef ~= nil and { _nativeRef = _nativeRef } or nil
        listRef.current = {
            _listRef = {
                _scrollRef = {
                    getNativeScrollRef = function()
                        return getNativeScrollRef
                    end
                }
            }
        }
        return function()
            listRef.current = nil
        end
    end, { listRef, _nativeRef })

    return React.useCallback(function(current)
        if _nativeRef ~= nil then
            _nativeRef.current = current
        end
        callback(current)
    end, { _nativeRef, callback })
end

return React.memo(function(arg1) -- name: ConversationListViewRecycler
    local var2 = Cryo.Dictionary.join(tbl2, arg1)
    local entryHeight = var2.entryHeight
    local itemList = var2.itemList
    local size = var2.Size
    local layoutOrder = var2.LayoutOrder
    local onScrollUpdate = var2.onScrollUpdate
    local navigateToConversationFromUserId = var2.navigateToConversationFromUserId
    local navigateToQuickStartSquadInviteFriends = var2.navigateToQuickStartSquadInviteFriends
    local navigateToSquadLobby = var2.navigateToSquadLobby
    local fireConversationImpressionEvent = var2.fireConversationImpressionEvent
    local fireConversationClickedEvent = var2.fireConversationClickedEvent
    local showHeaderEntries = var2.showHeaderEntries
    local rowProps = var2.rowProps
    local var3 = useTokens()
    local bool1, var4, var5, var6 = usePagination(var2, itemList)
    local onViewportChanged, onContentLengthChanged = useUnderfillPagination(var4)
    local tbl3, var9 = useConversationListScrollbar(
        var2.showScrollbarOnScroll == true,
        var2.scrollbarThickness,
        var3.Color.Content.Emphasis.Color3
    )

    local scrollViewPositionChangedSignal, var11, onScrollOffsetChanged = useScrollTracking(onScrollUpdate, var9)

    React.useEffect(function()
        if not FFlagFriendsChatUseViewRecyclerConversationList or var2.shouldLogPerfExposure ~= false then
            AppChatPerfExperimentation.logExposure()
        end
        if var2.shouldLogHeaderEntryExposures == false then
            return
        end

        PartyPageCarouselExperimentation.logExposure()
        if SquadQuickStartExperimentation.isLogExposureEnabled then
            SquadQuickStartExperimentation.logExposure()
        end

        if FFlagAppChatRemoveConversationListDividerIxpEnabled then
            IXPService:LogFlagLinkedUserLayerExposure(FStringAppChatRemoveConversationListDividerIxpLayer)
        end
    end, {})

    React.useEffect(function()
        local focusNavigationService = FocusNavigationService.new(CoreGui)
        return function()
            focusNavigationService:teardown()
        end
    end, {})

    local isSquadEnabled = var2.canAccessParty == true
    local isPartyQuickStartEnabled = var2.isPartyQuickStartEnabled
    local var13 = React.useMemo(function()
        return {
            appPage = AppPage.Chat,
            impressionTag = if var2.isInExperience then Constants.ANALYTICS.SRC.PARTY_PAGE_IN_EXP else Constants.ANALYTICS.SRC.PARTY_PAGE_UA,
            scrollViewPositionChangedSignal = scrollViewPositionChangedSignal,
            sortId = 0,
            sortIndex = 1
        }
    end, { var2.isInExperience, scrollViewPositionChangedSignal })

    local onActivated = React.useCallback(function(arg2)
        navigateToConversationFromUserId(arg2.id)
    end, { navigateToConversationFromUserId })

    local var15 = React.useMemo(function()
        return {
            {
                tileGroup = Enums.TileGroup.StartSquad,
                onActivated = navigateToQuickStartSquadInviteFriends
            },
            {
                tileGroup = Enums.TileGroup.FriendsList,
                onActivated = onActivated
            }
        }
    end, { navigateToQuickStartSquadInviteFriends, onActivated })

    local var16 = React.useMemo(function()
        return {
            entryHeight = entryHeight,
            isSquadEnabled = isSquadEnabled,
            isWideMode = var2.isWideMode,
            onActivated = var2.onActivated,
            onSquadJoinButtonActivated = navigateToSquadLobby,
            fireImpressionEvent = fireConversationImpressionEvent,
            fireClickEvent = fireConversationClickedEvent,
            showBackground = rowProps.showBackground,
            localUserId = var2.localUserId,
            isDebugEnabled = var2.isDebugEnabled == true
        }
    end, {
        entryHeight,
        isSquadEnabled,
        var2.isWideMode,
        var2.onActivated,
        navigateToSquadLobby,
        fireConversationImpressionEvent,
        fireConversationClickedEvent,
        rowProps.showBackground,
        var2.localUserId,
        var2.isDebugEnabled
    })

    local get = usePresentationSignal(var16)

    local bool3 = var2.filterText == "" or var2.filterText == nil
    local var17 = showHeaderEntries and bool3
    local partyPageCarouselEnabled = PartyPageCarouselExperimentation.getPartyPageCarouselEnabled()
    local var18 = React.useMemo(function()
        local result = {}
        if FFlagAppIaScrollAway and var2.canvasTopPadding ~= nil and var2.canvasTopPadding > 0 then
            table.insert(result, ConversationListViewRecyclerItems.canvasTopPadding(var2.canvasTopPadding, var3.Color.None))
        end
        if var17 then
            table.insert(result, ConversationListViewRecyclerItems.chatLandingModal())
            if isPartyQuickStartEnabled and partyPageCarouselEnabled and (var2.isWideMode or not var2.isInExperience) then
                table.insert(result, ConversationListViewRecyclerItems.socialCarousel(var15, var2.isInExperience, var13))
            elseif isPartyQuickStartEnabled and not partyPageCarouselEnabled then
                table.insert(result, ConversationListViewRecyclerItems.quickStart(entryHeight))
            end
            if var2.showGroupsLink == true then
                table.insert(result, ConversationListViewRecyclerItems.groupLink(entryHeight))
            end
        end
        return result
    end, {
        var17,
        isPartyQuickStartEnabled,
        partyPageCarouselEnabled,
        var2.isWideMode,
        var2.isInExperience,
        var2.showGroupsLink,
        var2.canvasTopPadding,
        var3.Color.None,
        var15,
        var13,
        entryHeight
    })

    local var19 = React.useMemo(function()
        return (buildConversationItems(itemList, get))
    end, { itemList, get })

    if FFlagAppChatConversationListViewRecyclerConsoleProps then
        var19 = useCanvasBottomPadding(var19, var2.canvasBottomPadding, var3.Color.None)
    end
    local var20, var21 = useListData(var18, var19)

    if FFlagAppChatConversationListViewRecyclerConsoleProps then
        var11 = useLegacyListRef(var2.listRef, #var21 > 0, var11)
    end
    local layout = useMeasuredLayout(entryHeight)

    if #var21 == 0 then
        return React.createElement(
            View,
            {
                Size = size,
                backgroundStyle = var3.Color.None,
                BorderSizePixel = 0,
                LayoutOrder = layoutOrder
            }
        )
    end
    local createElement = React.createElement
    local var23 = View
    local tbl4 = {
        Size = size,
        backgroundStyle = var3.Color.None,
        BorderSizePixel = 0,
        LayoutOrder = layoutOrder
    }
    local tbl5 = { List = 0 }
    local createElement2 = React.createElement
    local virtualList = ViewRecycler.VirtualList
    local tbl6 = {
        data = var20,
        layout = layout,
        overscan = 2,
        axis = ViewRecycler.Axis.Y,
        itemType = ConversationListViewRecyclerItems.getItemType,
        scrollingFrameRef = var11,
        onViewportChanged = onViewportChanged,
        onContentLengthChanged = onContentLengthChanged,
        onScrollOffsetChanged = onScrollOffsetChanged,
        onStartReached = 0,
        onEndReached = 0,
        startReachedThreshold = 0,
        endReachedThreshold = 0,
        autoScrollOnChange = 0,
        autoScrollThreshold = 33,
        scrollingFrameProps = 0
    }

    if var2.loadPrevious == nil or var2.isLoadingPrevious then
        var5 = nil
    end

    tbl6.onStartReached = var5
    if not bool1 then
        var6 = nil
    end

    tbl6.onEndReached = var6
    tbl6.startReachedThreshold = entryHeight * num3
    tbl6.endReachedThreshold = entryHeight * num4
    tbl6.autoScrollOnChange = ViewRecycler.AutoScrollPolicy.WhenAtStart

    tbl6.scrollingFrameProps = {
        Name = "RCTScrollView",
        BackgroundTransparency = 1,
        ScrollBarThickness = tbl3.ScrollBarThickness,
        ScrollBarImageColor3 = tbl3.ScrollBarImageColor3,
        ScrollBarImageTransparency = tbl3.ScrollBarImageTransparency,
        BorderSizePixel = 0,
        ScrollingEnabled = if FFlagAppChatConversationListViewRecyclerConsoleProps then var2.scrollEnabled ~= false else nil
    }
    tbl5.List = createElement2(virtualList, tbl6)
    return createElement(var23, tbl4, tbl5)
end)
