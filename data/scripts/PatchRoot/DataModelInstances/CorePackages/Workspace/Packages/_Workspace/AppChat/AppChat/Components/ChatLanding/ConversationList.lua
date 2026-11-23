-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IXPService = game:GetService("IXPService")

local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatPerfExperimentation = require(AppChatParent.SocialExperiments).AppChatPerfExperimentation
local VisibilityControl = require(AppChatParent.AppNavBar).VisibilityControl
local AppPage = require(AppChatParent.RobloxAppEnums).AppPage
local BidirectionalFlatList = require(AppChatParent.VirtualizedList).BidirectionalFlatList
local CoreGui = require(AppChatParent.ReactFocusNavigation).EngineInterface.CoreGui
local Cryo = require(AppChatParent.Cryo)
local FocusNavigationService = require(AppChatParent.ReactFocusNavigation).FocusNavigationService
local memoize = require(AppChatParent.AppCommonLib).memoize
local React = require(AppChatParent.React)
local Roact = require(AppChatParent.Roact)
local Promise = require(AppChatParent.Promise)
local SharedFlags = require(AppChatParent.SharedFlags)
local Signal = require(AppChatParent.AppCommonLib).Signal
local SocialCarousel = require(AppChatParent.SocialCarousel)
local SocialExperiments = require(AppChatParent.SocialExperiments)
local withStyle = require(AppChatParent.UIBlox).Style.withStyle

local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)
local createScrollIntervalTracker = require(AppChat.Telemetry.createScrollIntervalTracker)

local Constants = SocialCarousel.Constants
local Enums = SocialCarousel.Enums

local SquadQuickStartExperimentation = SocialExperiments.SquadQuickStartExperimentation

local ChatLandingModalContainer = require(script.Parent.ChatLandingModal.ChatLandingModalContainer)
local ConversationEntry = require(script.Parent.ConversationEntry)
local ConversationRow = require(script.Parent.ConversationRow)
local ConversationGroupsEntryContainer = require(script.Parent.ConversationGroupsEntryContainer)
local PartyQuickStartContainer = require(script.Parent.PartyQuickStartContainer)
local num1 = game:DefineFastInt("AppChatChatLandingInitialFetchLimit", 5)
local FFlagAppIaScrollAway = SharedFlags.FFlagAppIaScrollAway
local FFlagEnableScrollAwayContentScrollableFix = SharedFlags.FFlagEnableScrollAwayContentScrollableFix

local num2 = game:DefineFastInt("AppChatChatLandingInitialFetchMinimumConversations", 30)

local FFlagAppChatRemoveConversationListDividerIxpEnabled = require(AppChat.Flags.FFlagAppChatRemoveConversationListDividerIxpEnabled)

local FStringAppChatRemoveConversationListDividerIxpLayer = require(AppChat.Flags.FStringAppChatRemoveConversationListDividerIxpLayer)
local FFlagAppChatTimestampInSubtitleIxpEnabled = require(AppChat.Flags.FFlagAppChatTimestampInSubtitleIxpEnabled)
local FStringAppChatTimestampInSubtitleIxpLayer = require(AppChat.Flags.FStringAppChatTimestampInSubtitleIxpLayer)

local windowSize = game:DefineFastInt("AppChatPerfChatLandingPaginationWindowSize", 2)

local initialNumToRender = game:DefineFastInt("AppChatPerfChatLandingPaginationInitialRender", 8)

local num5 = game:DefineFastInt("AppChatPerfChatLandingPaginationOnStartReachedUnits", 1)

local num6 = game:DefineFastInt("AppChatPerfChatLandingPaginationOnEndReachedUnits", 10)

local PartyPageCarouselExperimentation = require(AppChatParent.SocialExperiments).PartyPageCarouselExperimentation

local var1 = require(script.Parent.Logger):new(script.Name)

local shouldUseFoundationConversationRow = require(AppChat.Flags.SignalsMigrationConfig).shouldUseFoundationConversationRow
local FFlagAppChatConsoleFocusFixes = require(AppChat.Flags.FFlagAppChatConsoleFocusFixes)

