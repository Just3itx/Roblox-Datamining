-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PYMKCarousel = script:FindFirstAncestor("PYMKCarousel")

local dependencies = require(PYMKCarousel.dependencies)
local useSelector = dependencies.Hooks.useSelector
local NetworkingPresence = dependencies.NetworkingPresence
local RecommendationContextType = dependencies.RoduxFriends.Enums.RecommendationContextType

local PYMKCarouselParent = PYMKCarousel.Parent

local React = require(PYMKCarouselParent.React)
local SocialStopwatch = require(PYMKCarouselParent.SocialStopwatch)
local tutils = require(PYMKCarouselParent.tutils)
local useCollectionImpressionsSignal = require(PYMKCarouselParent.CollectionViews).useCollectionImpressionsSignal
local ReactFocusNavigation = require(PYMKCarouselParent.ReactFocusNavigation)
local FocusNavigationEventNameEnum = require(PYMKCarouselParent.FocusNavigationUtils).FocusNavigationEventNameEnum
local InputHandlers = require(PYMKCarouselParent.InputHandlers)
local useThrottledCallback = require(PYMKCarouselParent.RoactUtils).Hooks.useThrottledCallback
local Dash = require(PYMKCarouselParent.Dash)

local Impressions = require(PYMKCarouselParent.Impressions)
local ScreenSizeImpressionsTracker = Impressions.ScreenSizeImpressionsTracker
local FrameBoundsImpressionsTracker = Impressions.FrameBoundsImpressionsTracker

local useDispatch = require(PYMKCarouselParent.RoactUtils).Hooks.RoactRodux.useDispatch

local Analytics = require(PYMKCarousel.Analytics)
local BtnValues = Analytics.BtnValues
local EventNames = Analytics.EventNames
local useUserSeenEvent = Analytics.useUserSeenEvent
local useUserSeenCollectionEvent = Analytics.useUserSeenCollectionEvent
local _AnalyticsTypes = require(PYMKCarousel.Analytics.AnalyticsTypes)

local UserList = require(PYMKCarouselParent.UserList)
local HorizontalUserList = UserList.HorizontalUserList.HorizontalUserList
local ContactsContext = UserList.ContactsContext

local usePYMKCarouselItemList = require(PYMKCarousel.Components.PYMKCarouselComponent.usePYMKCarouselItemList)
local getPYMKSortedRecommendationIds = require(PYMKCarousel.installReducer.Selectors.getPYMKSortedRecommendationIds)
local useCallbackWhenVisible = require(PYMKCarousel.Components.useCallbackWhenVisible)

local usePYMKCarouselUserEntitiesList = require(PYMKCarousel.Components.PYMKCarouselComponent.usePYMKCarouselUserEntitiesList)
local useContactsContext = require(PYMKCarousel.Components.PYMKCarouselComponent.useContactsContext)
local PYMKUser = require(PYMKCarousel.Components.PYMKUser)
local _DirectRecommendationTypes = require(PYMKCarousel.Common.DirectRecommendationTypes)

local FFlagLuaAppUseFrameBoundsImpressions = require(PYMKCarouselParent.SharedFlags).FFlagLuaAppUseFrameBoundsImpressions
local FFlagPymkCarouselPresenceStoreMigration = require(PYMKCarousel.Flags.FFlagPymkCarouselPresenceStoreMigration)
local FFlagPYMKCarouselStableSelectors = require(PYMKCarousel.Flags.FFlagPYMKCarouselStableSelectors)
local FFlagLuaAppPYMKSendUserSeenCollection = require(PYMKCarouselParent.SharedFlags).FFlagLuaAppPYMKSendUserSeenCollection

local FFlagLuaAppUserSeenCollectionUnifiedFields = require(PYMKCarouselParent.SharedFlags).FFlagLuaAppUserSeenCollectionUnifiedFields
local FFlagLuaAppEnableSduiHomePage = require(PYMKCarouselParent.SharedFlags).FFlagLuaAppEnableSduiHomePage
local FFlagPymkCarouselExtendProps = require(PYMKCarouselParent.SharedFlags).FFlagPymkCarouselExtendProps
local HttpService = if FFlagPymkCarouselExtendProps then game:GetService("HttpService") else nil
local num1 = 0

