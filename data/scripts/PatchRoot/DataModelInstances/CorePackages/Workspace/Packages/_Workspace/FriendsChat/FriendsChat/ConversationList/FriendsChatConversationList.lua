-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChat = script:FindFirstAncestor("FriendsChat")
local FriendsChatParent = FriendsChat.Parent

local React = require(FriendsChatParent.React)
local ReactIs = require(FriendsChatParent.ReactIs)
local ReactOtter = require(FriendsChatParent.ReactOtter)
local Foundation = require(FriendsChatParent.Foundation)
local Localization = require(FriendsChatParent.Localization)
local Promise = require(FriendsChatParent.Promise)
local useLocalization = Localization.Hooks.useLocalization

local AppChat = require(FriendsChatParent.AppChat)
local useConversationSearch = require(FriendsChatParent.AppChat.useConversationSearch)
local ChatPlacementContext = require(FriendsChatParent.AppChat.ChatPlacementContext)
local searchIntroducedConversationIds = require(FriendsChatParent.AppChat.searchIntroducedConversationIds)

local FFlagFriendsChatServerSideConversationSearch = require(FriendsChat.Flags.FFlagFriendsChatServerSideConversationSearch)

local FFlagFriendsChatUseViewRecyclerConversationList = require(FriendsChat.Flags.FFlagFriendsChatUseViewRecyclerConversationList)
local FFlagFriendsChatConversationListFocusNav = require(FriendsChatParent.SharedFlags).FFlagFriendsChatConversationListFocusNav
local FFlagExpChatTabShortcutNav = require(FriendsChatParent.SharedFlags).FFlagExpChatTabShortcutNav
local BidirectionalFlatList = require(FriendsChatParent.VirtualizedList).BidirectionalFlatList
local useChatPlatform = require(FriendsChatParent.ExpChatIntegration.useChatPlatform)
local useChatInputBarSettings = require(FriendsChatParent.ExpChatIntegration.useChatInputBarSettings)
local useInterpolatedClientSettings = require(FriendsChatParent.ExpChatIntegration.useInterpolatedClientSettings)
local useChatWindowSettings = require(FriendsChatParent.ExpChatIntegration.useChatWindowSettings)

local ExpChatConversationListAdapter = require(script.Parent.ExpChatConversationListAdapter)
local useFocusConversationList = require(script.Parent.useFocusConversationList)
local getConversationRowHeight = require(script.Parent.getConversationRowHeight)
local resolveListState = require(script.Parent.resolveListState)
local useConversationListPagination = require(script.Parent.useConversationListPagination)
local useChatWindowReport = require(script.Parent.Parent.Utils.useChatWindowReport)
local LayoutConstants = require(FriendsChat.LayoutConstants)
local useChatSearchSession = require(FriendsChatParent.AppChat.useChatSearchSession)
local useChatSearchResultsTelemetry = require(FriendsChatParent.AppChat.useChatSearchResultsTelemetry)
local FFlagAppChatSearchSessionTelemetry = require(FriendsChatParent.AppChat.FFlagAppChatSearchSessionTelemetry)
local FFlagAppChatSearchSendPlacement = require(FriendsChatParent.AppChat.FFlagAppChatSearchSendPlacement)

local useFriendsChatLandingTelemetry = require(script.Parent.Parent.Telemetry.ChatLanding.useFriendsChatLandingTelemetry)
local getLandingEmptyStateType = require(script.Parent.Parent.Telemetry.ChatLanding.getLandingEmptyStateType)

local ButtonVariant = Foundation.Enums.ButtonVariant
local Icon = Foundation.Icon
local IconButton = Foundation.IconButton
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize
local FoundationText = Foundation.Text
local View = Foundation.View
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local useTextSizeOffset = Foundation.Hooks.useTextSizeOffset
local useTokens = Foundation.Hooks.useTokens

local ConversationListViewRecycler = AppChat.Components.ChatLanding.ConversationListViewRecycler
local ConversationRow = AppChat.Components.ChatLanding.ConversationRow
local getConversationTitle = ExpChatConversationListAdapter.getConversationTitle
local useConversationList = AppChat.Hooks.useConversationList

local autoscrollToTopThreshold = game:DefineFastInt("FriendsChatConversationListAutoscrollToTopThreshold", 33)

local initialNumToRender = game:DefineFastInt("FriendsChatConversationListInitialNumToRender", 8)

