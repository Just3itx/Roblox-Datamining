-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollections = script:FindFirstAncestor("GameCollections")

local useControllerBarFocusNavigationBindings = require(GameCollections.GameCollectionNavigationBindings).useControllerBarFocusNavigationBindings
local useGetGameTileHeight = require(GameCollections.useGetGameTileHeight)
local useIsHoldToPlayEnabledForGames = require(GameCollections.useIsHoldToPlayEnabledForGames)
local useRenderGameCollectionItem = require(GameCollections.useRenderGameCollectionItem)
local useGameCollectionLayoutParams = require(GameCollections.useGameCollectionLayoutParams)
local useGameSortAnalytics = require(GameCollections.useGameSortAnalytics)
local GameSortImpressionsDetector = require(GameCollections.Impressions.GameSortImpressionsDetector)
local useGameSortData = require(GameCollections.useGameSortData)
local useGameSortImpressionsParams = require(GameCollections.Impressions.useGameSortImpressionsParams)
local useGameSortTooltipParams = require(GameCollections.useGameSortTooltipParams)
local WaitForPropWrapper = require(GameCollections.Impressions.WaitForPropWrapper)
local useSizeAdjustedEntries = require(GameCollections.useSizeAdjustedEntries)

local GameCollectionsParent = GameCollections.Parent
local React = require(GameCollectionsParent.React)
local SignalsReact = require(GameCollectionsParent.SignalsReact)
local t = require(GameCollectionsParent.t)
local DiscoveryUtils = require(GameCollectionsParent.DiscoveryUtils)
local validateProps = DiscoveryUtils.validateProps
local composeRefs = DiscoveryUtils.composeRefs
local GameTile = require(GameCollectionsParent.GameTile)
local getGameTileCollectionItemSize = GameTile.getGameTileCollectionItemSize
local getGameTileHiddenStore = GameTile.getGameTileHiddenStore
local GameTileConstants = GameTile.GameTileConstants
local _VideoUtils = require(GameCollectionsParent.VideoUtils)
local _AppCommonLib = require(GameCollectionsParent.AppCommonLib)
local Responsive = require(GameCollectionsParent.Responsive)
local usePreferredInput = Responsive.usePreferredInput
local useBreakpointXOrSmaller = Responsive.useBreakpointXOrSmaller
local useAppPolicy = require(GameCollectionsParent.UniversalAppPolicy).useAppPolicy
local CollectionGrid = require(GameCollectionsParent.CollectionViews).CollectionGrid
local useCollectionLayout = require(GameCollectionsParent.CollectionViews).useCollectionLayout
local AppPage = require(GameCollectionsParent.RobloxAppEnums).AppPage
local DiscoveryAnalytics = require(GameCollectionsParent.DiscoveryAnalytics)
local useTextSizeOffset = require(GameCollectionsParent.UIBlox).Core.Style.useTextSizeOffset
local HoldToPlay = require(GameCollectionsParent.HoldToPlay)
local HoldToPlayLauncher = HoldToPlay.HoldToPlayLauncher
local useHoldToPlayStateAndCallbacks = HoldToPlay.useHoldToPlayStateAndCallbacks
local _DiscoveryTypes = require(GameCollectionsParent.DiscoveryTypes)
local Cryo = require(GameCollectionsParent.Cryo)
local _CollectionViews = require(GameCollectionsParent.CollectionViews)
local FFlagLuaAppEnableReportExperience = require(GameCollectionsParent.SharedFlags).FFlagLuaAppEnableReportExperience
local FFlagLuaAppCompositionAlways = require(GameCollectionsParent.SharedFlags).FFlagLuaAppCompositionAlways
local FFlagLuaAppNarrowTileHideRating = require(GameCollectionsParent.SharedFlags).FFlagLuaAppNarrowTileHideRating
local FFlagLuaAppNarrowTileHidePlayerCount = require(GameCollectionsParent.SharedFlags).FFlagLuaAppNarrowTileHidePlayerCount
local FFlagLuaAppRfyRevealRows = require(GameCollectionsParent.SharedFlags).FFlagLuaAppRfyRevealRows
local FFlagLuaAppSortHeaderAnchorTag = require(GameCollectionsParent.SharedFlags).FFlagLuaAppSortHeaderAnchorTag

