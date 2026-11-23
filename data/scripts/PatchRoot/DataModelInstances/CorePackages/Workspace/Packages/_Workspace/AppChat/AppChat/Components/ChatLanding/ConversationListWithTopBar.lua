-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local HttpService = game:GetService("HttpService")

local Cryo = require(AppChatParent.Cryo)
local Roact = require(AppChatParent.Roact)
local React = require(AppChatParent.React)
local RoactPaginator = require(AppChat.SocialLibraries).RoactPaginator
local searchFilterPredicate = require(AppChat.SocialLibraries).Utils.searchFilterPredicate
local memoize = require(AppChatParent.AppCommonLib).memoize

local withAnalytics = require(AppChat.LegacyAnalytics.withAnalytics)
local withTelemetry = require(AppChat.Telemetry.withTelemetry)

local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)

local ChatLanding = script:FindFirstAncestor("ChatLanding")
local ChatLandingTelemetryEvents = require(ChatLanding.ChatLandingTelemetryEvents)
local ChatLandingTelemetryLayer = require(AppChat.Telemetry.Layers.ChatLandingTelemetryLayer)
local Display = require(AppChatParent.Display)
local useSignalState = require(AppChatParent.SignalsReact).useSignalState
local Responsive = require(AppChatParent.Responsive)
local useAnimateScrollViewToSelection = require(AppChatParent.AppBlox).useAnimateScrollViewToSelection

local SharedFlags = require(AppChatParent.SharedFlags)
local FFlagAppIaScrollAway = SharedFlags.FFlagAppIaScrollAway
local FFlagEnableStickyShortcutBarOnAllPlatforms = SharedFlags.FFlagEnableStickyShortcutBarOnAllPlatforms
local GetShortcutBarStatusStore = if FFlagEnableStickyShortcutBarOnAllPlatforms then require(AppChatParent.AppShortcutBar).GetShortcutBarStatusStore else nil
local PartyPageCarouselExperimentation = require(AppChatParent.SocialExperiments).PartyPageCarouselExperimentation

local SignalsMigrationConfig = require(AppChat.Flags.SignalsMigrationConfig)
local FFlagAppChatConsoleFocusFixes = require(AppChat.Flags.FFlagAppChatConsoleFocusFixes)
local FFlagAppChatKeepConversationListScrollOnVR = require(AppChat.Flags.FFlagAppChatKeepConversationListScrollOnVR)
local FFlagAppChatUseViewRecyclerConversationList = require(AppChat.Flags.FFlagAppChatUseViewRecyclerConversationList)

local var1 = Roact.PureComponent:extend("ConversationListWithTopBar")
local shouldUseFoundationConversationRow = SignalsMigrationConfig.shouldUseFoundationConversationRow
local var2 = shouldUseFoundationConversationRow and FFlagAppChatUseViewRecyclerConversationList
local ConversationList = require(script.Parent.ConversationList)
local SearchLoading = require(script.Parent.SearchLoading)
local SearchNoResults = require(script.Parent.SearchNoResults)
local bool1 = false
local var3 = nil

local function getConversationListViewRecycler() -- Luacid: Inlined by compiler; 1 call site recovered
    if bool1 then
        return var3
    end

    bool1 = true
    local success, result = pcall(function()
        return require(script.Parent.ConversationListViewRecycler)
    end)
    if success then
        var3 = result
    end

    return var3
end

var1.defaultProps = {
    filterText = nil,
    isDebugEnabled = false,
    itemList = {},
    navigateToSquadLobby = function() end,
    topBarHeight = 0,
    entryHeight = 64,
    canvasTopPadding = if FFlagAppIaScrollAway then 0 else nil,
    canAccessParty = false,
    isPartyQuickStartEnabled = false,
    isSearchActive = false
}

function var1.getDerivedStateFromProps(arg1)
    local filterText = arg1.filterText
    local itemList = arg1.itemList

    if arg1.isSearchActive then
        return { filteredItemList = itemList }
    end

    return {
        filteredItemList = Cryo.List.filterMap(itemList, function(arg2)
            local title = arg2.title

            return if searchFilterPredicate(filterText, title) then arg2 else nil
        end)
    }
end

