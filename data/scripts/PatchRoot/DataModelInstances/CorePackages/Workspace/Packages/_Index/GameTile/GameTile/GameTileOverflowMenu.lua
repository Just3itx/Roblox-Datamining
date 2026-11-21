-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local GameTile = script:FindFirstAncestor("GameTile")
local GameTileParent = GameTile.Parent

local AppBlox = require(GameTileParent.AppBlox)
local CentralOverlay = require(GameTileParent.CentralOverlay)
local Foundation = require(GameTileParent.Foundation)
local Localization = require(GameTileParent.Localization)
local Loggers = require(GameTileParent.Loggers)
local React = require(GameTileParent.React)
local Responsive = require(GameTileParent.Responsive)
local RoactServiceTags = require(GameTileParent.RoactServiceTags)
local RoactUtils = require(GameTileParent.RoactUtils)
local RobloxAppEnums = require(GameTileParent.RobloxAppEnums)
local RobloxAppHooks = require(GameTileParent.RobloxAppHooks)
local SharedFlags = require(GameTileParent.SharedFlags)
local DiscoveryAnalytics = require(GameTileParent.DiscoveryAnalytics)
local Selectors = require(GameTileParent.NavigationRodux).Selectors

local getOverflowMenuSignalStore = AppBlox.getOverflowMenuSignalStore
local OverflowMenu = AppBlox.OverflowMenu
local CloseCentralOverlay = CentralOverlay.Thunks.CloseCentralOverlay
local SetCentralOverlay = CentralOverlay.Actions.SetCentralOverlay
local useTokens = Foundation.Hooks.useTokens
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local AbuseVector = require(GameTileParent.GenericAbuseReporting.AbuseVector)
local OpenDynamicAbuseReport = require(GameTileParent.GenericAbuseReporting.OpenDynamicAbuseReport)
local useLocalization = Localization.Hooks.useLocalization
local flaggedMutedError = Loggers.flaggedMutedError
local useLastInput = Responsive.useLastInput
local RoactNetworking = RoactServiceTags.RoactNetworking
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local CentralOverlayType = RobloxAppEnums.CentralOverlayType
local useRoactService = RobloxAppHooks.useRoactService
local gameTileOverflowMenuAction = DiscoveryAnalytics.Events.gameTileOverflowMenuAction

local activateGameNotInterested = require(GameTile.activateGameNotInterested)
local useGameTileActions = require(GameTile.useGameTileActions)
local useGameTileOverflowMenuFocusNavigation = require(GameTile.useGameTileOverflowMenuFocusNavigation)
local TileOverflowMenuItems = require(GameTile.GameTileConstants).TileOverflowMenuItems

local FFlagUseNavigationSelectors = SharedFlags.FFlagUseNavigationSelectors
local FFlagSignalsNavP3fGameDetails = SharedFlags.FFlagSignalsNavP3fGameDetails

local useSignalState = require(GameTileParent.SignalsReact).useSignalState
local GetLegacyNavigationStore = if FFlagSignalsNavP3fGameDetails then require(GameTileParent.NavigationRodux).GetLegacyNavigationStore else nil
local FFlagLuaAppEnableReportExperience = SharedFlags.FFlagLuaAppEnableReportExperience
local FFlagEnableNewReportFlowGameTile = SharedFlags.FFlagEnableNewReportFlowGameTile
local FFlagAddThumbnailSelectorReport = SharedFlags.FFlagAddThumbnailSelectorReport
local FFlagLuaAppContinueSortInstantPlay = SharedFlags.FFlagLuaAppContinueSortInstantPlay
local FFlagLuaAppFixExplicitFeedbackConsoleTelemetry = SharedFlags.FFlagLuaAppFixExplicitFeedbackConsoleTelemetry
local FFlagLuaAppEnableNxMRoduxApportioning = SharedFlags.FFlagLuaAppEnableNxMRoduxApportioning
local FFlagLuaAppGameTileNotInterestedDirectAction = SharedFlags.FFlagLuaAppGameTileNotInterestedDirectAction

