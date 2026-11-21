-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local dependencies = require(FriendsLanding.dependencies)
local FriendsLandingParent = FriendsLanding.Parent
local React = require(FriendsLandingParent.React)
local Roact = require(FriendsLandingParent.Roact)
local UIBlox = dependencies.UIBlox
local useNavigation = require(FriendsLandingParent.Navigation).useNavigation
local useDesignTokens = require(FriendsLandingParent.Style).useDesignTokens
local useTokens = require(FriendsLandingParent.Foundation).Hooks.useTokens
local useUiModeInfo = require(FriendsLandingParent.RobloxAppHooks).useUiModeInfo
local useScreenSize = require(FriendsLandingParent.RobloxAppHooks).useScreenSize
local UiMode = require(FriendsLandingParent.RobloxAppEnums).UiMode
local FocusNavigationUtils = require(FriendsLandingParent.FocusNavigationUtils)
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local ReactFocusNavigation = require(FriendsLandingParent.ReactFocusNavigation)
local InputHandlers = require(FriendsLandingParent.InputHandlers)
local _PlayerContextualMenu = require(FriendsLandingParent.PlayerContextualMenu)
local dependencyArray = require(FriendsLandingParent.RoactUtils).Hooks.dependencyArray
local useLocalization = require(FriendsLandingParent.Localization).Hooks.useLocalization
local CollectionGrid = require(FriendsLandingParent.CollectionViews).CollectionGrid
local HorizontalPageMargin = UIBlox.App.Container.HorizontalPageMargin
local getPageMargin = UIBlox.App.Container.getPageMargin

local convertUserPresenceTypeToString = require(FriendsLandingParent.SocialCommon).Utils.convertUserPresenceTypeToString

local useFocusGuiObject = dependencies.useFocusGuiObject
local FriendsLandingContext = require(FriendsLanding.FriendsLandingContext)

local FriendsLandingAnalytics = require(FriendsLanding.FriendsLandingAnalytics)

local RefreshScrollingFrame = dependencies.SocialLibraries.Components.RefreshScrollingFrame

local GridMetrics = UIBlox.App.Grid.GridMetrics

local EnumScreens = require(FriendsLanding.EnumScreens)
local filterStates = require(FriendsLanding.Friends.filterStates)
local ButtonClickEvents = require(FriendsLanding.FriendsLandingAnalytics.ButtonClickEvents)
local Constants = require(FriendsLanding.Common.Constants)
local useAnimatedScrollToSelection = require(FriendsLandingParent.RobloxAppHooks).useAnimatedScrollToSelection
local useSignalState = require(FriendsLandingParent.SignalsReact).useSignalState
local Display = require(FriendsLandingParent.Display)
local useFocusOnMount = require(FriendsLandingParent.FocusNavigationUtils).useFocusOnMount

local FilterByButton = require(FriendsLanding.Components.FilterByButton)
local FriendTile = require(FriendsLanding.Components.FriendTile)
local EmptyResultsView = require(FriendsLanding.Components.EmptyResultsView)
local NoFriendsView = require(FriendsLanding.Components.NoFriendsView)
local isFromConnectionsHub = require(FriendsLanding.Navigator.isFromConnectionsHub)

local AmpApiProvider = require(FriendsLandingParent.AmpUpsell).AmpApiProvider
local AccessResponseEnum = require(FriendsLandingParent.AmpUpsell).AmpEnums.AccessResponseEnum

local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local useTextSizeOffset = UIBlox.Core.Style.useTextSizeOffset

local AppPage = require(FriendsLandingParent.RobloxAppEnums).AppPage

local UserList = require(FriendsLandingParent.UserList)
local UserListLayoutAdaptor = UserList.UserListLayoutAdaptor
local LayoutMode = UserList.Enums.LayoutMode

local function onFewestInteractionsSelection() end
local FFlagFixScalingOnFriendsLanding = require(FriendsLanding.Flags.FFlagFixScalingOnFriendsLanding)
local FFlagFriendsPageUserListCtaEnabled = require(FriendsLanding.Flags.FFlagFriendsPageUserListCtaEnabled)
local FriendsLandingCtaConfig = if FFlagFriendsPageUserListCtaEnabled then require(FriendsLanding.Common.FriendsLandingCtaConfig) else nil