local num1 = game:DefineFastInt("LuaAppGameGridBufferRowsBelowScreen", 2)
local num2 = game:DefineFastInt("LuaAppGameGridBufferRowsAboveScreen", 1)

local var1 = t.strictInterface({
    entries = t.optional(t.table),
    title = t.optional(t.string),
    headerComponent = t.optional(t.table),
    headerTag = if FFlagLuaAppSortHeaderAnchorTag then t.optional(t.string) else nil,
    verticalScrollingFrameRef = t.table,
    gridContainerRef = t.optional(t.union(t.table, t.callback)),
    LayoutOrder = if FFlagLuaAppRfyRevealRows then t.optional(t.number) else nil,
    ZIndex = if FFlagLuaAppRfyRevealRows then t.optional(t.number) else nil,
    maxNumRows = t.optional(t.number),
    useGridTiles = t.optional(t.boolean),
    gameSortId = t.string,
    sortIndex = t.number,
    pageContext = t.string,
    scrollViewPositionChangedSignal = t.optional(t.table),
    friendFooterEnabled = t.optional(t.boolean),
    playerCountStyle = t.optional(t.string),
    isSponsoredFooterAllowed = t.optional(t.boolean),
    componentType = t.optional(t.string),
    gameTileLayoutType = t.optional(t.string),
    infoText = t.optional(t.string),
    linkPath = t.optional(t.string),
    gridSupportAllowed = t.optional(t.boolean),
    isHoverSupportEnabled = t.optional(t.boolean),
    onItemsPerRowChanged = t.optional(t.callback),
    startRow = t.optional(t.number),
    playButtonStyle = t.optional(t.string),
    sideMargin = if FFlagLuaAppCompositionAlways then nil else t.optional(t.number),
    shouldHideTileMetadata = t.optional(t.boolean),
    shouldHideTileTitle = t.optional(t.boolean),
    containedTile = t.optional(t.boolean),
    numUpdatesToDelayImpressions = t.optional(t.number),
    selectionOrderBase = t.optional(t.number),
    enableExplicitFeedback = t.optional(t.boolean),
    sponsoredUserCohort = t.optional(t.string),
    enableSponsoredFeedback = t.optional(t.boolean),
    enableReportAd = t.optional(t.boolean),
    enableReportExperience = if FFlagLuaAppEnableReportExperience then t.optional(t.boolean) else nil,
    searchParams = t.optional(t.table),
    layoutOverrides = t.optional(t.table),
    isSponsoredRatingFooterAllowed = t.optional(t.boolean),
    launchExperienceEventContextOverride = t.optional(t.string),
    appCompositionEnabled = t.optional(t.boolean),
    videoPlaybackContext = t.optional(t.table)
})