return React.memo(function(tbl1) -- name: GameTileOverflowMenu
    if FFlagLuaAppGameTileNotInterestedDirectAction then
        local var1 = useTokens()
        local var2 = useLastInput()
        local menuKey = tbl1.menuKey
        local vector2 = Vector2.new(1, 0)
        local uDim2 = UDim2.new(1, -var1.Padding.Medium, 0, var1.Padding.Medium)
        local overflowMenuSignalStore = getOverflowMenuSignalStore()
        local collectionId = tbl1.collectionId or ""
        local tbl2 = {}
        for k, _ in tbl1.availableMenuItems do
            table.insert(tbl2, k)
        end
        local availableMenuItems = table.concat(tbl2, ",")

        local onMenuOpenChanged = React.useCallback(function(bool1: boolean)
            if tbl1.onMenuOpenChanged then
                tbl1.onMenuOpenChanged(bool1, availableMenuItems)
            end
        end, { tbl1.onMenuOpenChanged, availableMenuItems })

        local useCallback = React.useCallback
        local function func1(menuItem: string)
            local tbl3 = {
                universeId = tbl1.universeId,
                sortId = collectionId,
                actionType = "GameTileOverflowMenuItemActivated",
                menuItem = menuItem,
                availableMenuItems = availableMenuItems,
                contentType = if FFlagLuaAppEnableNxMRoduxApportioning then tbl1.contentType else nil
            }

            gameTileOverflowMenuAction(tbl3, tbl1.appPage)
        end

        local appPage = tbl1.appPage
        local universeId = tbl1.universeId
        local contentType = if FFlagLuaAppEnableNxMRoduxApportioning then tbl1.contentType else nil
        local var4 = useCallback(func1, { appPage, universeId, collectionId, availableMenuItems, contentType })
        local var5 = if FFlagLuaAppFixExplicitFeedbackConsoleTelemetry then nil else useGameTileOverflowMenuFocusNavigation(menuKey, tbl1.isSelected, tbl1.parentRef)
        local menuItems = useGameTileActions(tbl1, var4)

        if FFlagLuaAppFixExplicitFeedbackConsoleTelemetry then
            var5 = useGameTileOverflowMenuFocusNavigation(menuKey, tbl1.isSelected, tbl1.parentRef, onMenuOpenChanged)
        end

        local var7 = if FFlagSignalsNavP3fGameDetails then useSignalState(GetLegacyNavigationStore(false).getCurrentRouteKey) else useSelector(function(arg1)
            if FFlagUseNavigationSelectors then
                return Selectors.selectCurrentRoactNavigationRoute(arg1).key or ""
            end

            return arg1.Navigation.currentRoute.key or ""
        end)

        local var8 = React.useRef(var7)

        React.useEffect(function()
            if var7 ~= var8.current then
                overflowMenuSignalStore.closeMenu(menuKey)
            end
        end, { var7, menuKey, overflowMenuSignalStore.closeMenu })

        React.useEffect(function()
            local connection = if tbl1.menuOpen then UserInputService.InputBegan:Connect(function(input: InputObject, _: boolean)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and not tbl1.isHovered then
                    overflowMenuSignalStore.closeMenu(menuKey)
                end
            end) else nil

            return function()
                if connection then
                    connection:Disconnect()
                end
            end
        end, {
            tbl1.menuOpen,
            tbl1.isHovered,
            menuKey,
            overflowMenuSignalStore.closeMenu
        })
        return React.createElement(OverflowMenu, {
            anchorPoint = vector2,
            anchorPosition = uDim2,
            menuItems = menuItems,
            hasOverflowButton = var2 == Responsive.Input.Pointer,
            shouldShowAnchor = tbl1.isHovered,
            buttonIconBackgroundStyle = var1.Color.OverMedia.OverMedia_0,
            menuKey = menuKey,
            setFocusRef = var5,
            onMenuOpenChanged = onMenuOpenChanged,
            buttonIconSize = IconSize.Small
        })
    end

    local dispatch = useDispatch()
    local var2 = useTokens()
    local var3 = useLastInput()
    local networking = useRoactService(RoactNetworking)
    local localizedStrings = useLocalization({
        notInterested = "Feature.GameDetails.Action.NotInterested",
        whyThisAd = "Feature.GameDetails.Action.WhyThisAd",
        reportAd = "Feature.GameDetails.Action.ReportAd",
        gameDetails = if FFlagLuaAppContinueSortInstantPlay then "Feature.GameDetails.Action.GameDetails" else nil,
        reportExperience = if FFlagLuaAppEnableReportExperience then "Feature.GameDetails.Action.Report" else nil,
        dialogTitle = "Feature.GameDetails.Label.ProvideFeedbackTitle",
        dialogText = "Feature.GameDetails.Message.HelpImproveExperience",
        checkboxListTitle = "Feature.GameDetails.Message.HidingExperienceQuestion",
        tooRepetitive = "Feature.GameDetails.Label.TooRepetitive",
        dontLikeGame = "Feature.GameDetails.Label.DontLikeGame",
        dontLikeImage = "Feature.GameDetails.Label.DontLikeImage",
        inappropriateContent = "Feature.GameDetails.Label.InappropriateContent",
        somethingElse = "Feature.GameDetails.Label.SomethingElse"
    })

    local collectionId = tbl1.collectionId or ""
    local menuKey = tbl1.menuKey
    local vector2 = Vector2.new(1, 0)
    local uDim2 = UDim2.new(1, -var2.Padding.Medium, 0, var2.Padding.Medium)
    local overflowMenuSignalStore = getOverflowMenuSignalStore()
    local var6 = if FFlagLuaAppFixExplicitFeedbackConsoleTelemetry then nil else useGameTileOverflowMenuFocusNavigation(menuKey, tbl1.isSelected, tbl1.parentRef)
    local tbl2 = {}
    for k, _ in tbl1.availableMenuItems do
        table.insert(tbl2, k)
    end
    local availableMenuItems = table.concat(tbl2, ",")

    local onMenuOpenChanged = React.useCallback(function(bool1: boolean)
        if tbl1.onMenuOpenChanged then
            tbl1.onMenuOpenChanged(bool1, availableMenuItems)
        end
    end, { tbl1.onMenuOpenChanged, availableMenuItems })

    local useCallback = React.useCallback
    local function func1(menuItem: string)
        local tbl3 = {
            universeId = tbl1.universeId,
            sortId = collectionId,
            actionType = "GameTileOverflowMenuItemActivated",
            menuItem = menuItem,
            availableMenuItems = availableMenuItems,
            contentType = if FFlagLuaAppEnableNxMRoduxApportioning then tbl1.contentType else nil
        }

        gameTileOverflowMenuAction(tbl3, tbl1.appPage)
    end

    local appPage = tbl1.appPage
    local universeId = tbl1.universeId
    local contentType = if FFlagLuaAppEnableNxMRoduxApportioning then tbl1.contentType else nil
    local var8 = useCallback(func1, { appPage, universeId, collectionId, availableMenuItems, contentType })

    if FFlagLuaAppFixExplicitFeedbackConsoleTelemetry then
        var6 = useGameTileOverflowMenuFocusNavigation(menuKey, tbl1.isSelected, tbl1.parentRef, onMenuOpenChanged)
    end

    local onActivated = if FFlagLuaAppContinueSortInstantPlay then React.useCallback(function()
        if tbl1.onGameDetailsActivated then
            tbl1.onGameDetailsActivated()
        end

        var8(TileOverflowMenuItems.GameDetails)
    end, { tbl1.onGameDetailsActivated, var8 }) else nil

    local var1 = React.useCallback(function()
        if activateGameNotInterested({
            appPage = tbl1.appPage,
            collectionId = collectionId,
            dispatch = dispatch,
            isSponsored = tbl1.isSponsored,
            localizedStrings = localizedStrings,
            networking = networking,
            placeId = tbl1.placeId,
            setGameHidden = tbl1.setGameHidden,
            universeId = tbl1.universeId
        }) then
            var8(TileOverflowMenuItems.NotInterested)
        end
    end, {
        collectionId,
        dispatch,
        localizedStrings,
        networking,
        var8,
        tbl1.appPage,
        tbl1.isSponsored,
        tbl1.placeId,
        tbl1.setGameHidden,
        tbl1.universeId
    })

    local useCallback2 = React.useCallback
    local function func2()
        dispatch(
            SetCentralOverlay(CentralOverlayType.WhyThisAdModal, {
                universeId = tbl1.universeId,
                payerName = tbl1.payerName,
                sponsoredUserCohort = tbl1.sponsoredUserCohort,
                contentType = if FFlagLuaAppEnableNxMRoduxApportioning then tbl1.contentType else nil
            })
        )
        var8(TileOverflowMenuItems.WhyThisAd)
    end

    local universeId2 = tbl1.universeId
    local payerName = tbl1.payerName
    local sponsoredUserCohort = tbl1.sponsoredUserCohort
    local contentType2 = if FFlagLuaAppEnableNxMRoduxApportioning then tbl1.contentType else nil
    local var4 = useCallback2(func2, { dispatch, universeId2, payerName, sponsoredUserCohort, contentType2, var8 })

    local var5 = React.useCallback(function()
        if not tbl1.adId then
            flaggedMutedError("ReportSponsoredAdError", "Report ad clicked without valid target ad id")
            return
        end

        dispatch(OpenDynamicAbuseReport({
            abuseVector = AbuseVector.AdV2,
            targetId = tbl1.adId,
            onClose = function()
                dispatch(CloseCentralOverlay())
            end
        }))

        var8(TileOverflowMenuItems.ReportAd)
    end, { dispatch, tbl1.adId, var8 })

    local var7 = if FFlagLuaAppEnableReportExperience then React.useCallback(function()
        if not tbl1.placeId then
            flaggedMutedError("ReportExperienceError", "Report experience clicked without valid target place id")

            return
        end

        local var13 = dispatch
        local var14 = OpenDynamicAbuseReport
        local tbl3 = {
            abuseVector = if FFlagEnableNewReportFlowGameTile then AbuseVector.GameTile else AbuseVector.Place,
            targetId = tbl1.placeId,
            custom = FFlagAddThumbnailSelectorReport and {
                universeId = tbl1.universeId
            } or nil,
            onClose = 0
        }

        function tbl3.onClose()
            dispatch(CloseCentralOverlay())
        end

        var13(var14(tbl3))

        var8(TileOverflowMenuItems.ReportExperience)
    end, {
        dispatch,
        tbl1.placeId,
        tbl1.universeId,
        var8
    }) else nil

    local useMemo = React.useMemo
    local function func3()
        local result = {}

        if FFlagLuaAppContinueSortInstantPlay and tbl1.availableMenuItems[TileOverflowMenuItems.GameDetails] then
            table.insert(result, {
                icon = "icons/actions/info",
                id = TileOverflowMenuItems.GameDetails,
                text = localizedStrings.gameDetails,
                onActivated = onActivated
            })
        end

        if tbl1.availableMenuItems[TileOverflowMenuItems.NotInterested] then
            table.insert(result, {
                icon = "icons/actions/block",
                id = TileOverflowMenuItems.NotInterested,
                text = localizedStrings.notInterested,
                onActivated = var1
            })
        end

        if tbl1.availableMenuItems[TileOverflowMenuItems.WhyThisAd] then
            table.insert(result, {
                icon = "icons/actions/info",
                id = TileOverflowMenuItems.WhyThisAd,
                text = localizedStrings.whyThisAd,
                onActivated = var4
            })
        end

        if tbl1.availableMenuItems[TileOverflowMenuItems.ReportAd] then
            table.insert(
                result,
                {
                    icon = IconName.Flag,
                    id = TileOverflowMenuItems.ReportAd,
                    text = localizedStrings.reportAd,
                    onActivated = var5
                }
            )
        end

        if FFlagLuaAppEnableReportExperience and tbl1.availableMenuItems[TileOverflowMenuItems.ReportExperience] then
            table.insert(result, {
                icon = IconName.Flag,
                id = TileOverflowMenuItems.ReportExperience,
                text = localizedStrings.reportExperience,
                onActivated = var7
            })
        end

        return result
    end

    local var14 = if FFlagLuaAppContinueSortInstantPlay then onActivated else nil
    local var15 = if FFlagLuaAppEnableReportExperience then var5 or nil else nil
    local var16 = if FFlagLuaAppEnableReportExperience then var7 or nil else nil
    local menuItems = useMemo(func3, { var14, var1, localizedStrings, var4, var15, var16, tbl1.isSponsored, tbl1.availableMenuItems })

    local var18 = if FFlagSignalsNavP3fGameDetails then useSignalState(GetLegacyNavigationStore(false).getCurrentRouteKey) else useSelector(function(arg1)
        if FFlagUseNavigationSelectors then
            return Selectors.selectCurrentRoactNavigationRoute(arg1).key or ""
        end

        return arg1.Navigation.currentRoute.key or ""
    end)

    local var19 = React.useRef(var18)

    React.useEffect(function()
        if var18 ~= var19.current then
            overflowMenuSignalStore.closeMenu(menuKey)
        end
    end, { var18, menuKey })

    React.useEffect(function()
        local connection = if tbl1.menuOpen then UserInputService.InputBegan:Connect(function(input: InputObject, _: boolean)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and not tbl1.isHovered then
                overflowMenuSignalStore.closeMenu(menuKey)
            end
        end) else nil

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, { tbl1.menuOpen, tbl1.isHovered, menuKey })

    return React.createElement(OverflowMenu, {
        anchorPoint = vector2,
        anchorPosition = uDim2,
        menuItems = menuItems,
        hasOverflowButton = var3 == Responsive.Input.Pointer,
        shouldShowAnchor = tbl1.isHovered,
        buttonIconBackgroundStyle = var2.Color.OverMedia.OverMedia_0,
        menuKey = menuKey,
        setFocusRef = var6,
        onMenuOpenChanged = onMenuOpenChanged,
        buttonIconSize = IconSize.Small
    })
end)