local FFlagConnectionManagementChips = require(FriendsLandingParent.SharedFlags).FFlagConnectionManagementChips
local FFlagCreateConnectionsHub = require(FriendsLandingParent.SharedFlags).FFlagCreateConnectionsHub

local FFlagAppThemeHalloween2026FriendsBackground = require(FriendsLandingParent.SharedFlags).FFlagAppThemeHalloween2026FriendsBackground
local useThemeBackground = require(FriendsLandingParent.ThemeBackground).useThemeBackground
local FFlagFixFriendsListGapInConnectionsHub = require(FriendsLanding.Flags.FFlagFixFriendsListGapInConnectionsHub)
local FFlagFriendsPageAlwaysOpenPPV = require(FriendsLandingParent.SharedFlags).FFlagFriendsPageAlwaysOpenPPV
local FFlagFriendsPageUserListEnabled = require(FriendsLandingParent.SharedFlags).FFlagFriendsPageUserListEnabled
local FFlagExtendScrollingFramesBySafeInsets = require(FriendsLandingParent.SharedFlags).FFlagExtendScrollingFramesBySafeInsets
local FStringIsUserInTcEligibleCountryAmpFeature = require(FriendsLandingParent.SharedFlags).FStringIsUserInTcEligibleCountryAmpFeature
local FStringCanAccessTrustedContactsAmpNameSpace = require(FriendsLandingParent.SharedFlags).FStringCanAccessTrustedContactsAmpNameSpace
local bool1 = game:DefineFastFlag("FixFriendsLandingRightMargin", false)