function var1.init(arg1)
    function arg1.showErrorToast(toastTitle)
        arg1.props.navigateToToast({ toastProps = { toastContent = { toastTitle = toastTitle } } })
    end

    function arg1.reportAnalytics(arg2)
        if not (arg1.props.conversationsIsFetching or arg1.props.oldestConversationIsFetched) then
            arg2:userFetchedOlderConversations(arg1.props.localUserId)
        end
    end

    arg1.loadNext = memoize(function(arg2)
        return function(arg3)
            if not arg1.props[RoactPaginator.loadNext] then
                return
            end

            arg1.reportAnalytics(arg2)
            if FFlagAppChatPerfTracking then
                AppChatPerfTracker.start(AppChatPerfTracker.Events.PaginationConversationList)
            end
            arg1.props[RoactPaginator.loadNext](arg3)
        end
    end)

    arg1.isFiltered = arg1.props.filterText and arg1.props.filterText:match("%S")

    arg1.indexOfList = memoize(function(arg2, arg3): number
        return table.find(Cryo.List.map(arg2, function(arg4)
            return arg4.id
        end), arg3) or 0
    end)

    function arg1.formatParticipantIds(arg2)
        local input = Cryo.List.filterMap(arg2 or {}, function(arg3)
            if not arg3.id then
                return nil
            end
            return tonumber(arg3.id)
        end)

        local success, result = pcall(function(): string
            return HttpService:JSONEncode(input)
        end)
        return if success then result else "[]"
    end

    function arg1.fireClickEvent(arg2, arg3, osaImpressionId)
        local id = arg2.id
        arg3.emit(ChatLandingTelemetryEvents.ConversationClicked, {
            isFiltered = arg1.isFiltered ~= nil,
            conversationListCount = #arg1.state.filteredItemList,
            selectedConversationId = id,
            selectedIndex = arg1.indexOfList(arg1.state.filteredItemList, id),
            hasUnreadMessages = arg2.hasUnreadMessages,
            selectedConversationModerationType = if arg2 then arg2.moderationType else nil,
            selectedConversationUserPendingStatus = if arg2 then arg2.userPendingStatus else nil,
            participantUserIds = arg1.formatParticipantIds(arg2.participants),
            osaAcknowledgementStatus = arg2.osaAcknowledgementStatus,
            osaImpressionId = osaImpressionId
        })
        arg3.emit(
            ChatLandingTelemetryEvents.ConversationClickedIndexStat,
            {
                statValue = arg1.indexOfList(arg1.state.filteredItemList, id) or 0
            }
        )
    end
    arg1.fireConversationImpressionEvent = memoize(function(arg2)
        return function(arg3)
            local id = arg3.id

            arg2.emit(ChatLandingTelemetryEvents.ConversationCellRendered, {
                isFiltered = arg1.isFiltered ~= nil,
                conversationListCount = #arg1.state.filteredItemList,
                selectedConversationId = id,
                selectedIndex = arg1.indexOfList(arg1.state.filteredItemList, id),
                hasUnreadMessages = arg3.hasUnreadMessages,
                selectedConversationModerationType = arg3.moderationType,
                selectedConversationUserPendingStatus = arg3.userPendingStatus,
                participantUserIds = arg1.formatParticipantIds(arg3.participants),
                osaAcknowledgementStatus = arg3.osaAcknowledgementStatus
            })
            arg2.emit(
                ChatLandingTelemetryEvents.ConversationCellRenderedIndexStat,
                {
                    statValue = arg1.indexOfList(arg1.state.filteredItemList, id) or 0
                }
            )
        end
    end)
    function arg1.onActivated(arg2)
        if FFlagAppChatPerfTracking then
            AppChatPerfTracker.start(AppChatPerfTracker.Events.ChatConversationTTI, { conversationId = tostring(arg2.id) })
        end

        arg1.props.navigateToConversation(arg2.id)
    end
end