local var2 = Roact.PureComponent:extend("ConversationList")

var2.defaultProps = {
    focusIndex = 1,
    focusLock = {},
    itemList = {},
    loadNext = nil,
    loadPrevious = nil,
    onActivated = nil,
    navigateToQuickStartSquadInviteFriends = function() end,
    navigateToSquadLobby = function() end,
    isDebugEnabled = false,
    Size = UDim2.fromScale(1, 1),
    LayoutOrder = 1,
    onScrollUpdate = function() end,
    entryHeight = 64,
    shouldShowPhoneVerificationUpsell = false,
    shouldShowUnfilteredAccessFtux = false,
    shouldShowPartyUpsellFtux = false,
    dismissUnfilteredThreadsFtux = function() end,
    canvasTopPadding = if FFlagAppIaScrollAway then 0 else nil,
    fireConversationImpressionEvent = function() end,
    isPartyQuickStartEnabled = false,
    fireConversationClickedEvent = function() end,
    canAccessParty = false
}

local function getIsSquadEnabledForRows(props): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return props.canAccessParty == true
end

function var2.init(arg1)
    var2.ENTRY_HEIGHT = arg1.props.entryHeight

    if FFlagAppChatPerfTracking then
        arg1.scrollIntervalTracker = nil
    end
    arg1.scrollViewPositionChangedSignal = Signal.new()
    arg1.unifiedLogging = {
        appPage = AppPage.Chat,
        impressionTag = if arg1.props.isInExperience then Constants.ANALYTICS.SRC.PARTY_PAGE_IN_EXP else Constants.ANALYTICS.SRC.PARTY_PAGE_UA,
        scrollViewPositionChangedSignal = arg1.scrollViewPositionChangedSignal,
        sortId = 0,
        sortIndex = 1
    }

    function arg1.onScrollUpdate(arg2)
        if FFlagAppChatPerfTracking and arg1.scrollIntervalTracker then
            arg1.scrollIntervalTracker.onScrollTick()
        end

        local var3 = arg1
        var3.currentAnchor = math.floor(arg2.CanvasPosition.Y / 64)
        arg1.scrollViewPositionChangedSignal:fire()

        arg1.props.onScrollUpdate(arg2)
    end

    if FFlagAppIaScrollAway and FFlagEnableScrollAwayContentScrollableFix then
        arg1.lastContentHeight = 0
        function arg1.onViewportAbsoluteSizeChange(arg2)
            VisibilityControl.setContentScrollable(arg1.lastContentHeight > arg2.AbsoluteSize.Y)
        end
    end

    arg1.focusLock = arg1.props.focusLock

    if PartyPageCarouselExperimentation.getPartyPageCarouselEnabled() then
        function arg1.navigateToConversationFromSocialCarousel(arg2)
            arg1.props.navigateToConversationFromUserId(arg2.id)
        end
    end

    function arg1.identifier(arg2)
        if not arg2 then
            return nil
        end

        return arg2.id .. tostring(arg2.unixTime)
    end

    local var3 = memoize(function()
        return {
            {
                tileGroup = Enums.TileGroup.StartSquad,
                onActivated = arg1.props.navigateToQuickStartSquadInviteFriends
            },
            {
                tileGroup = Enums.TileGroup.FriendsList,
                onActivated = arg1.navigateToConversationFromSocialCarousel
            }
        }
    end)

    function arg1.isPartyQuickStartEnabled()
        return arg1.props.isPartyQuickStartEnabled
    end

    function arg1.renderItem(arg2, _)
        local item = arg2.item

        if item.isChatLandingModal then
            return Roact.createElement(ChatLandingModalContainer, {})
        end

        if item.isGroupLink then
            return Roact.createElement(ConversationGroupsEntryContainer, { entryHeight = arg1.ENTRY_HEIGHT })
        end

        if arg1.isPartyQuickStartEnabled() and item.isQuickStartLink then
            return Roact.createElement(PartyQuickStartContainer, { entryHeight = arg1.ENTRY_HEIGHT })
        end

        if PartyPageCarouselExperimentation.getPartyPageCarouselEnabled() and item.isSocialCarousel then
            return React.createElement(SocialCarousel.Entry, {
                customTileList = var3(),
                roduxKey = "ChatAppReducer",
                hideCarouselHeader = true,
                source = if arg1.props.isInExperience then Constants.ANALYTICS.SRC.PARTY_PAGE_IN_EXP else Constants.ANALYTICS.SRC.PARTY_PAGE_UA,
                unifiedLogging = arg1.unifiedLogging
            })
        end

        if FFlagAppIaScrollAway and item.isCanvasTopPadding then
            return Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, item.height), BackgroundTransparency = 1 })
        end

        if FFlagAppChatConsoleFocusFixes and item.isCanvasBottomPadding then
            return Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, item.height), BackgroundTransparency = 1 })
        end

        if shouldUseFoundationConversationRow then
            local createElement = React.createElement
            local var4 = ConversationRow
            local tbl1 = {
                entryHeight = arg1.ENTRY_HEIGHT,
                conversationId = tostring(item.id),
                isSquadEnabled = not not getIsSquadEnabledForRows(arg1.props),
                isWideMode = arg1.props.isWideMode,
                onActivated = arg1.props.onActivated,
                onSquadJoinButtonActivated = arg1.props.navigateToSquadLobby,
                key = "ConversationEntry" .. tostring(item.id),
                fireImpressionEvent = arg1.props.fireConversationImpressionEvent,
                fireClickEvent = arg1.props.fireConversationClickedEvent,
                localUserId = arg1.props.localUserId,
                debugCellValue = if arg1.props.isDebugEnabled then tostring(item.id) else nil
            }
            return createElement(var4, tbl1)
        end

        local createElement = Roact.createElement
        local var4 = ConversationEntry
        local tbl1 = {
            boldTitle = false,
            entryHeight = arg1.ENTRY_HEIGHT,
            conversation = item,
            onActivated = arg1.props.onActivated,
            onSquadJoinButtonActivated = arg1.props.navigateToSquadLobby,
            key = "ConversationEntry" .. tostring(item.id),
            fireImpressionEvent = arg1.props.fireConversationImpressionEvent,
            fireClickEvent = arg1.props.fireConversationClickedEvent
        }
        local isDebugEnabled = arg1.props.isDebugEnabled

        if isDebugEnabled then
            isDebugEnabled = { debugCell = 0 }
            local createElement2 = Roact.createElement
            local tbl2 = {
                Value = tostring(item.id)
            }
            isDebugEnabled.debugCell = createElement2("StringValue", tbl2)
        end

        return createElement(var4, tbl1, isDebugEnabled)
    end

    arg1.ref = if FFlagAppChatConsoleFocusFixes and arg1.props.listRef then arg1.props.listRef else Roact.createRef()
    arg1.viewRef = Roact.createRef()
    arg1.initialFetchesAttempted = 0
    arg1.focusNavigationService = FocusNavigationService.new(CoreGui)
    function arg1.getScrollRef()
        if arg1.ref.current == nil then
            return nil
        end

        local nativeScrollRef = arg1.ref.current._listRef._scrollRef.getNativeScrollRef()
        return if nativeScrollRef == nil then nil else nativeScrollRef._nativeRef.current
    end

    AppChatPerfExperimentation.logExposure()
    PartyPageCarouselExperimentation.logExposure()
    SquadQuickStartExperimentation.logExposure()

    if FFlagAppChatRemoveConversationListDividerIxpEnabled then
        IXPService:LogFlagLinkedUserLayerExposure(FStringAppChatRemoveConversationListDividerIxpLayer)
    end

    if FFlagAppChatTimestampInSubtitleIxpEnabled and game:GetEngineFeature("EnableLogFlagLinkedUserLayerExposure") then
        IXPService:LogFlagLinkedUserLayerExposure(FStringAppChatTimestampInSubtitleIxpLayer)
    end