local function FriendsLandingPage(tbl1)
    local var1 = useLocalization({
        pageError = "CommonUI.Messages.Response.PageError",
        successText = "Feature.Friends.Action.FriendRemoved",
        errorText = "Feature.Toast.NetworkingError.SomethingIsWrong",
        friends = "CommonUI.Features.Label.Friends",
        showMore = "Feature.Friends.Action.ViewMore"
    })

    local var2 = React.useContext(FriendsLandingContext.Context)
    local analytics = React.useContext(FriendsLandingAnalytics.Context)
    local var4 = useNavigation()

    local var5 = useDesignTokens()
    local var6 = useUiModeInfo()
    local var7 = if FFlagFixScalingOnFriendsLanding then useTokens() else nil
    local focusGuiObject = useFocusGuiObject()

    local pageMargin = getPageMargin(useScreenSize().X)
    local bool2 = var6.uiMode == UiMode.TenFoot

    local bool3 = FocusNavigationUtils.useLastInputMode() == "Cursor"
    local var9 = InputHandlers.onRelease(function(arg1)
        arg1:cancel()
        var4.navigate(AppPage.UserSearch, { shouldShowUserSearchLandingPage = true })
    end)

    local var10 = ReactFocusNavigation.useEventHandler(FocusNavigationEventNameEnum.Search, var9)
    local var11 = if bool2 then var5.Size.Size_1600 else var5.Size.Size_2000
    local var12 = useTextSizeOffset()
    local var13 = var11 + var12 * 3

    local var14 = nil
    local var15 = nil
    if FFlagConnectionManagementChips then
        local var16
        var14, var16 = React.useState(false)
        var15 = var16
    end

    React.useEffect(function()
        analytics:pageMountingTimeReport()
        if FFlagConnectionManagementChips
            and AmpApiProvider.upsellFeatureAccess(
                FStringIsUserInTcEligibleCountryAmpFeature,
                {},
                FStringCanAccessTrustedContactsAmpNameSpace
            ).access == AccessResponseEnum.Granted
        then
            var15(true)
        end
    end, {})

    local var16 = if FFlagFriendsPageAlwaysOpenPPV then nil else React.useCallback(function(arg1)
        return function()
            var2.openPlayerContextualMenu({
                subjectUserId = arg1.id,
                robloxFriendshipStatus = Enum.FriendStatus.Friend,
                subjectPresence = {
                    locationString = arg1.lastLocation,
                    locationPlaceId = arg1.placeId,
                    locationRootPlaceId = arg1.rootPlaceId,
                    locationUniverseId = arg1.universeId,
                    status = convertUserPresenceTypeToString(arg1.userPresenceType)
                },
                friendshipOriginSourceType = nil
            })
        end
    end, { var2.openPlayerContextualMenu })

    local openPlayerProfileHandle = React.useCallback(function(friendId, num1: number, arg1)
        if not FFlagFriendsPageAlwaysOpenPPV and bool2 and var16 then
            return var16(arg1)()
        end

        analytics:navigate(EnumScreens.ViewUserProfile)
        analytics:buttonClick(
            ButtonClickEvents.PlayerTile,
            {
                friendId = friendId,
                position = num1 - 1,
                subpage = "peekView",
                page = "playerProfile"
            }
        )

        var2.openProfilePeekView(friendId, { source = Constants.FriendsLandingPageSourceName })
    end, { analytics, var16, bool2 })

    local function pageLoadingTimeReport()
        analytics:pageLoadingTimeReport()
    end

    local renderItem = React.useCallback(function(user, selectedItemIndex)
        return React.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                LayoutOrder = selectedItemIndex
            },
            {
                tile = React.createElement(FriendTile, {
                    user = user,
                    index = selectedItemIndex,
                    openPlayerProfileHandle = openPlayerProfileHandle,
                    pageLoadingTimeReport = pageLoadingTimeReport,
                    selected = selectedItemIndex == tbl1.selectedItemIndex,
                    focusGuiObject = focusGuiObject
                })
            }
        ), "FriendTile"
    end, { tbl1.selectedItemIndex, bool2, openPlayerProfileHandle })

    local getItemHeight = React.useCallback(function(num1: number): number
        return num1 + var13
    end, dependencyArray(var13, var12))

    local var20 = React.useCallback(function()
        analytics:buttonClick(ButtonClickEvents.FriendFilterPill)
        var4.navigate(
            EnumScreens.FilterByModal,
            {
                onFewestInteractionsSelection = onFewestInteractionsSelection,
                friendCount = tbl1.totalFriendCount
            }
        )
    end, dependencyArray(var4, analytics))

    local var21 = if FFlagConnectionManagementChips then React.useCallback(function(str1: string)
        analytics:buttonClick(ButtonClickEvents.FriendFilterPill)
        var2.setFilterKeys(str1)
    end, dependencyArray(analytics, var2.setFilterKeys)) else nil

    local refresh = React.useCallback(function()
        analytics:pageLoaded()
        var2.setFilterKeys(filterStates.All)

        return var2.refreshPage({
            errorMessage = var1.pageError,
            onResolve = function()
                analytics:pageLoadedWithArgs()
            end
        })
    end, dependencyArray(var2.refreshPage, var1, analytics, var2.setFilterKeys))

    local openAddFriendsPage = React.useCallback(function()
        analytics:buttonClick(ButtonClickEvents.AddFriendsNoFriendsEmptyView)
        analytics:navigate(EnumScreens.AddFriends)
        if FFlagCreateConnectionsHub then
            var4.navigate(AppPage.CoHubAddConnections)
            return
        end
        var4.navigate(AppPage.AddFriendsPage)
    end, dependencyArray(analytics, var4))

    local friendsLen = tbl1.friends and #tbl1.friends or 0
    local totalFriendCount = tbl1.totalFriendCount or 0
    local bool4 = totalFriendCount == 0
    local bool5 = friendsLen == 0 and totalFriendCount > 0
    local hasMore = tbl1.fetchMoreFriends and not (bool4 or bool5) and (not var2.filter or var2.filter == filterStates.All)

    local var25 = React.useCallback(function()
        if tbl1.fetchMoreFriends then
            tbl1.fetchMoreFriends()
        end
    end, { tbl1.fetchMoreFriends })

    local verticalPadding = if bool2 then 24 else 12
    local var26, var27 = React.useState(100)
    local tbl2, num2

    if bool2 then
        tbl2 = var5.LuaApps.FriendsLanding.FriendsLandingPage.GridViewItemMetrics
        num2 = var5.LuaApps.FriendsLanding.FriendsLandingPage.GridHorizontalSpacing
    else
        tbl2 = {
            minimumItemsPerRow = 2,
            minimumItemWidth = if FFlagFixScalingOnFriendsLanding then 176 * var7.Config.UI.Scale else 176
        }

        num2 = 12
    end

    local var28 = React.useMemo(function()
        return GridMetrics.makeCustomMetricsGetter(tbl2)
    end, { tbl2 })

    local var29 = React.useMemo(function()
        return var28(var26, num2)
    end, { var28 })

    local onContainerSizeChanged = React.useCallback(function(vector2: Vector2)
        var27(vector2.X)
    end, {})

    local verticalScrollingFrameRef = React.useRef({})
    local scrollAnimationConfig = var5.LuaApps.App.Page.ScrollAnimationConfig

    local canvasPosition, var33 = useAnimatedScrollToSelection(Enum.ScrollingDirection.Y, 0, var5.Size.Size_2000, scrollAnimationConfig)

    local num3 = bool2 and (if bool4 then 8 elseif bool5 then 8 elseif bool3 then 8 else 1000) or 8
    local var34 = if FFlagExtendScrollingFramesBySafeInsets then useSignalState(Display.GetDisplayStore().getDeviceSafePadding) else nil
    local yOffset = num3 + (if FFlagExtendScrollingFramesBySafeInsets then var34.bottom else 0)

    local var35 = FFlagCreateConnectionsHub and isFromConnectionsHub(var4)
    local bool6 = if FFlagAppThemeHalloween2026FriendsBackground then useThemeBackground() ~= nil else false
    local yOffset2 = -(if FFlagFixFriendsListGapInConnectionsHub then 0 else Constants.TOP_BAR_HEIGHT) + (if FFlagExtendScrollingFramesBySafeInsets then var34.bottom else 0)

    local containerRef = useFocusOnMount()

    local renderRow = if FFlagFriendsPageUserListEnabled then React.useCallback(function(createRow, user, index)
        return React.createElement(FriendTile, {
            user = user,
            createRow = createRow,
            index = index,
            openPlayerProfileHandle = openPlayerProfileHandle,
            pageLoadingTimeReport = pageLoadingTimeReport
        })
    end, { pageLoadingTimeReport, openPlayerProfileHandle }) else nil

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        [Roact.Ref] = var10,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = if var35 then nil else var5.LuaApps.App.Page.BackgroundColor,
        BackgroundTransparency = if var35 then 1 elseif bool6 then 1 else var5.LuaApps.App.Page.BackgroundTransparency
    }
    local tbl4 = { HorizontalPageMargin = 0 }
    local createElement2 = React.createElement
    local var38 = HorizontalPageMargin
    local tbl5 = {
        Size = UDim2.fromScale(1, 1),
        backgroundTransparency = 1
    }
    local tbl6 = {
        Padding = React.createElement(
            "UIPadding",
            {
                PaddingLeft = UDim.new(0, pageMargin),
                PaddingRight = if bool1 then UDim.new(0, pageMargin) else nil
            }
        ),
        scrollView = 0
    }
    local createElement3 = React.createElement
    local var39 = RefreshScrollingFrame
    local tbl7 = {
        scrollingElementProps = {
            Size = UDim2.new(1, 0, 1, yOffset2),
            BackgroundTransparency = 1,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            ScrollBarThickness = 0,
            CanvasSize = UDim2.new(1, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.XY,
            CanvasPosition = canvasPosition,
            [Roact.Event.SelectionChanged] = var33,
            Selectable = false
        },
        [Roact.Ref] = verticalScrollingFrameRef,
        refresh = refresh,
        usesBuilderIcon = true
    }
    local tbl8 = {
        UISizeConstraint = if FFlagFriendsPageUserListEnabled then React.createElement("UISizeConstraint", { MaxSize = Vector2.new(640, math.huge) }) else nil,
        layout = React.createElement(
            "UIListLayout",
            {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical
            }
        ),
        pulldownSpacing = React.createElement("Frame", { Size = UDim2.new(1, 0, 0, 1), LayoutOrder = 0, BackgroundTransparency = 1 }) or nil,
        filterByButton = 0,
        NoResultsView = 0,
        NoFriendsView = 0,
        UserListLayoutAdaptor = 0,
        FriendsGridView = 0,
        showMoreFrame = 0,
        additionalPadding = 0
    }

    local createElement4 = React.createElement
    local var40 = FilterByButton
    local tbl9 = {
        analytics = analytics,
        filter = var2.filter,
        friendCount = 0,
        isDisabled = 0,
        layoutOrder = 2,
        onActivated = 0,
        maxWidth = 0,
        canAccessTrustedContacts = 0
    }

    if var2.filter == filterStates.All then
        friendsLen = totalFriendCount
    end

    tbl9.friendCount = friendsLen
    tbl9.isDisabled = totalFriendCount == 0

    if not FFlagConnectionManagementChips then
        var21 = var20
    end

    tbl9.onActivated = var21

    tbl9.maxWidth = if FFlagConnectionManagementChips then 640 else nil
    if not FFlagConnectionManagementChips then
        var14 = nil
    end

    tbl9.canAccessTrustedContacts = var14
    tbl8.filterByButton = createElement4(var40, tbl9)

    tbl8.NoResultsView = if bool5 then React.createElement(EmptyResultsView, { layoutOrder = 6 }) else nil

    tbl8.NoFriendsView = if bool4 then React.createElement(
        NoFriendsView,
        {
            layoutOrder = 6,
            pageLoadingTimeReport = pageLoadingTimeReport,
            openAddFriendsPage = openAddFriendsPage
        }
    ) else nil
    local element = if FFlagFriendsPageUserListEnabled and not (bool5 or bool4) then React.createElement(
        UserListLayoutAdaptor,
        {
            layoutOrder = 6,
            layoutMode = LayoutMode.Vertical,
            header = {
                title = var1.peopleYouMayKnow
            },
            entities = tbl1.friends,
            isScrollEnabled = false,
            renderRow = renderRow,
            ctaConfig = if FFlagFriendsPageUserListCtaEnabled then FriendsLandingCtaConfig else nil,
            hasMore = hasMore,
            onLoadMore = var25
        }
    ) else nil
    tbl8.UserListLayoutAdaptor = element

    tbl8.FriendsGridView = if FFlagFriendsPageUserListEnabled or bool5 or bool4 then nil else React.createElement(
        CollectionGrid,
        {
            containerRef = containerRef,
            LayoutOrder = 6,
            items = tbl1.friends,
            verticalScrollingFrameRef = verticalScrollingFrameRef,
            renderItem = renderItem,
            getItemHeight = getItemHeight,
            numColumns = var29.itemsPerRow,
            columnGap = num2,
            verticalPadding = verticalPadding,
            onContainerSizeChanged = onContainerSizeChanged
        }
    )
    local element2

    if FFlagFriendsPageUserListEnabled or not hasMore then
        element2 = nil
    else
        element2 = React.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, Constants.CTA_BUTTON_HEIGHT),
                BackgroundTransparency = 1,
                LayoutOrder = 7
            },
            {
                UIPadding = React.createElement(
                    "UIPadding",
                    {
                        PaddingLeft = UDim.new(0, 2),
                        PaddingRight = UDim.new(0, 2),
                        PaddingTop = UDim.new(0, 10)
                    }
                ),
                showMoreButton = React.createElement(
                    Button,
                    {
                        buttonType = ButtonType.Secondary,
                        size = UDim2.new(1, 0, 1, 0),
                        onActivated = var25,
                        text = var1.showMore
                    }
                )
            }
        )
    end

    tbl8.showMoreFrame = element2

    tbl8.additionalPadding = React.createElement("Frame", { Size = UDim2.new(1, 0, 0, yOffset), BackgroundTransparency = 1, LayoutOrder = 8 })
    tbl6.scrollView = createElement3(var39, tbl7, tbl8)
    tbl4.HorizontalPageMargin = createElement2(var38, tbl5, tbl6)
    return createElement(str1, tbl3, tbl4)
end

return FriendsLandingPage