function var1.render(arg1)
    return withAnalytics(function(arg2)
        return withTelemetry(ChatLandingTelemetryLayer.Context)(function(arg3)
            local var4 = arg1.props.filterText and arg1.props.filterText:match("%S")
            local isShortcutBarVisible = if FFlagEnableStickyShortcutBarOnAllPlatforms then arg1.props.isShortcutBarVisible else false
            local tbl1 = {
                Size = UDim2.fromScale(1, 1),
                itemList = var4 and arg1.state.filteredItemList or arg1.props.itemList,
                loadNext = arg1.loadNext(arg2),
                isDebugEnabled = arg1.props.isDebugEnabled,
                isWideMode = if PartyPageCarouselExperimentation.getPartyPageCarouselEnabled() or shouldUseFoundationConversationRow then arg1.props.isWideMode else nil,
                filterText = arg1.props.filterText,
                onActivated = arg1.onActivated,
                entryHeight = arg1.props.entryHeight,
                navigateToSquadLobby = arg1.props.navigateToSquadLobby,
                isInExperience = arg1.props.isInExperience,
                localUserId = arg1.props.localUserId,
                navigateToConversationFromUserId = if PartyPageCarouselExperimentation.getPartyPageCarouselEnabled() then arg1.props.navigateToConversationFromUserId else nil,
                navigateToQuickStartSquadInviteFriends = if PartyPageCarouselExperimentation.getPartyPageCarouselEnabled() then arg1.props.navigateToQuickStartSquadInviteFriends else nil,
                shouldShowPhoneVerificationUpsell = arg1.props.shouldShowPhoneVerificationUpsell,
                shouldShowUnfilteredAccessFtux = arg1.props.shouldShowUnfilteredAccessFtux,
                shouldShowPartyUpsellFtux = arg1.props.shouldShowPartyUpsellFtux,
                dismissUnfilteredThreadsFtux = arg1.props.dismissUnfilteredThreadsFtux,
                showGroupsLink = arg1.props.showGroupsLink,
                listRef = if FFlagAppChatConsoleFocusFixes then arg1.props.listRef else nil,
                canvasTopPadding = if FFlagAppIaScrollAway then arg1.props.canvasTopPadding else nil,
                pageBackgroundTransparency = arg1.props.pageBackgroundTransparency,
                canvasBottomPadding = if FFlagAppChatConsoleFocusFixes
                    and not arg1.props.isInExperience
                    and not (FFlagEnableStickyShortcutBarOnAllPlatforms and isShortcutBarVisible) then arg1.props.deviceSafePadding.bottom else nil,
                scrollEnabled = if FFlagAppChatConsoleFocusFixes then arg1.props.scrollEnabled else nil,
                fireConversationImpressionEvent = arg1.fireConversationImpressionEvent(arg3),
                isPartyQuickStartEnabled = arg1.props.isPartyQuickStartEnabled,
                fireConversationClickedEvent = arg1.fireClickEvent
            }

            if shouldUseFoundationConversationRow then
                tbl1.canAccessParty = arg1.props.canAccessParty
            end

            if var2 then
                tbl1.isLoadingNext = arg1.props.conversationsIsFetching
                tbl1.isLoadingPrevious = arg1.props.conversationsIsFetching
                tbl1.oldestConversationIsFetched = arg1.props.oldestConversationIsFetched
            end

            local var5 = ConversationList
            if var2 then
                var5 = getConversationListViewRecycler() or ConversationList
            end
            local element = Roact.createElement(var5, tbl1)

            if arg1.props.isSearchActive and arg1.props.isSearchAwaitingResults and #arg1.props.itemList == 0 then
                element = Roact.createElement(SearchLoading, { entryHeight = arg1.props.entryHeight, topPadding = arg1.props.canvasTopPadding })
            elseif arg1.props.isSearchActive
                and not arg1.props.isSearchAwaitingResults
                and #arg1.props.itemList == 0
                and arg1.props.oldestConversationIsFetched
            then
                element = Roact.createElement(SearchNoResults, { topPadding = arg1.props.canvasTopPadding })
            end

            return Roact.createElement("Frame", {
                Size = if FFlagAppChatConsoleFocusFixes
                    and not arg1.props.isInExperience
                    and not (FFlagEnableStickyShortcutBarOnAllPlatforms and isShortcutBarVisible) then UDim2.new(1, 0, 1, arg1.props.deviceSafePadding.bottom) else UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1
            }, { conversationList = element })
        end)
    end)
end

function var1.didMount(arg1)
    arg1.isMounted = true
end

function var1.didUpdate(arg1, arg2)
    if FFlagAppChatPerfTracking and #arg1.props.itemList > #arg2.itemList then
        AppChatPerfTracker.finish(AppChatPerfTracker.Events.PaginationConversationList)
    end
end

function var1.willUnmount(arg1)
    arg1.isMounted = false
end

return if FFlagAppChatConsoleFocusFixes then function(arg1) -- name: ConversationListWithTopBarFunctional
    local deviceSafePadding = useSignalState(Display.GetDisplayStore().getDeviceSafePadding)
    local var5, var6 = React.useState(nil)
    local listRef = React.useRef(nil)
    local bool2 = Responsive.useLastInput() == Responsive.Input.Directional
    local var8 = if FFlagAppChatKeepConversationListScrollOnVR then Responsive.useIsSpatial() else false

    React.useLayoutEffect(function()
        local _nativeRef = listRef.current
            and listRef.current._listRef._scrollRef.getNativeScrollRef()
            and listRef.current._listRef._scrollRef.getNativeScrollRef()._nativeRef
        var6(_nativeRef)
    end)

    useAnimateScrollViewToSelection(var5, 0.2)
    local var9 = if FFlagEnableStickyShortcutBarOnAllPlatforms then useSignalState(GetShortcutBarStatusStore(false).getShortcutBarVisible) else false
    local var10 = table.clone(arg1)
    var10.deviceSafePadding = deviceSafePadding
    var10.listRef = listRef
    var10.scrollEnabled = not bool2 or var5 == nil or var5.current == nil
    if var8 then
        var10.scrollEnabled = true
    end
    if not FFlagEnableStickyShortcutBarOnAllPlatforms then
        var9 = nil
    end

    var10.isShortcutBarVisible = var9

    return React.createElement(var1, var10)
end else var1