end

function var2.didMount(arg1)
    if FFlagAppChatPerfTracking and arg1.getScrollRef then
        local scrollRef = arg1.getScrollRef()
        if scrollRef ~= nil then
            arg1.scrollIntervalTracker = createScrollIntervalTracker(AppChatPerfTracker.Events.ScrollConversationList, scrollRef)
        end
    end
    local scrollRef = arg1.getScrollRef()
    if scrollRef ~= nil then
        scrollRef.Selectable = false
    end
end

function var2.willUnmount(arg1)
    if FFlagAppChatPerfTracking and arg1.scrollIntervalTracker then
        arg1.scrollIntervalTracker.cleanup()
    end
    if FFlagAppIaScrollAway and FFlagEnableScrollAwayContentScrollableFix then
        VisibilityControl.setContentScrollable(true)
    end
    arg1.focusNavigationService:teardown()
end

function var2.willUpdate(arg1, arg2, _)
    if arg2.filterText and arg2.filterText ~= "" and arg2.filterText ~= arg1.props.filterText then
        arg1.focusLock = arg2.filterText
    elseif arg2.itemList[1]
        and arg1.props.itemList[1]
        and arg2.itemList[1].id ~= arg1.props.itemList[1].id
        and arg1.currentAnchor == 1
    then
        arg1.focusLock = {}
    end

    if arg2.itemList and arg1.props.itemList ~= arg2.itemList and arg1.initialFetchesAttempted < num1 and #arg2.itemList < num2 then
        arg1.initialFetchesAttempted += 1
        var1:info(
            "Loading more conversations because the list (count: {} out of {}) is not enough (attempt {} out of {})",
            #arg2.itemList,
            num2,
            arg1.initialFetchesAttempted,
            num1
        )
        arg1.props.loadNext()
    end
    if arg2.entryHeight ~= arg1.props.entryHeight then
        var2.ENTRY_HEIGHT = arg2.entryHeight
    end