local tbl1 = {
    [Enum.KeyCode.ButtonX] = FocusNavigationEventNameEnum.SeeAll
}

local num2 = game:DefineFastInt("HomePagePYMKPresenceFetchThrottleInterval", 60)

local function buildDirectRecommendationOverrides(tbl2)
    local recommendationIds = {}
    local recommendationsById = {}
    for absolutePosition, value2 in tbl2 do
        local var1 = RecommendationContextType.fromRawValue(value2.contextType) or RecommendationContextType.None
        local tbl5 = {
            id = value2.id,
            rank = value2.rank,
            contextType = var1,
            mutualFriendsCount = value2.mutualFriendsCount,
            hasIncomingFriendRequest = value2.hasIncomingFriendRequest,
            entityDisplayName = value2.entityDisplayName,
            thumbnailEntities = value2.thumbnailEntities,
            absolutePosition = absolutePosition,
            recommendationRank = value2.rank,
            recommendationContextType = var1
        }
        table.insert(recommendationIds, tbl5)
        recommendationsById[value2.id] = tbl5
    end
    return { recommendationIds = recommendationIds, recommendationsById = recommendationsById }
end

return React.memo(function(tbl2) -- name: PYMKCollectionCarousel
    local var1 = React.useRef(nil)

    local impressionsTag = if FFlagPymkCarouselExtendProps then React.useMemo(function(): string
        return `PYMKCollectionCarousel{HttpService:GenerateGUID(false)}`
    end, {}) else "PYMKCollectionCarousel"

    local scrollViewPositionChangedSignal, var3 = useCollectionImpressionsSignal(tbl2.scrollViewPositionChangedSignal)

    local recommendationsById = nil
    local var4

    if FFlagLuaAppEnableSduiHomePage then
        local var5 = React.useMemo(function()
            return (buildDirectRecommendationOverrides(tbl2.recommendations or {}))
        end, { tbl2.recommendations })

        var4 = var5.recommendationIds

        recommendationsById = var5.recommendationsById
    elseif FFlagPymkCarouselExtendProps then
        var4 = useSelector(function(arg1)
            local localUserId = arg1.LocalUserId
            return getPYMKSortedRecommendationIds(localUserId)(arg1)
        end, if FFlagPYMKCarouselStableSelectors then tutils.deepEqual else tutils.shallowEqual)

        local var5 = React.useMemo(function()
            return (buildDirectRecommendationOverrides(tbl2.recommendations or {}))
        end, { tbl2.recommendations })

        if tbl2.recommendations then
            var4 = var5.recommendationIds
            recommendationsById = var5.recommendationsById
        end
    else
        var4 = useSelector(function(arg1)
            local localUserId = arg1.LocalUserId
            return getPYMKSortedRecommendationIds(localUserId)(arg1)
        end, if FFlagPYMKCarouselStableSelectors then tutils.deepEqual else tutils.shallowEqual)
    end

    local num3 = var4 and #var4 or 0
    local recommendationSessionId = tbl2.recommendationSessionId
    local fireAnalyticsEvent = tbl2.fireAnalyticsEvent

    local var5 = usePYMKCarouselItemList({
        recommendationIds = var4,
        recommendationCount = num3,
        findFriendsTileEnabled = tbl2.findFriendsTileEnabled,
        seeAllTileEnabled = tbl2.seeAllTileEnabled
    })
    local var6 = if FFlagLuaAppPYMKSendUserSeenCollection then React.useMemo(function()
        return Dash.filter(var5, function(arg1): boolean
            return not (arg1.isButtonTile or arg1.isTooltip)
        end)
    end, { var5 }) else nil

    React.useLayoutEffect(function()
        SocialStopwatch.Stopwatch.start(SocialStopwatch.Events.PYMKCarouselLoaded)
        return function()
            if SocialStopwatch.Stopwatch.get(SocialStopwatch.Events.PYMKCarouselLoaded) then
                SocialStopwatch.Stopwatch.stop(SocialStopwatch.Events.PYMKCarouselLoaded)
            end
        end
    end, { recommendationSessionId })

    local dataUpdatedTimestamp, var8 = React.useState(os.clock())
    local var9 = nil
    local var10 = nil

    if not FFlagPymkCarouselPresenceStoreMigration then
        local var11 = useDispatch()
        local var12 = React.useCallback(function()
            local var12 = Dash.reduce(var4, function<T>(arg1: T, arg2): T
                if arg2.recommendationContextType ~= RecommendationContextType.Contacts then
                    table.insert(arg1, arg2.id)
                end
                return arg1
            end, {})

            if #var12 > 0 then
                var11(NetworkingPresence.GetPresencesFromUserIds.API(var12))
                fireAnalyticsEvent(EventNames.PYMKUserPresenceLoad)
            end
        end, { var11, var4, fireAnalyticsEvent })

        local callback = useThrottledCallback(var12, num2)
        useCallbackWhenVisible(
            {
                elementRef = var1,
                scrollViewPositionChangedSignal = tbl2.scrollViewPositionChangedSignal,
                callback = callback
            }
        )
    else
        var9, var10 = React.useState(0)

        local callback = useThrottledCallback(function()
            var10(var9 + 1)
        end, num2)

        useCallbackWhenVisible(
            {
                elementRef = var1,
                scrollViewPositionChangedSignal = tbl2.scrollViewPositionChangedSignal,
                callback = callback
            }
        )
    end
    React.useEffect(function()
        fireAnalyticsEvent(
            EventNames.CarouselLoadedWithUsers,
            {
                recommendationCount = num3,
                refreshCount = num1,
                findFriendsTileEnabled = tbl2.findFriendsTileEnabled
            }
        )
        num1 += 1
        var8(os.clock())
    end, { recommendationSessionId, num3 })

    if FFlagPymkCarouselExtendProps then
        local bool1 = num3 > 0
        React.useEffect(function()
            if bool1 and tbl2.onRecommendationsShown then
                tbl2.onRecommendationsShown()
            end
        end, { bool1, tbl2.onRecommendationsShown })
    end

    local onTitleActivated = React.useCallback(function()
        fireAnalyticsEvent(EventNames.CarouselGenericTileClicked, { btn = BtnValues.SeeAll.rawValue() })
        tbl2.goToAddFriendsPage(false)
    end, { tbl2.goToAddFriendsPage, fireAnalyticsEvent })

    local var12 = useUserSeenEvent(fireAnalyticsEvent)
    local var13 = nil
    if FFlagLuaAppPYMKSendUserSeenCollection then
        if FFlagLuaAppUserSeenCollectionUnifiedFields then
            local var14 = useUserSeenCollectionEvent
            local tbl3 = {
                collectionId = if tbl2.sortAnalyticsData then tbl2.sortAnalyticsData.sortId else nil,
                collectionPosition = if tbl2.sortAnalyticsData then tbl2.sortAnalyticsData.sortIndex else nil,
                feedRowNumber = if tbl2.sortAnalyticsData then tbl2.sortAnalyticsData.startRow else nil,
                totalNumberOfItems = num3
            }
            var13 = var14(fireAnalyticsEvent, tbl3)
        else
            var13 = useUserSeenCollectionEvent(fireAnalyticsEvent)
        end
    end

    local useCallback = React.useCallback
    local function func1(tbl3)
        local changed = {}
        for _, value in tbl3 do
            if FFlagLuaAppPYMKSendUserSeenCollection then
                local var14 = var6[value]
                if var14 and var14.id then
                    var13.addTileToCollection(var14.id, value, var14)
                end
            end
            table.insert(changed, { item = var5[value] })
        end

        if #var12 > 0 then
            var12[1].onViewableItemsChanged({ changed = changed })
        end
    end

    local var14 = if FFlagLuaAppPYMKSendUserSeenCollection then var6 else nil
    local var15 = if FFlagLuaAppPYMKSendUserSeenCollection then var13 else nil
    local sendImpressions = useCallback(func1, { var12, var5, var14, var15 })

    local var17 = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.SeeAll] = {
                handler = InputHandlers.onRelease(onTitleActivated)
            }
        }
    end, { onTitleActivated })

    local var18 = ReactFocusNavigation.useEventMap(tbl1)

    local var19 = ReactFocusNavigation.useEventHandlerMap(var17, var18)

    React.useEffect(function()
        if var19 and var1 then
            var19(var1.current)
        end
        return function()
            var19(nil)
        end
    end, { var19, var1, var1 and var1.current })

    local entities = usePYMKCarouselUserEntitiesList(var5)
    local value = useContactsContext(
        var5,
        if FFlagPymkCarouselExtendProps or FFlagLuaAppEnableSduiHomePage then recommendationsById else nil
    )

    local useCallback2 = React.useCallback
    local function func2(createRow, entity, absolutePosition)
        local createElement = React.createElement
        local var22 = PYMKUser
        local tbl3 = {
            createRow = createRow,
            entity = entity,
            showToast = tbl2.showToast,
            fireAnalyticsEvent = fireAnalyticsEvent,
            absolutePosition = absolutePosition,
            recommendationSessionId = tbl2.recommendationSessionId,
            openProfilePeekView = tbl2.openProfilePeekView,
            impressionsTag = impressionsTag,
            forceFetchUserPresence = if FFlagPymkCarouselPresenceStoreMigration then var9 else nil,
            recommendation = if (FFlagPymkCarouselExtendProps or FFlagLuaAppEnableSduiHomePage) and recommendationsById then recommendationsById[tostring(entity.id)] else nil,
            analyticsSurface = if FFlagPymkCarouselExtendProps then tbl2.analyticsSurface else nil
        }
        return createElement(var22, tbl3)
    end

    local showToast = tbl2.showToast

    local recommendationSessionId2 = tbl2.recommendationSessionId
    local openProfilePeekView = tbl2.openProfilePeekView
    local var22 = if FFlagPymkCarouselPresenceStoreMigration then var9 else nil
    local var23 = if FFlagPymkCarouselExtendProps or FFlagLuaAppEnableSduiHomePage then recommendationsById else nil
    local analyticsSurface = if FFlagPymkCarouselExtendProps then tbl2.analyticsSurface else nil
    local var24 = if FFlagPymkCarouselExtendProps then impressionsTag else nil
    local renderRow = useCallback2(
        func2,
        {
            showToast,
            fireAnalyticsEvent,
            recommendationSessionId2,
            openProfilePeekView,
            var22,
            var23,
            analyticsSurface,
            var24
        }
    )

    if #var5 == 0 then
        return nil
    end

    return React.createElement(React.Fragment, nil, {
        ContactsContextProvider = React.createElement(ContactsContext.Provider, { value = value }, {
            PYMKCarousel = React.createElement(HorizontalUserList, {
                entities = entities,
                renderRow = renderRow,
                header = {
                    title = tbl2.carouselTitle,
                    onTitleActivated = onTitleActivated
                },
                collectionCarouselConfigs = {
                    onViewableItemsChanged = var3,
                    onChangeCanvasPosition = var3
                },
                listConfigs = { showSubtitle = false },
                scrollingFrameRef = var1,
                appCompositionEnabled = tbl2.appCompositionEnabled
            })
        }),
        ScreenSizeImpressionsTracker = React.createElement(
            if FFlagLuaAppUseFrameBoundsImpressions then FrameBoundsImpressionsTracker else ScreenSizeImpressionsTracker,
            {
                pageContext = tbl2.pageContext,
                parentRef = var1,
                impressionsTag = impressionsTag,
                scrollViewPositionChangedSignal = scrollViewPositionChangedSignal,
                sendImpressions = sendImpressions,
                dataUpdatedTimestamp = dataUpdatedTimestamp
            }
        )
    })
end)
