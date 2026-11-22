-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent
local React = require(SocialCarouselParent.React)
local CollectionViews = require(SocialCarouselParent.CollectionViews)
local Localization = require(SocialCarouselParent.Localization)
local Foundation = require(SocialCarouselParent.Foundation)
local RobloxAppHooks = require(SocialCarouselParent.RobloxAppHooks)
local RobloxAppEnums = require(SocialCarouselParent.RobloxAppEnums)

local CollectionCarousel = CollectionViews.CollectionCarousel
local useCollectionLayoutParams = CollectionViews.useCollectionLayoutParams
local useCollectionLayout = CollectionViews.useCollectionLayout
local CollectionViewTypes = CollectionViews.CollectionViewTypes
local usePageSideMargin = CollectionViews.usePageSideMargin
local CollectionItemSize = CollectionViewTypes.CollectionItemSize
local useLocalization = Localization.Hooks.useLocalization
local TileComponents = require(SocialCarousel.Common.TileComponents)
local Tile = require(SocialCarousel.Common.Enums).Tile
local Constants = require(SocialCarousel.Common.Constants)
local useSocialCarouselContext = require(SocialCarousel.Contexts.useSocialCarouselContext)
local useColdStartLayoutReady = require(SocialCarousel.Hooks.useColdStartLayoutReady)
local useAddFriendsTileSeenImpression = require(SocialCarousel.Hooks.useAddFriendsTileSeenImpression)
local useTokens = Foundation.Hooks.useTokens
local useTilesSeenCollection = require(SocialCarousel.Analytics.useTilesSeenCollection)
local FFlagSocialCarouselShowLoadingSkeleton = require(SocialCarousel.Flags.FFlagSocialCarouselShowLoadingSkeleton)
local FFlagSocialCarouselFixColdStartJitter = require(SocialCarousel.Flags.FFlagSocialCarouselFixColdStartJitter)
local bool1 = game:DefineFastFlag("FixCarouselTileSizeScaling", false)
local FFlagFlyoutHideFriendsHeader = require(SocialCarousel.Flags.FFlagFlyoutHideFriendsHeader)
local FlyoutSidePanelIXP = require(SocialCarouselParent.SharedExperimentDefinition).FlyoutSidePanelIXP
local SharedFlags = require(SocialCarouselParent.SharedFlags)
local FFlagEnableFlyoutFriendsHeaderFix = SharedFlags.FFlagEnableFlyoutFriendsHeaderFix
local FFlagLuaAppCompositionAlways = require(SocialCarouselParent.SharedFlags).FFlagLuaAppCompositionAlways
local FFlagLuaAppFriendsSortHeaderByPosition = SharedFlags.FFlagLuaAppFriendsSortHeaderByPosition
local FFlagSocialCarouselInGameTitleMarquee = require(SocialCarouselParent.SharedFlags).FFlagSocialCarouselInGameTitleMarquee
local FFlagSocialCarouselBuildPresence = SharedFlags.FFlagSocialCarouselBuildPresence

local FFlagSocialCarouselLogNewFriendRequestsBadge = require(SocialCarousel.Flags.FFlagSocialCarouselLogNewFriendRequestsBadge)
local FFlagShowRequestsInCarouselForAllUsers = SharedFlags.FFlagShowRequestsInCarouselForAllUsers
local FFlagSocialCarouselXXSmallTiles = require(SocialCarousel.Flags.FFlagSocialCarouselXXSmallTiles)
local FFlagSocialCarouselXSmallTileText = require(SocialCarousel.Flags.FFlagSocialCarouselXSmallTileText)
local MarqueeScrollContext = require(SocialCarousel.Stores.MarqueeSession.MarqueeScrollContext).MarqueeScrollContext

local useCarouselMarquee = if FFlagSocialCarouselInGameTitleMarquee then require(SocialCarousel.Components.Carousel.useCarouselMarquee).useCarouselMarquee else nil

local function friendTileMarqueeProps(friend, num1: number, tbl1, bool2: boolean, num2: number?, func1: ((...any) -> (...any))?, func2: ((...any) -> (...any))?, func3: ((...any) -> (...any))?, bool3: boolean, bool4: boolean, bool5: boolean, bool6: boolean) -- Luacid: unused: defined but never referenced
    if friend ~= Tile.Friend or tbl1 == nil then
        return nil, nil, nil, nil, nil, nil, nil
    end

    local str1 = tbl1[num1] == true and (if bool2 then "Paused" else "Playing") or "Idle"

    if not bool3 then
        func1 = nil
    end

    local bool7 = bool4 or bool5
    if not bool7 then
        func2 = nil
    end

    if not bool7 then
        func3 = nil
    end

    return str1, func1, num2, func2, func3, if bool5 then true else nil, bool6