return React.memo(function(tbl1) -- name: GameCollectionGrid
    validateProps(var1, tbl1)

    local var2 = useAppPolicy(function(arg1)
        return arg1.useGridPageLayout()
    end)
    local var3 = usePreferredInput()
    local bufferRowsBelowScreen = num1
    local bufferRowsAboveScreen = num2

    local var4 = tbl1.isHoverSupportEnabled and var2 and var3 == Responsive.Input.Pointer

    local gameTileLayoutType = tbl1.gameTileLayoutType or "Narrow"
    local var5 = FFlagLuaAppCompositionAlways or tbl1.appCompositionEnabled

    local var6 = useBreakpointXOrSmaller(Responsive.Keys.Small)
    if var5 then
        if gameTileLayoutType ~= "Narrow" then
            var6 = false
        end
    else
        var6 = var5
    end

    local var7 = if FFlagLuaAppNarrowTileHideRating then var6 else nil
    local var8 = if FFlagLuaAppNarrowTileHidePlayerCount then var6 else nil
    local gameTileCollectionItemSize = if var5 then getGameTileCollectionItemSize(gameTileLayoutType) else nil
    local current, var10 = React.useState(nil)

    local parentRef = React.useRef(current)
    parentRef.current = current

    local containerRef = React.useMemo(function()
        return (composeRefs(var10, tbl1.gridContainerRef))
    end, { tbl1.gridContainerRef })

    local var13 = useGameSortData(tbl1.gameSortId, tbl1.pageContext, tbl1.searchParams and tbl1.searchParams.searchUuid)

    local var14 = React.useMemo(function()
        local sideMargin = if var2 then nil else tbl1.sideMargin

        if not (tbl1.layoutOverrides or sideMargin) then
            return nil
        end

        local join = Cryo.Dictionary.join
        local layoutOverrides = tbl1.layoutOverrides or {}
        local tbl2 = { sideMargin = 0 }
        if tbl1.layoutOverrides and tbl1.layoutOverrides.sideMargin then
            sideMargin = tbl1.layoutOverrides.sideMargin
        end

        tbl2.sideMargin = sideMargin
        return join(layoutOverrides, tbl2)
    end, { tbl1.layoutOverrides, var2, tbl1.sideMargin })

    local var15 = useGameCollectionLayoutParams(gameTileLayoutType, current, false, var14)

    local var16 = useCollectionLayout(gameTileCollectionItemSize)
    local itemsPerRow = var16.itemsPerRow

    local items = useSizeAdjustedEntries(
        tbl1.entries,
        if var5 then var16.gutter else var15.columnGap,
        if var5 then var16.verticalGap else var15.verticalPadding
    )

    local var18 = var5 and (itemsPerRow or 0) or var15.numColumns or 0

    local var19, reportExperienceLaunched = useGameSortAnalytics(var13.sort, var13.isOmni, tbl1.sortIndex, tbl1.pageContext, nil, items, var18, tbl1.startRow)

    local var21 = GameTile.useVideoAnalytics(var13.sort, var13.isOmni, tbl1.pageContext, tbl1.sortIndex, items)

    local onActivateInfoIcon, tooltipInfoText = useGameSortTooltipParams(var13.sort, var13.isOmni, tbl1.infoText)

    local sendGameImpressions, scrollViewPositionChangedSignal, onViewableItemsChanged = useGameSortImpressionsParams(
        var13.sort,
        var13.isOmni,
        tbl1.sortIndex,
        tbl1.pageContext,
        tbl1.useGridTiles,
        tbl1.componentType,
        var13.gamesApiSortPageId,
        tbl1.gameSortId,
        tbl1.scrollViewPositionChangedSignal,
        var18,
        tbl1.startRow,
        items,
        tbl1.searchParams
    )
    local searchUuid = if tbl1.searchParams then tbl1.searchParams.searchUuid else nil

    local impressionsTag = React.useMemo(function(): string
        local str1 = `GameGrid_{tbl1.pageContext}`

        if searchUuid then
            str1 ..= `_{searchUuid}`
        end
        return str1 .. `_{tbl1.gameSortId}_{tbl1.sortIndex}`
    end, {
        tbl1.pageContext,
        searchUuid,
        tbl1.gameSortId,
        tbl1.sortIndex
    })

    local var28 = useIsHoldToPlayEnabledForGames()
    local var29 = useHoldToPlayStateAndCallbacks()

    local var30 = useControllerBarFocusNavigationBindings(nil, if var28 then var29.holdToPlayEventHandler else nil)

    React.useEffect(function()
        if var30 then
            var30(current)
        end
    end, { var30, current })

    local shouldHideTileTitle = tbl1.shouldHideTileTitle or false
    local shouldHideTileMetadata = tbl1.shouldHideTileMetadata or false
    local containedTile = tbl1.containedTile or false

    local var31 = useTextSizeOffset()
    local titleTextLines = GameTileConstants.TileTextLines[gameTileLayoutType]
        and GameTileConstants.TileTextLines[gameTileLayoutType].titleTextLines
    local getItemHeight = useGetGameTileHeight(
        var4,
        gameTileLayoutType,
        containedTile,
        shouldHideTileMetadata,
        shouldHideTileTitle,
        var31,
        nil,
        titleTextLines,
        if FFlagLuaAppNarrowTileHideRating then var7 or var8 elseif FFlagLuaAppNarrowTileHidePlayerCount then var7 or var8 else nil
    )

    local gameTileHiddenStore = getGameTileHiddenStore(tbl1.gameSortId)
    local var33 = SignalsReact.useSignalState(gameTileHiddenStore.getHiddenGames)
    local setGameHidden = gameTileHiddenStore.setGameHidden
    local var34 = if gameTileLayoutType == "Narrow" and not tbl1.playerCountStyle then GameTileConstants.PlayerCountStyleValues.Footer else tbl1.playerCountStyle
    local var35 = useRenderGameCollectionItem

    local isSponsoredFooterAllowed = tbl1.isSponsoredFooterAllowed

    local friendFooterEnabled = tbl1.friendFooterEnabled
    local bool1 = tbl1.pageContext == AppPage.Home
    local var36 = if tbl1.launchExperienceEventContextOverride then tbl1.launchExperienceEventContextOverride else DiscoveryAnalytics.Constants.Context.ExperienceTile
    local var37 = nil
    local var38 = nil
    local var39 = nil
    local gameSortId = if var13.isOmni then tbl1.gameSortId else nil
    local var40 = nil
    local var41 = nil
    local playButtonStyle = tbl1.playButtonStyle
    local onHoldableFocused = if var28 then var29.onHoldableFocused else nil
    local onHoldableUnfocused = if var28 then var29.onHoldableUnfocused else nil
    local shouldDisableHoldable = if var28 then var29.shouldDisableHoldable else nil
    local var42 = nil
    local var43 = nil

    local var44 = nil
    local selectionOrderBase = tbl1.selectionOrderBase
    local enableExplicitFeedback = tbl1.enableExplicitFeedback

    local pageContext = tbl1.pageContext
    local sponsoredUserCohort = tbl1.sponsoredUserCohort
    local enableSponsoredFeedback = tbl1.enableSponsoredFeedback
    local enableReportAd = tbl1.enableReportAd
    local enableReportExperience = if FFlagLuaAppEnableReportExperience then tbl1.enableReportExperience else nil
    local num5 = #items
    local isSponsoredRatingFooterAllowed = tbl1.isSponsoredRatingFooterAllowed
    local var45 = nil
    local var46 = nil
    local var47 = nil

    if not FFlagLuaAppNarrowTileHideRating then
        var7 = nil
    end

    if not FFlagLuaAppNarrowTileHidePlayerCount then
        var8 = nil
    end

    local renderItem = var35(
        var34,
        isSponsoredFooterAllowed,
        gameTileLayoutType,
        friendFooterEnabled,
        bool1,
        impressionsTag,
        var4,
        var19,
        reportExperienceLaunched,
        var36,
        var37,
        var38,
        var39,
        gameSortId,
        var40,
        var41,
        playButtonStyle,
        containedTile,
        shouldHideTileTitle,
        shouldHideTileMetadata,
        onHoldableFocused,
        onHoldableUnfocused,
        shouldDisableHoldable,
        var31,
        titleTextLines,
        var42,
        var43,
        var21,
        var44,
        selectionOrderBase,
        enableExplicitFeedback,
        var33,
        setGameHidden,
        pageContext,
        sponsoredUserCohort,
        enableSponsoredFeedback,
        enableReportAd,
        enableReportExperience,
        num5,
        isSponsoredRatingFooterAllowed,
        var45,
        var46,
        var47,
        var6,
        var7,
        var8,
        tbl1.videoPlaybackContext
    )

    if not FFlagLuaAppCompositionAlways then
        local var49 = React.useRef(0)
        React.useEffect(function()
            if var5 or var15.numColumns == var49.current then
                return
            end

            var49.current = var15.numColumns
            if tbl1.onItemsPerRowChanged then
                tbl1.onItemsPerRowChanged(var15.numColumns)
            end
        end, {
            var15.numColumns,
            tbl1.onItemsPerRowChanged,
            var49,
            var5
        })
    end

    if not var13.gameSortDataFound then
        return nil
    end

    local wrappedComponent = React.createElement(GameSortImpressionsDetector, {
        parentRef = parentRef,
        pageContext = tbl1.pageContext,
        impressionsTag = impressionsTag,
        scrollViewPositionChangedSignal = scrollViewPositionChangedSignal,
        sendGameImpressions = sendGameImpressions,
        dataUpdatedTimestamp = if var13.gameSortContents then var13.gameSortContents.updatedTimestamp or nil else nil
    })

    local createElement = React.createElement
    local fragment = React.Fragment
    local var49 = nil
    local tbl2 = { GameGrid = 0, GameSortImpressionsDetector = 0, HoldToPlayLauncher = 0 }
    local createElement2 = React.createElement
    local var50 = CollectionGrid
    local tbl3 = {
        collectionItemSize = 0,
        LayoutOrder = 0,
        ZIndex = 0,
        title = 0,
        subtitle = 0,
        onViewableItemsChanged = 0,
        containerRef = 0,
        tooltipInfoText = 0,
        hideHeaderButton = true,
        items = 0,
        onActivateInfoIcon = 0,
        verticalScrollingFrameRef = 0,
        renderItem = 0,
        getItemHeight = 0,
        numColumns = 0,
        columnGap = 0,
        sideMargin = 0,
        verticalPadding = 0,
        maxNumRows = 0,
        bufferRowsBelowScreen = 0,
        bufferRowsAboveScreen = 0,
        headerComponent = 0,
        headerTag = 0,
        testId = 0
    }

    if not var5 then
        gameTileCollectionItemSize = nil
    end

    tbl3.collectionItemSize = gameTileCollectionItemSize
    tbl3.LayoutOrder = if FFlagLuaAppRfyRevealRows then tbl1.LayoutOrder else nil
    tbl3.ZIndex = if FFlagLuaAppRfyRevealRows then tbl1.ZIndex else nil
    tbl3.title = tbl1.title
    tbl3.subtitle = if var13.sort then var13.sort.subtitle or nil else nil
    tbl3.onViewableItemsChanged = onViewableItemsChanged
    tbl3.containerRef = containerRef
    tbl3.tooltipInfoText = tooltipInfoText

    tbl3.items = items
    tbl3.onActivateInfoIcon = onActivateInfoIcon
    tbl3.verticalScrollingFrameRef = tbl1.verticalScrollingFrameRef
    tbl3.renderItem = renderItem
    tbl3.getItemHeight = getItemHeight
    tbl3.numColumns = if var5 then nil else var15.numColumns
    tbl3.columnGap = if var5 then nil else var15.columnGap
    tbl3.sideMargin = if var5 then nil else var15.sideMargin
    tbl3.verticalPadding = if var5 then nil else var15.verticalPadding
    tbl3.maxNumRows = tbl1.maxNumRows
    tbl3.bufferRowsBelowScreen = bufferRowsBelowScreen
    tbl3.bufferRowsAboveScreen = bufferRowsAboveScreen
    tbl3.headerComponent = tbl1.headerComponent
    tbl3.headerTag = if FFlagLuaAppSortHeaderAnchorTag then tbl1.headerTag else nil
    tbl3.testId = if tbl1.gameSortId then `--{tbl1.gameSortId}-game-collection-grid` else nil
    tbl2.GameGrid = createElement2(var50, tbl3)

    tbl2.GameSortImpressionsDetector = React.createElement(WaitForPropWrapper, {
        waitForProp = tbl1.startRow,
        maxUpdatesToDelay = tbl1.numUpdatesToDelayImpressions,
        wrappedComponent = wrappedComponent
    })
    local element2

    if var28 and var29.shouldRenderHoldToPlayLauncher then
        element2 = React.createElement(HoldToPlayLauncher, {
            selectedIndex = var29.selectedIndex,
            selectedEntry = var29.selectedEntry,
            selectedNavigationUniverseId = var29.selectedNavigationUniverseId,
            holdState = var29.holdState,
            holdProgress = var29.holdProgress,
            cancelHold = var29.cancelHold,
            launchContext = DiscoveryAnalytics.Constants.Context.HoldToPlayLauncher,
            referralSource = tbl1.pageContext,
            reportExperienceLaunched = reportExperienceLaunched
        })
    else
        element2 = nil
    end

    tbl2.HoldToPlayLauncher = element2
    return createElement(fragment, var49, tbl2)
end)