end

function var2.render(arg1)
    local itemList = arg1.props.itemList

    local bool1 = arg1.props.filterText == "" or arg1.props.filterText == nil
    local showGroupsLink = arg1.props.showGroupsLink

    if bool1 and showGroupsLink then
        itemList = Cryo.List.join({{ id = "ConversationGroupsEntryContainer", isGroupLink = true }}, itemList)
    end

    if not PartyPageCarouselExperimentation.getPartyPageCarouselEnabled() and arg1.isPartyQuickStartEnabled() then
        itemList = Cryo.List.join({{ id = "PartyQuickStartContainer", isQuickStartLink = true }}, itemList)
    end

    if bool1 then
        local var3 = if arg1.isPartyQuickStartEnabled()
            and PartyPageCarouselExperimentation.getPartyPageCarouselEnabled()
            and (arg1.props.isWideMode or not arg1.props.isInExperience) then Cryo.List.join({{ id = "SocialCarousel", isSocialCarousel = true }}, itemList) else itemList
        itemList = Cryo.List.join({{ id = "UnfilteredThreadsFtux", isChatLandingModal = true }}, var3)
    end

    if FFlagAppIaScrollAway and arg1.props.canvasTopPadding > 0 then
        itemList = Cryo.List.join(
            {{
                id = "CanvasTopPadding",
                isCanvasTopPadding = true,
                height = arg1.props.canvasTopPadding
            }},
            itemList
        )
    end
    if FFlagAppChatConsoleFocusFixes and (arg1.props.canvasBottomPadding or 0) > 0 then
        itemList = Cryo.List.join(
            itemList,
            {{
                id = "CanvasBottomPadding",
                isCanvasBottomPadding = true,
                height = arg1.props.canvasBottomPadding
            }}
        )
    end

    local var3 = FFlagAppIaScrollAway and function(_, index)
        local var3, var4

        if arg1.props.canvasTopPadding > 0 then
            if index == 1 then
                var3 = arg1.props.canvasTopPadding
                var4 = 0
            else
                var3 = arg1.ENTRY_HEIGHT
                var4 = arg1.props.canvasTopPadding + arg1.ENTRY_HEIGHT * (index - 2)
            end
        else
            var3 = arg1.ENTRY_HEIGHT
            var4 = arg1.ENTRY_HEIGHT * (index - 1)
        end
        return { length = var3, offset = var4, index = index }
    end or nil

    local function renderScroller(arg2)
        local backgroundTransparency = if arg1.props.pageBackgroundTransparency ~= nil then arg1.props.pageBackgroundTransparency else arg2.Tokens.Color.None.Transparency
        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl1 = {
            BackgroundTransparency = 1,
            Size = arg1.props.Size,
            [Roact.Ref] = arg1.viewRef,
            [Roact.Change.AbsoluteSize] = if FFlagAppIaScrollAway and FFlagEnableScrollAwayContentScrollableFix then arg1.onViewportAbsoluteSizeChange else nil
        }

        local tbl2 = {
            scroller = Roact.createElement(BidirectionalFlatList, {
                data = itemList,
                renderItem = arg1.renderItem,
                getItemLayout = not FFlagAppIaScrollAway and function(_, index)
                    return {
                        length = arg1.ENTRY_HEIGHT,
                        offset = arg1.ENTRY_HEIGHT * (index - 1),
                        index = index
                    }
                end or var3,
                style = {
                    BackgroundColor3 = arg2.Theme.BackgroundDefault.Color,
                    BackgroundTransparency = backgroundTransparency,
                    ScrollBarThickness = 0,
                    BorderSizePixel = 0
                },
                contentContainerStyle = {
                    BackgroundColor3 = arg2.Theme.BackgroundDefault.Color,
                    BackgroundTransparency = backgroundTransparency,
                    BorderSizePixel = 0
                },
                windowSize = windowSize,
                initialNumToRender = initialNumToRender,
                onScroll = arg1.onScrollUpdate,
                onContentSizeChange = function(_, lastContentHeight)
                    local current = arg1.viewRef.current
                    if not current then
                        return
                    end

                    var1:debug("onContentSizeChange - Window height: {} vs Content height: {}", current.AbsoluteSize.Y, lastContentHeight)

                    if FFlagAppIaScrollAway and FFlagEnableScrollAwayContentScrollableFix then
                        arg1.lastContentHeight = lastContentHeight
                        arg1.onViewportAbsoluteSizeChange(current)
                    end
                    if lastContentHeight <= current.AbsoluteSize.Y then
                        var1:info("Not enough content to fill the view, loading more conversations")
                        arg1.props.loadNext()
                    end
                end,
                onEndReached = function()
                    var1:debug("onEndReached - Loading more conversations")
                    arg1.props.loadNext()
                    return Promise.resolve()
                end,
                onStartReached = function()
                    var1:debug("onStartReached - Loading previous conversations")
                    if arg1.props.loadPrevious then
                        arg1.props.loadPrevious()
                    end
                    return Promise.resolve()
                end,
                AutomaticCanvasSize = Enum.AutomaticSize.XY,
                CanvasSize = UDim2.fromScale(0, 0),
                onEndReachedThreshold = arg1.ENTRY_HEIGHT * num6,
                onStartReachedThreshold = arg1.ENTRY_HEIGHT * num5,
                compareItemData = function(arg3, arg4): boolean
                    return arg3.id == arg4.id
                end,
                [Roact.Ref] = arg1.ref,
                autoscrollToTopThreshold = 33,
                enableAutoscrollToTop = true,
                scrollEnabled = if FFlagAppChatConsoleFocusFixes then arg1.props.scrollEnabled else nil
            })
        }

        return createElement(str1, tbl1, tbl2)
    end

    return withStyle(function(arg2)
        if #itemList ~= 0 then
            return renderScroller(arg2)
        end

        return Roact.createElement("Frame", {
            Size = arg1.props.Size,
            BackgroundColor3 = arg2.Theme.BackgroundDefault.Color,
            BackgroundTransparency = if arg1.props.pageBackgroundTransparency ~= nil then arg1.props.pageBackgroundTransparency else arg2.Tokens.Color.None.Transparency,
            BorderSizePixel = 0,
            LayoutOrder = arg1.props.LayoutOrder
        })
    end)
end

return var2