end

local tbl1 = {}
local tbl2 = {
    [Tile.AddFriends] = "add-friends",
    [Tile.ShareQR] = "share-qr",
    [Tile.StartSquad] = "start-squad",
    [Tile.Skeleton] = "skeleton"
}

local function findAddFriendsTileIndex(tiles) -- Luacid: Inlined by compiler; 1 call site recovered
    if tiles == nil then
        return nil
    end
    for i, value in ipairs(tiles) do
        if value and value.tileType == Tile.AddFriends then
            return i
        end
    end
    return nil
end

local function Carousel(tbl3)
    local appCompositionEnabled = FFlagLuaAppCompositionAlways or tbl3.appCompositionEnabled
    local var2 = if bool1 then useTokens() else nil
    local var3 = useSocialCarouselContext()
    local var4 = useTilesSeenCollection()
    local containerFrame, containerRef = React.useState(nil)
    local scrollingFrameRef = React.useRef(nil)
    local var8 = React.useRef({ startIndex = 1, endIndex = 1 })
    local var9 = React.useRef(false)
    local var10 = React.useRef(nil)
    local var11 = React.useRef(nil)

    local friendsLabel = (if FFlagSocialCarouselShowLoadingSkeleton then not var3.isLoading and var3.friendCount > 0 else var3.friendCount > 0)
        and {
            Constants.LOCALIZATION.FRIENDS_LABEL_WITH_COUNT,
            friendCount = var3.friendCount
        }
        or Constants.LOCALIZATION.FRIENDS_LABEL

    local var13 = useLocalization({ friendsLabel = friendsLabel })
    local var14 = if FFlagLuaAppCompositionAlways then nil else usePageSideMargin(containerFrame)

    if appCompositionEnabled then
        var14 = nil
    end
    local var15 = useCollectionLayoutParams(CollectionItemSize.XSmall, containerFrame, true, { sideMargin = var14 })
    local bool2 = if FFlagSocialCarouselXXSmallTiles or FFlagSocialCarouselXSmallTileText then RobloxAppHooks.useDeviceType() == RobloxAppEnums.DeviceType.Phone else false
    local var16 = useCollectionLayout(CollectionItemSize.XSmall)
    local var17 = if FFlagSocialCarouselXXSmallTiles and bool2 then var16.itemsPerRow + 1 else var16.itemsPerRow
    local var18 = if appCompositionEnabled then var17 else var15.numColumns
    local var19, var20

    if FFlagSocialCarouselFixColdStartJitter then
        local var21, var22 = React.useState(Vector2.zero)
        local bool3 = RobloxAppHooks.useDeviceOrientation() ~= nil
        local var23 = RobloxAppHooks.useScreenSize()

        var19 = useColdStartLayoutReady(bool3, var23, var21.X, var18)
        var20 = React.useCallback(function(vector2: Vector2)
            var22(vector2)
        end, {})
    else
        var19 = false
        var20 = nil
    end

    local var21 = nil
    local var22 = nil
    if FFlagSocialCarouselLogNewFriendRequestsBadge then
        local var23 = React.useMemo(function()
            return findAddFriendsTileIndex(var3.tiles)
        end, { var3.tiles })
        var22 = React.useRef(nil)
        local var24, var25 = React.useState(nil)
        var21 = var25
        if var24 == nil or var23 == nil or not (var24.startIndex <= var23) or not (var23 <= var24.endIndex) then
            var23 = nil
        end

        useAddFriendsTileSeenImpression(var23)
    end

    React.useEffect(function()
        if var18 == var10.current then
            return
        end

        var10.current = var18
        var9.current = false

        if var11.current then
            pcall(task.cancel, var11.current)
        end

        var11.current = task.delay(0.2, function()
            var9.current = true
            var11.current = nil
        end)
    end, { var18 })

    React.useEffect(function()
        return function()
            if var11.current then
                pcall(task.cancel, var11.current)
            end
        end
    end, {})

    local var23 = if FFlagSocialCarouselXSmallTileText and bool2 then Constants.XSMALL_TILE_TEXT_HEIGHT else Constants.TILE_TEXT_HEIGHT

    local getItemHeight = React.useCallback(function(num1: number): number
        return num1 + (if bool1 then var23 * var2.Config.UI.Scale else var23)
    end, { if FFlagSocialCarouselXSmallTileText then var23 else nil, if FFlagSocialCarouselXSmallTileText and var2 then var2.Config.UI.Scale else nil })

    local selectionOrderBase = var3.selectionOrderBase
    local isLoading = FFlagSocialCarouselShowLoadingSkeleton and var3.isLoading

    local scrollContext = nil
    local activeByIndex = nil
    local isPaused = false
    local onMarqueeFinished = nil
    local onManualMarqueeStart = nil
    local onManualMarqueeEnd = nil
    local marqueeRunId = nil
    local handsOff = false
    local desktopEnabled = false
    local consoleEnabled = false
    local bool3 = false
    if FFlagSocialCarouselInGameTitleMarquee then
        local bool4 = var3.source == Constants.ANALYTICS.SRC.HOMEPAGE_FRIENDS_CAROUSEL
        local var25 = useCarouselMarquee

        local tiles = var3.tiles
        local var26 = if FFlagSocialCarouselBuildPresence then var3.openGameJoinCardUserId or var3.openBuildCardUserId else var3.openGameJoinCardUserId
        local var27 = var25(
            scrollingFrameRef,
            tiles,
            var26,
            {
                appCompositionEnabled = appCompositionEnabled,
                itemsPerRow = var18,
                showSkeleton = isLoading,
                isColdStartLayoutReady = var19,
                defaultSkeletonCount = 5,
                containerFrame = containerFrame,
                gutter = var16.gutter,
                carouselPeek = var16.carouselPeek,
                columnGap = var15.columnGap,
                sideMargin = var15.sideMargin,
                fractionalItemAmount = var15.fractionalItemAmount,
                maxTilesToShow = var15.maxTilesToShow
            },
            var3.joinPopoverUserIdRef,
            var3.joinSheetUserIdRef,
            var3.source,
            bool4
        )

        activeByIndex = var27.activeByIndex
        isPaused = var27.isPaused
        onMarqueeFinished = var27.onMarqueeFinished
        onManualMarqueeStart = var27.onManualMarqueeStart
        onManualMarqueeEnd = var27.onManualMarqueeEnd
        marqueeRunId = var27.marqueeRunId
        handsOff = var27.handsOff
        desktopEnabled = var27.desktopEnabled
        consoleEnabled = var27.consoleEnabled
        bool3 = var27.marqueeShortTitlesEnabled == true
        scrollContext = var27.scrollContext
    end

    local var25 = if FFlagSocialCarouselXXSmallTiles then bool2 and appCompositionEnabled == true else nil
    local useCallback = React.useCallback
    local function func1(arg1, arg2, arg3)
        local var26 = if selectionOrderBase then selectionOrderBase + arg2 else nil
        local var27, var28, var29, var30, var31, var32, var33

        if FFlagSocialCarouselInGameTitleMarquee then
            local tileType = arg1.tileType

            local var34 = activeByIndex
            local var35 = isPaused
            var27 = marqueeRunId
            var28 = onMarqueeFinished
            var29 = onManualMarqueeStart
            var30 = onManualMarqueeEnd
            local var36 = handsOff
            local var37 = desktopEnabled
            local var38 = consoleEnabled
            var31 = bool3

            if tileType == Tile.Friend and var34 ~= nil then
                var32 = var34[arg2] == true and (if var35 then "Paused" else "Playing") or "Idle"

                if not var36 then
                    var28 = nil
                end

                local var39 = var37 or var38
                if not var39 then
                    var29 = nil
                end

                if not var39 then
                    var30 = nil
                end

                var33 = if var38 then true else nil
            else
                var32 = nil
                var28 = nil
                var27 = nil
                var29 = nil
                var30 = nil
                var33 = nil
                var31 = nil
            end
        else
            var32 = nil
            var28 = nil
            var27 = nil
            var29 = nil
            var30 = nil
            var33 = nil
            var31 = nil
        end

        local var34 = TileComponents[arg1.tileType](arg1, arg2, arg3, var26, function(str1: string, num1: number, arg4)
            if FFlagShowRequestsInCarouselForAllUsers and arg4 then
                local current = var8.current
                if current.startIndex <= num1 and num1 <= current.endIndex then
                    var4.addTileToCollection(str1, num1, arg4)
                end
            end
            if tbl3.onTileContentChanged then
                tbl3.onTileContentChanged(str1, num1, FFlagShowRequestsInCarouselForAllUsers and arg4 or arg1)
            end
        end, var25, var32, var28, var27, var29, var30, var33, var31)

        local var35 = tbl2[arg1.tileType]
        if var35 then
            local sortAnalyticsData = var3.sortAnalyticsData
            local source = var3.source or "carousel"
            local var36 = if sortAnalyticsData then sortAnalyticsData.sortIndex else 1
            var34 = React.cloneElement(var34, { testId = `--social-social-carousel-view-{var35}-{source}-{var36}-{arg2}` })
        end

        return var34, arg1.tileType
    end

    local onTileContentChanged = tbl3.onTileContentChanged
    local source = var3.source
    local sortAnalyticsData = var3.sortAnalyticsData
    local var26 = if FFlagShowRequestsInCarouselForAllUsers then var4 else nil
    local var27 = if FFlagSocialCarouselInGameTitleMarquee then activeByIndex else nil
    local var28 = if FFlagSocialCarouselInGameTitleMarquee then isPaused else nil
    local var29 = if FFlagSocialCarouselInGameTitleMarquee then onMarqueeFinished else nil
    local var30 = if FFlagSocialCarouselInGameTitleMarquee then marqueeRunId else nil
    local var31 = if FFlagSocialCarouselInGameTitleMarquee then onManualMarqueeStart else nil
    local var32 = if FFlagSocialCarouselInGameTitleMarquee then onManualMarqueeEnd else nil
    local var33 = if FFlagSocialCarouselInGameTitleMarquee then handsOff else nil
    local var34 = if FFlagSocialCarouselInGameTitleMarquee then desktopEnabled else nil
    local var35 = if FFlagSocialCarouselInGameTitleMarquee then consoleEnabled else nil
    local bool4 = if FFlagSocialCarouselInGameTitleMarquee then bool3 else nil
    local renderItem = useCallback(func1, {
        selectionOrderBase,
        var25,
        onTileContentChanged,
        source,
        sortAnalyticsData,
        var26,
        var27,
        var28,
        var29,
        var30,
        var31,
        var32,
        var33,
        var34,
        var35,
        bool4
    })

    local var37 = React.useCallback(function(startIndex: number, endIndex: number)
        if FFlagSocialCarouselLogNewFriendRequestsBadge and var21 ~= nil and var22 ~= nil then
            local current = var22.current
            if current == nil or current.startIndex ~= startIndex or current.endIndex ~= endIndex then
                local tbl4 = { startIndex = startIndex, endIndex = endIndex }

                var22.current = tbl4
                var21(tbl4)
            end
        end

        if var3.unifiedLogging then
            var3.unifiedLogging.onCollectionViewabilityChanged(startIndex, endIndex)
        end

        if not var3.tiles or not containerFrame or not scrollingFrameRef.current or not var9.current then
            return
        end

        local current = scrollingFrameRef.current
        local absoluteSize = containerFrame.AbsoluteSize
        local canvasPosition = current.CanvasPosition
        local var37 = absoluteSize.X / var18
        local canvasPositionX = canvasPosition.X
        local absoluteSizeX = absoluteSize.X

        local num1 = math.max(1, math.floor(canvasPositionX / var37) + 1)

        local num2 = math.min(#var3.tiles, math.ceil((canvasPositionX + absoluteSizeX) / var37))

        var8.current = { startIndex = num1, endIndex = num2 }

        for i = num1, num2 do
            local var38 = var3.tiles[i]
            if var38 and var38.id then
                var4.addTileToCollection(var38.id, i, var38)
            end
        end
    end, {
        tbl3.onViewableItemsChanged,
        var3.tiles,
        var3.unifiedLogging,
        containerFrame,
        scrollingFrameRef,
        var18,
        var4,
        var21,
        var22
    })

    local var38 = React.useMemo(function()
        local result = ({})
        if not FFlagSocialCarouselShowLoadingSkeleton then
            return result
        end

        for i = 1, (var18 or 5) + 1 do
            local tbl4 = {
                id = "skeleton_" .. i,
                tileType = Tile.Skeleton
            }
            result[i] = tbl4
        end
        return result
    end, { var18 })

    if not isLoading then
        var38 = var3.tiles
    end

    if FFlagSocialCarouselFixColdStartJitter and not var19 then
        var38 = tbl1
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl4 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1
    }
    local tbl5 = {
        UIPadding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, 0), PaddingRight = UDim.new(0, 0) }),
        CollectionCarousel = 0,
        ScreenSizeImpressionsTracker = 0
    }
    local createElement2 = React.createElement
    local var39 = CollectionCarousel
    local tbl6 = {
        containerRef = containerRef,
        scrollingFrameRef = scrollingFrameRef,
        onContainerSizeChanged = 0,
        LayoutOrder = 1,
        title = 0,
        items = 0,
        renderItem = 0,
        getItemHeight = 0,
        collectionItemSize = 0,
        numColumns = 0,
        fractionalItemAmount = 0,
        columnGap = 0,
        sideMargin = 0,
        maxItemsToShow = 0,
        thresholdFromEnd = 0,
        onViewableItemsChanged = 0,
        onChangeCanvasPosition = 0,
        onActivateHeader = 0,
        headerComponent = 0
    }

    if not FFlagSocialCarouselFixColdStartJitter then
        var20 = nil
    end

    tbl6.onContainerSizeChanged = var20

    tbl6.title = var13.friendsLabel
    tbl6.items = var38
    tbl6.renderItem = renderItem
    tbl6.getItemHeight = getItemHeight
    tbl6.collectionItemSize = if appCompositionEnabled then CollectionItemSize.XSmall else nil
    if appCompositionEnabled then
        if not (FFlagSocialCarouselXXSmallTiles and bool2) then
            var17 = nil
        end
    else
        var17 = var15.numColumns
    end

    tbl6.numColumns = var17

    tbl6.fractionalItemAmount = if appCompositionEnabled then nil else var15.fractionalItemAmount
    tbl6.columnGap = if appCompositionEnabled then nil else var15.columnGap
    tbl6.sideMargin = if appCompositionEnabled then nil else var15.sideMargin
    tbl6.maxItemsToShow = var15.maxTilesToShow
    tbl6.thresholdFromEnd = var15.loadMoreThreshold
    if isLoading or FFlagSocialCarouselFixColdStartJitter and not var19 then
        var37 = nil
    end

    tbl6.onViewableItemsChanged = var37

    tbl6.onChangeCanvasPosition = if var3.unifiedLogging and not isLoading and (not FFlagSocialCarouselFixColdStartJitter or var19) then var3.unifiedLogging.onCollectionViewabilityChanged else nil

    tbl6.onActivateHeader = tbl3.onActivateHeader
    local element, var40, var41

    if FFlagLuaAppFriendsSortHeaderByPosition then
        if var3.hideCarouselHeader then
            element = React.createElement(React.Fragment, nil, {})
        else
            element = nil
        end
    else
        if var3.hideCarouselHeader then
            element = React.createElement(React.Fragment, nil, {})
            tbl6.headerComponent = element
            tbl5.CollectionCarousel = createElement2(var39, tbl6)

            if var3.unifiedLogging and (not FFlagSocialCarouselFixColdStartJitter or var19) then
                var40 = var3.unifiedLogging.renderImpressionsTrackerComponent(scrollingFrameRef)
            else
                var40 = nil
            end

            tbl5.ScreenSizeImpressionsTracker = var40
            var41 = createElement(str1, tbl4, tbl5)

            if scrollContext == nil then
                return var41
            end
            return React.createElement(MarqueeScrollContext.Provider, { value = scrollContext }, { Carousel = var41 })
        end

        if FFlagFlyoutHideFriendsHeader then
            if if FFlagEnableFlyoutFriendsHeaderFix then FlyoutSidePanelIXP.isFriendsSortHeaderHiddenInFlyoutIxp() else FlyoutSidePanelIXP.isFlyoutSidePanelEnabled() then
                element = React.createElement(React.Fragment, nil, {})
                tbl6.headerComponent = element
                tbl5.CollectionCarousel = createElement2(var39, tbl6)

                if var3.unifiedLogging and (not FFlagSocialCarouselFixColdStartJitter or var19) then
                    var40 = var3.unifiedLogging.renderImpressionsTrackerComponent(scrollingFrameRef)
                else
                    var40 = nil
                end

                tbl5.ScreenSizeImpressionsTracker = var40
                var41 = createElement(str1, tbl4, tbl5)

                if scrollContext == nil then
                    return var41
                end
                return React.createElement(MarqueeScrollContext.Provider, { value = scrollContext }, { Carousel = var41 })
            end

            element = nil
        else
            element = nil
        end
    end

    tbl6.headerComponent = element
    tbl5.CollectionCarousel = createElement2(var39, tbl6)

    if var3.unifiedLogging and (not FFlagSocialCarouselFixColdStartJitter or var19) then
        var40 = var3.unifiedLogging.renderImpressionsTrackerComponent(scrollingFrameRef)
    else
        var40 = nil
    end

    tbl5.ScreenSizeImpressionsTracker = var40
    var41 = createElement(str1, tbl4, tbl5)

    if scrollContext == nil then
        return var41
    end
    return React.createElement(MarqueeScrollContext.Provider, { value = scrollContext }, { Carousel = var41 })
end

return Carousel