local num3 = game:DefineFastInt("FriendsChatConversationListPaginationThresholdRows", 10)

local num4 = game:DefineFastInt("FriendsChatConversationListScrollbarIdleHideMs", 1500)

local num5 = game:DefineFastInt("FriendsChatConversationListScrollbarThickness", 8)
local windowSize = game:DefineFastInt("FriendsChatConversationListWindowSize", 2)
local FFlagFriendsChatScaleConversationRowHeight = require(FriendsChat.Flags.FFlagFriendsChatScaleConversationRowHeight)
local FFlagFriendsChatLandingTelemetryFields = require(FriendsChat.Flags.FFlagFriendsChatLandingTelemetryFields)

local bool1 = not FFlagFriendsChatUseViewRecyclerConversationList
local num7 = num4 / 1000
local tbl1 = {
    dampingRatio = 1,
    frequency = 2,
    restingVelocityLimit = 0.1,
    restingPositionLimit = 0.1
}

local tbl2 = {
    NoFriends = "Feature.Chat.Text.NoFriends",
    SearchPlaceholder = "CommonUI.Controls.Action.Search",
    Loading = "Feature.Chat.Label.Loading",
    NoChatFound = "Feature.Chat.Label.NoChatFound",
    SomethingWentWrong = "CommonUI.Messages.Response.SomethingWentWrong"
}

local function getColorStyle(color3, transparency) -- Luacid: Inlined by compiler; 3 call sites recovered
    return { Color3 = color3, Transparency = transparency }
end

local function getTransparencyOrBindingValue(num8: number, arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if ReactIs.isBinding(arg1) then
        return arg1:map(function(num9: number): number
            return num8 + num9 * (1 - num8)
        end)
    end

    return arg1
end

local function getTextTransparency(arg1, transparency: number) -- Luacid: Inlined by compiler; 1 call site recovered
    if ReactIs.isBinding(arg1) then
        return arg1:map(function(num8: number): number
            return transparency + num8 * (1 - transparency)
        end)
    end

    return transparency
end

local function mergeTransparency(transparency: number, tbl3)
    local tbl4 = {}
    local num8 = transparency
    for _, value in tbl3 do
        if ReactIs.isBinding(value) then
            table.insert(tbl4, value)
        else
            local var1 = (value or 0) * (1 - num8)
            num8 += var1
        end
    end

    if #tbl4 == 0 then
        return num8
    end

    return React.joinBindings(tbl4):map(function(arg1)
        local var1 = num8
        for _, value in arg1 do
            var1 += value * (1 - var1)
        end
        return var1
    end)
end

local function normalizeSearchText(str1: string?): string -- Luacid: Inlined by compiler; 1 call site recovered
    return string.lower(str1 or "")
end

local function containsSearchText(str1: string?, str2: string): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return str2 == "" or string.find(string.lower(str1 or ""), str2, 1, true) ~= nil
end

return React.memo(function(tbl3) -- name: FriendsChatConversationList
    local var1 = useTokens()
    local var2 = if FFlagFriendsChatScaleConversationRowHeight then useTextSizeOffset() else nil
    local getTransparencyStore = useChatPlatform().getTransparencyStore
    local var3 = useChatWindowSettings()
    local var4 = React.useMemo(function()
        return {
            BackgroundColor3 = var3.ChatWindowBackgroundColor3,
            BackgroundTransparency = var3.ChatWindowBackgroundTransparency
        }
    end, { var3 })
    local var5 = tbl3.chatWindowSettings or var4
    local var6 = useLocalization(tbl2)
    local var7 = useInterpolatedClientSettings(var5)
    local backgroundTransparency = var7.BackgroundTransparency
    local backgroundColor3 = var7.BackgroundColor3 or var7.BackgroundColor or var5.BackgroundColor3
    local var9 = tbl3.transparencyValue or var3.ChatWindowBackgroundTransparency
    local groupTransparency = if tbl3.transparencyValue == nil then 0 else getTransparencyOrBindingValue(0, var9)

    local var11 = tbl3.textTransparency or React.createBinding(0)

    local var12 = mergeTransparency(var1.Color.Content.Default.Transparency, { var11, groupTransparency })

    local textTransparency = mergeTransparency(var1.Color.Content.Emphasis.Transparency, { var11, groupTransparency })

    local var14 = mergeTransparency(var1.Color.Stroke.Default.Transparency, { groupTransparency })
    local size1200 = var1.Size.Size_1200

    local conversationRowHeight = getConversationRowHeight(var1.Size.Size_1400, var2 or 0, FFlagFriendsChatScaleConversationRowHeight)

    local var15 = useChatInputBarSettings()

    local var16 = (if tbl3.isSpatialUIEnabled and var15 and var15.SpatialPanelTextSize then var15.SpatialPanelTextSize elseif var15 then var15.TextSize else var1.Typography.CaptionMedium.FontSize)
        or var1.Typography.CaptionMedium.FontSize
    local var17 = LayoutConstants.InputBarTopPadding + LayoutConstants.InputBarBottomPadding + LayoutConstants.InputBarTextVerticalPadding + var16

    local var18, var19 = React.useState("")
    local selectionImageObject = if FFlagExpChatTabShortcutNav then Foundation.Hooks.useCursor(Foundation.Enums.CursorType.RoundedRect) else nil
    local ref = React.useRef(nil)

    local var8, var23 = useFocusConversationList(getTransparencyStore)

    local bool2 = tbl3.visible ~= false
    local var24 = useConversationList(bool2)
    local var25 = useConversationListPagination(bool2, var24.listStatus)
    local listStatus = var24.listStatus
    local items = var24.items
    local var26 = React.useMemo(function()
        if FFlagFriendsChatServerSideConversationSearch then
            return items
        end

        local str1 = normalizeSearchText(var18)
        local result = {}

        for _, item in items do
            local var26 = getConversationTitle(item) or item.title or item.titleForViewer
            local previewContent = item.previewContent

            if containsSearchText(var26, str1) or containsSearchText(previewContent, str1) then
                table.insert(result, item)
            end
        end

        return result
    end, { items, var18 })

    local var27

    if FFlagFriendsChatServerSideConversationSearch then
        local var28 = useConversationSearch
        local inExperienceFriendsTab = if FFlagAppChatSearchSendPlacement then ChatPlacementContext.Enum.InExperienceFriendsTab else nil
        var27 = var28(var18, bool2, inExperienceFriendsTab)

        if FFlagAppChatSearchSessionTelemetry then
            useChatSearchResultsTelemetry(var27)
        end
    else
        var27 = nil
    end

    if var27 == nil or not var27.isActive then
        var27 = nil
    end

    local var28 = resolveListState
    local tbl4 = {
        items = 0,
        totalCount = 0,
        isFetching = 0,
        hasError = 0,
        hasFetchedInitialPage = 0,
        isFetchingNextPage = 0,
        oldestConversationIsFetched = 0,
        loadNext = 0
    }

    if FFlagFriendsChatServerSideConversationSearch then
        var26 = items
    end

    tbl4.items = var26
    tbl4.totalCount = #items
    tbl4.isFetching = listStatus.isFetchingConversations == true
    tbl4.hasError = listStatus.error ~= nil
    tbl4.hasFetchedInitialPage = listStatus.hasFetchedInitialPage == true
    tbl4.isFetchingNextPage = listStatus.isFetchingNextPage == true
    tbl4.oldestConversationIsFetched = listStatus.oldestConversationIsFetched == true or listStatus.isExhausted == true
    tbl4.loadNext = var25.loadNext
    local var29 = var28(tbl4, var27)

    local items2 = var29.items
    local shouldOfferRetry = var29.shouldOfferRetry
    local bool3 = var18 ~= ""
    local isFiltered = if FFlagFriendsChatServerSideConversationSearch then var27 ~= nil else bool3
    local emptyStateType = if FFlagFriendsChatLandingTelemetryFields then getLandingEmptyStateType(var29, bool3) else nil

    if FFlagAppChatSearchSessionTelemetry then
        useChatSearchSession(isFiltered and tbl3.visible ~= false, FFlagFriendsChatServerSideConversationSearch)
    end

    local var30 = useFriendsChatLandingTelemetry(
        {
            conversations = items,
            displayedConversations = items2,
            isFiltered = isFiltered,
            emptyStateType = emptyStateType
        }
    )
    local tbl5 = {
        searchPlaceholder = var6.SearchPlaceholder,
        loadingConversations = var6.Loading,
        loadConversationsError = var6.SomethingWentWrong,
        noLoadedConversationsFound = var6.NoChatFound,
        noFriends = var6.NoFriends
    }
    local var31 = if var29.isInitialLoading then tbl5.loadingConversations elseif var29.shouldShowBlockingError then tbl5.loadConversationsError elseif var29.shouldShowEmptyState then if var29.hasNoFriends then tbl5.noFriends else tbl5.noLoadedConversationsFound else nil

    local onActivated = React.useCallback(function(arg1)
        if tbl3.onConversationActivated == nil or arg1 == nil or arg1.id == nil then
            return
        end

        if FFlagFriendsChatServerSideConversationSearch then
            searchIntroducedConversationIds.remove(arg1.id)
        end

        tbl3.onConversationActivated(arg1.id)
    end, { tbl3.onConversationActivated })

    local var33 = useChatWindowReport(tbl3.onAbsoluteSizeChanged)
    local var34 = useChatWindowReport(tbl3.onAbsolutePositionChanged)

    local var35 = React.useCallback(function()
        var30.fireSearchActivatedEvent()
        getTransparencyStore(false).setTextboxFocus()
    end, { getTransparencyStore, var30.fireSearchActivatedEvent })

    local var36 = React.useCallback(function()
        getTransparencyStore(false).clearTextboxFocus()
    end, { getTransparencyStore })

    React.useEffect(function()
        return function()
            getTransparencyStore(false).clearTextboxFocus()
        end
    end, { getTransparencyStore })

    local var37 = nil
    local var38 = nil
    if bool1 then
        local var39 = React.useRef(nil)
        local var40
        var37, var40 = ReactOtter.useAnimatedBinding(1)

        var38 = React.useCallback(function()
            if var39.current ~= nil then
                pcall(task.cancel, var39.current)
                var39.current = nil
            end

            var40(ReactOtter.instant(0))

            var39.current = task.delay(num7, function()
                var39.current = nil
                var40((ReactOtter.spring(1, tbl1)))
            end)
        end, { var40 })

        React.useEffect(function()
            return function()
                if var39.current ~= nil then
                    pcall(task.cancel, var39.current)
                    var39.current = nil
                end
            end
        end, {})
    end

    local useCallback = React.useCallback
    local function func1(_)
        if bool1 then
            var38()
        end

        getTransparencyStore(false).resetAllTransparency()
    end

    local var39 = if bool1 then var38 else nil
    local var40 = useCallback(func1, { getTransparencyStore, var39 })

    local var41 = if FFlagFriendsChatConversationListFocusNav and items2[1] ~= nil then tostring(items2[1].id) else nil

    local renderItem = React.useCallback(function(arg1)
        local conversationId = tostring(arg1.item.id)
        return React.createElement(ConversationRow, {
            conversationId = conversationId,
            entryHeight = conversationRowHeight,
            isWideMode = false,
            onActivated = onActivated,
            fireClickEvent = var30.fireConversationClickedEvent,
            fireImpressionEvent = var30.fireConversationImpressionEvent,
            showBackground = false,
            localUserId = tbl3.localUserId,
            ref = if FFlagFriendsChatConversationListFocusNav and conversationId == var41 then var23 else nil
        })
    end, {
        conversationRowHeight,
        var30.fireConversationClickedEvent,
        var30.fireConversationImpressionEvent,
        onActivated,
        tbl3.localUserId,
        var41,
        var23
    })

    local getItemLayout = React.useCallback(function(_, index: number)
        return {
            length = conversationRowHeight,
            offset = conversationRowHeight * (index - 1),
            index = index
        }
    end, { conversationRowHeight })

    local loadNext = React.useCallback(function()
        var29.loadNext()
    end, { var29.loadNext })

    local onContentSizeChange = React.useCallback(function(_: number, num8: number)
        local current = ref.current
        if current ~= nil and num8 <= current.AbsoluteSize.Y then
            loadNext()
        end
    end, { loadNext })

    local onEndReached = React.useCallback(function()
        loadNext()
        return Promise.resolve()
    end, { loadNext })

    local var47 = React.useCallback(function(arg1)
        var19(arg1.Text)
    end, {})

    local var10 = React.useCallback(function()
        var19("")
    end, {})

    local isLoadingNextPage = var29.isLoadingNextPage
    local oldestConversationIsFetched = var29.oldestConversationIsFetched
    local listKey = if FFlagFriendsChatServerSideConversationSearch then var29.listKey else nil
    local element

    if FFlagFriendsChatUseViewRecyclerConversationList then
        element = React.createElement(ConversationListViewRecycler, {
            key = listKey,
            Size = UDim2.fromScale(1, 1),
            entryHeight = conversationRowHeight,
            itemList = items2,
            loadNext = loadNext,
            isLoadingNext = isLoadingNextPage,
            oldestConversationIsFetched = oldestConversationIsFetched,
            isWideMode = false,
            showScrollbarOnScroll = true,
            scrollbarThickness = num5,
            onScrollUpdate = var40,
            rowProps = {
                showBackground = false,
                localUserId = tbl3.localUserId
            },
            localUserId = tbl3.localUserId,
            showHeaderEntries = false,
            shouldLogHeaderEntryExposures = false,
            shouldLogPerfExposure = false,
            onActivated = onActivated,
            fireConversationClickedEvent = var30.fireConversationClickedEvent,
            fireConversationImpressionEvent = var30.fireConversationImpressionEvent
        })
    else
        local createElement = React.createElement
        local var49 = BidirectionalFlatList

        local tbl6 = {
            key = listKey,
            data = items2,
            renderItem = renderItem,
            getItemLayout = getItemLayout,
            keyExtractor = function(arg1): string
                return tostring(arg1.id)
            end,
            compareItemData = function(arg1, arg2): boolean
                return arg1.id == arg2.id
            end,
            style = 0,
            contentContainerStyle = 0,
            windowSize = 0,
            initialNumToRender = 0,
            onScroll = 0,
            onContentSizeChange = 0,
            onEndReached = 0,
            onEndReachedThreshold = 0,
            AutomaticCanvasSize = 0,
            CanvasSize = 0,
            autoscrollToTopThreshold = 0,
            enableAutoscrollToTop = true
        }
        local style = {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarImageTransparency = 0,
            ScrollBarThickness = 0,
            Selectable = false
        }

        if not bool1 then
            var37 = nil
        end

        style.ScrollBarImageTransparency = var37
        style.ScrollBarThickness = num5
        tbl6.style = style

        tbl6.contentContainerStyle = { BackgroundTransparency = 1, BorderSizePixel = 0 }

        tbl6.windowSize = windowSize
        tbl6.initialNumToRender = initialNumToRender
        tbl6.onScroll = var40
        tbl6.onContentSizeChange = onContentSizeChange
        tbl6.onEndReached = onEndReached
        tbl6.onEndReachedThreshold = conversationRowHeight * num3
        tbl6.AutomaticCanvasSize = Enum.AutomaticSize.XY
        tbl6.CanvasSize = UDim2.fromScale(0, 0)
        tbl6.autoscrollToTopThreshold = autoscrollToTopThreshold
        element = createElement(var49, tbl6)
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl6 = {
        Name = "chatWindow",
        Active = true,
        BackgroundColor3 = backgroundColor3,
        BackgroundTransparency = getTransparencyOrBindingValue(backgroundTransparency, var9),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        LayoutOrder = tbl3.LayoutOrder or 1,
        Size = tbl3.size or UDim2.new(1, 0, 1, LayoutConstants.PanelTopSpacerHeight + var17 + LayoutConstants.PanelBottomCornerRadius),
        Visible = bool2,
        ref = var8,
        [React.Change.AbsoluteSize] = var33,
        [React.Change.AbsolutePosition] = var34,
        [React.Event.MouseEnter] = tbl3.onHovered,
        [React.Event.MouseLeave] = tbl3.onUnhovered
    }
    local tbl7 = {
        bottomCorner = React.createElement("UICorner", {
            BottomLeftRadius = UDim.new(0, LayoutConstants.PanelBottomCornerRadius),
            BottomRightRadius = UDim.new(0, LayoutConstants.PanelBottomCornerRadius),
            TopLeftRadius = UDim.new(0, 0),
            TopRightRadius = UDim.new(0, 0)
        }),
        layout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                Padding = UDim.new(0, 0),
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        ),
        SearchContainer = 0,
        ListArea = 0
    }
    local createElement2 = React.createElement
    local var49 = View
    local tbl8 = {
        Name = "SearchContainer",
        tag = "padding-small",
        BorderSizePixel = 0,
        LayoutOrder = 1,
        Size = UDim2.new(1, 0, 0, size1200)
    }
    local tbl9 = { SearchContent = 0 }
    local createElement3 = React.createElement
    local str2 = "Frame"
    local tbl10 = {
        Name = "SearchContent",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(-1, -1),
        Size = UDim2.new(1, 2, 1, 2)
    }
    local tbl11 = { SearchField = 0 }
    local createElement4 = React.createElement
    local var50 = View
    local tbl12 = {
        Name = "SearchField",
        tag = "row align-y-center items-center gap-small padding-x-medium radius-circle clip",
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(1, 1),
        Size = UDim2.new(1, -2, 0, var1.Size.Size_800),
        stroke = {
            Color = var1.Color.Stroke.Default.Color3,
            Transparency = var14,
            Thickness = var1.Stroke.Standard
        }
    }
    local tbl13 = {
        SearchIcon = React.createElement(Icon, {
            LayoutOrder = 1,
            name = IconName.MagnifyingGlass,
            size = IconSize.Small,
            style = getColorStyle(var1.Color.Content.Default.Color3, var12)
        }),
        SearchBox = React.createElement(
            "TextBox",
            {
                Name = "FriendsChatConversationListSearchBox",
                BackgroundTransparency = 1,
                SelectionImageObject = selectionImageObject,
                ClearTextOnFocus = false,
                ClipsDescendants = true,
                FontFace = normalizeFontFace(var1.Typography.BodySmall.Font),
                LineHeight = var1.Typography.BodySmall.LineHeight,
                LayoutOrder = 2,
                PlaceholderColor3 = var1.Color.Content.Muted.Color3,
                PlaceholderText = tbl5.searchPlaceholder,
                Size = UDim2.new(0, 0, 1, 0),
                Text = var18,
                TextColor3 = var1.Color.Content.Emphasis.Color3,
                TextSize = var1.Typography.BodySmall.FontSize,
                TextTransparency = textTransparency,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center,
                [React.Event.Focused] = var35,
                [React.Event.FocusLost] = var36,
                [React.Change.Text] = var47
            },
            {
                Flex = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill })
            }
        ),
        ClearButton = if bool3 then React.createElement(
            View,
            {
                Name = "FriendsChatConversationListSearchClear",
                LayoutOrder = 3,
                tag = "auto-xy",
                onActivated = var10
            },
            {
                Icon = React.createElement(
                    Icon,
                    {
                        name = IconName.CircleX,
                        size = IconSize.Small,
                        style = getColorStyle(var1.Color.Content.Default.Color3, var12)
                    }
                )
            }
        ) else nil
    }
    tbl11.SearchField = createElement4(var50, tbl12, tbl13)
    tbl9.SearchContent = createElement3(str2, tbl10, tbl11)
    tbl7.SearchContainer = createElement2(var49, tbl8, tbl9)

    local createElement5 = React.createElement
    local var51 = View
    local tbl14 = {
        Name = "ListArea",
        BorderSizePixel = 0,
        LayoutOrder = 2,
        Size = UDim2.new(1, 0, 1, -size1200)
    }
    local tbl15 = { ListContent = 0 }
    local createElement6 = React.createElement
    local str3 = "CanvasGroup"
    local tbl16 = {
        Name = "ListContent",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        GroupTransparency = groupTransparency,
        Size = UDim2.fromScale(1, 1)
    }
    local tbl17 = {
        ListWrapper = React.createElement("Frame", {
            Name = "FriendsChatConversationListWrapper",
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            LayoutOrder = 1,
            Size = UDim2.fromScale(1, 1),
            ref = ref
        }, { List = element }),
        Status = 0
    }
    local element2

    if var31 == nil then
        element2 = nil
    else
        element2 = React.createElement(
            View,
            {
                tag = "col align-x-center align-y-center gap-small size-full padding-large",
                BorderSizePixel = 0,
                LayoutOrder = 2
            },
            {
                Message = React.createElement(FoundationText, {
                    tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-center content-default",
                    Text = var31,
                    textStyle = getColorStyle(var1.Color.Content.Default.Color3, (getTextTransparency(var11, var1.Color.Content.Default.Transparency)))
                }),
                Retry = if shouldOfferRetry then React.createElement(IconButton, {
                    icon = IconName.ArrowSpinClockwise,
                    onActivated = var25.retryInitialFetch,
                    size = InputSize.Small,
                    variant = ButtonVariant.Standard
                })
                    or nil else nil
            }
        )
            or nil
    end

    tbl17.Status = element2
    tbl15.ListContent = createElement6(str3, tbl16, tbl17)
    tbl7.ListArea = createElement5(var51, tbl14, tbl15)
    return (createElement(str1, tbl6, tbl7))
end)
