-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local Foundation = require(ProfilePlatformParent.Foundation)
local UIBlox = require(ProfilePlatformParent.UIBlox)
local AppBlox = require(ProfilePlatformParent.AppBlox)
local InputUi = require(ProfilePlatformParent.InputUi)
local Navigation = require(ProfilePlatformParent.Navigation)
local NavigationRodux = require(ProfilePlatformParent.NavigationRodux)
local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local RobloxAppHooks = require(ProfilePlatformParent.RobloxAppHooks)
local Localization = require(ProfilePlatformParent.Localization)
local MomentsCommon = require(ProfilePlatformParent.MomentsCommon)
local SharedFlags = require(ProfilePlatformParent.SharedFlags)
local useAppPolicy = require(ProfilePlatformParent.UniversalAppPolicy).useAppPolicy
local useLocalization = Localization.Hooks.useLocalization

local TextKeys = require(ProfilePlatform.Common.TextKeys)

local Analytics = MomentsCommon.Analytics
local fireAnalyticsEvent = Analytics.fireAnalyticsEvent
local EventNames = Analytics.EventNames
local makeProfileTileFields = require(ProfilePlatform.Analytics.makeProfileTileFields)

local MomentGridItem = require(script.Parent.MomentGridItem)
local MomentsCarouselMediaProvider = require(script.Parent.MomentsCarouselMediaProvider)
local _MomentsStoreTypes = require(ProfilePlatformParent.DataHydration.MomentsStoreTypes)
local Constants = require(ProfilePlatform.Common.Constants)
local Enums = require(ProfilePlatform.Common.Enums)
local ProfileModalView = require(ProfilePlatform.Components.ProfilePlatformViewAdaptor.ProfileModalView)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useUserMoments = require(ProfilePlatform.Hooks.useUserMoments)
local useProfileFormFactor = require(ProfilePlatform.Hooks.useProfileFormFactor)
local useProfileCardWidth = require(ProfilePlatform.Hooks.useProfileCardWidth)
local useProfileCardWidth2 = require(ProfilePlatformParent.ProfilePlatformCommon).Hooks.useProfileCardWidth

local UserProfiles = require(ProfilePlatformParent.UserProfiles)
local useUserProfilesFetch = UserProfiles.Hooks.useUserProfilesFetch
local UserTile = require(ProfilePlatformParent.UserTile).UserTile
local LayoutMode = require(ProfilePlatformParent.UserTile).LayoutMode

local FullscreenPageWithSafeArea = AppBlox.FullscreenPageWithSafeArea
local ScrollingGridView = MomentsCommon.ScrollingGridView
local useNavigation = Navigation.useNavigation
local useNavigationFocus = Navigation.useNavigationFocus
local useStyle = UIBlox.Core.Style.useStyle
local useScreenSize = RobloxAppHooks.useScreenSize
local useStatusBarHeight = MomentsCommon.Hooks.useStatusBarHeight
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local NavigateDown = NavigationRodux.Thunks.NavigateDown
local getSafeAreaSize = InputUi.getSafeAreaSize

local FFlagProfilePlatformNewProfileHeader = SharedFlags.FFlagProfilePlatformNewProfileHeader
local FFlagSwitchProfileWidthHookToSocialCommon = SharedFlags.FFlagSwitchProfileWidthHookToSocialCommon
local FFlagMomentsOptimisticProfilePending = SharedFlags.FFlagMomentsOptimisticProfilePending
local isPlayableVideoMoment = require(script.Parent.isPlayableVideoMoment)
local FFlagAXEnableProfileTab = SharedFlags.FFlagAXEnableProfileTab
local FFlagSignalsNavP3Dispatch = SharedFlags.FFlagSignalsNavP3Dispatch
local FFlagProfileMomentsFeedRootRoute = SharedFlags.FFlagProfileMomentsFeedRootRoute
local FFlagEnableArgus = SharedFlags.FFlagEnableArgus
local FFlagEnableArgusImmersiveNav = SharedFlags.FFlagEnableArgusImmersiveNav
local FFlagProfileRenderAvatarMoments = SharedFlags.FFlagProfileRenderAvatarMoments
local FFlagProfileMomentSceneOutfitPoster = SharedFlags.FFlagProfileMomentSceneOutfitPoster
local FFlagProfileMomentsLoadFailureAnalytics = require(ProfilePlatform.Flags.FFlagProfileMomentsLoadFailureAnalytics)
local bool1 = game:DefineFastFlag("ProfileMomentsGridMeTabTopInset", false)
local var1 = FFlagProfileMomentsFeedRootRoute
    and FFlagEnableArgus
    and FFlagEnableArgusImmersiveNav
    and FFlagProfileRenderAvatarMoments
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ProfilePlatformParent.RobloxAppNavigation).NavigationCommands else nil
local var2 = FFlagProfileMomentsFeedRootRoute or FFlagProfileRenderAvatarMoments

local View = Foundation.View
local IconButton = Foundation.IconButton
local ButtonSize = Foundation.Enums.ButtonSize
local IconName = Foundation.Enums.IconName
local useTokens = Foundation.Hooks.useTokens

local ChevronLargeLeft = IconName.ChevronLargeLeft

local var3 = table.freeze({})

local function MomentsGridPage()
    local var4 = useNavigation()
    local var5 = if var2 then useDispatch() else nil

    local param = var4.getParam("extraProps")
    local theme = useStyle().Theme
    local var6 = useTokens()
    local bool2 = useProfileFormFactor().formFactor == Enums.ProfileFormFactor.Wide
    local var7 = if FFlagAXEnableProfileTab then useProfileWrapperContext() else nil
    local bool3 = if FFlagAXEnableProfileTab then var7.forceFullView == true else nil
    local var8 = useScreenSize()
    local var9 = useSelector(function(arg1)
        return arg1.GlobalGuiInset
    end)
    local safeAreaSize = getSafeAreaSize(var8, var9)
    local var10 = if bool1 then useStatusBarHeight() else 0
    local var11 = if FFlagProfilePlatformNewProfileHeader then if FFlagSwitchProfileWidthHookToSocialCommon then useProfileCardWidth2() else useProfileCardWidth(bool2) else math.min(safeAreaSize.X.Offset, Constants.MAXIMUM_CONTAINER_WIDTH)
    local profileId = if param then param.profileId else nil

    local userIds = React.useMemo(function(): {[any]: any} | {any}
        return if profileId == nil then {} else { profileId }
    end, { profileId })
    local var13 = useUserProfilesFetch(
        {
            userIds = userIds,
            query = UserProfiles.Queries.userProfilesCombinedNameUsernameAndIsVerifiedByUserIds
        }
    )
    local title = if var13.data == nil or profileId == nil then nil else UserProfiles.Selectors.getCombinedNameFromId(var13.data, profileId)
    local usernameFromId = if var13.data == nil or profileId == nil then nil else UserProfiles.Selectors.getUsernameFromId(var13.data, profileId)
    local var14 = useUserMoments(profileId)
    local moments = var14.moments
    local hasMore = var14.hasMore
    local loadMore = var14.loadMore

    local var15 = useLocalization({ feedEndTitle = TextKeys.MomentsFeedEndTitle })
    local var16 = useAppPolicy(function(arg1)
        return arg1.getEnableContinuousLoad()
    end)

    local activeIndex, var18 = React.useState(nil)
    local var19 = if FFlagMomentsOptimisticProfilePending then React.useRef(nil) else nil

    local var20 = React.useRef(false)
    React.useEffect(function()
        if var20.current or not (#moments > 0) or profileId == nil then
            return
        end

        var20.current = true
        fireAnalyticsEvent(EventNames.ProfileScreenImpression, { userId = profileId, momentsCount = tostring(#moments) })
    end, { moments, profileId })

    React.useEffect(function()
        if not FFlagProfileMomentsLoadFailureAnalytics and var14.hasFailed and profileId ~= nil then
            fireAnalyticsEvent(EventNames.ProfileLoadFailed, { userId = profileId })
        end
    end, { var14.hasFailed, profileId })

    local var21 = React.useCallback(function()
        var4.goBack()
    end, { var4.goBack })

    local var22 = React.useCallback(function(initialIndex: number)
        local moment = moments[initialIndex]
        if moment and profileId then
            local profileTileInteractionFields = makeProfileTileFields.makeProfileTileInteractionFields(moment, profileId, "grid", initialIndex)
            if profileTileInteractionFields then
                fireAnalyticsEvent(EventNames.ProfileMomentSelected, profileTileInteractionFields)
            end
        end
        local extraProps = {
            targetUserId = tonumber(profileId) or 0,
            initialIndex = initialIndex,
            initialMomentId = if FFlagMomentsOptimisticProfilePending and moment ~= nil then moment.momentId else nil
        }
        if FFlagMomentsOptimisticProfilePending and var19 ~= nil and var19.current ~= nil then
            var19.current.release()
        end
        if not var2 then
            var4.navigate(Enums.Screens.MomentsFeed, { extraProps = extraProps })

            return
        end

        local tbl2 = {
            name = if var1 then AppPage.MomentsImmersive else AppPage.ProfileMomentsFeed,
            extraProps = extraProps
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
            return
        end
        var5(NavigateDown(tbl2))
    end, {
        var4,
        var5,
        profileId,
        moments
    })
    local renderItem = React.useCallback(function(moment, index: number)
        return React.createElement(MomentGridItem, {
            moment = moment,
            isActive = activeIndex == index,
            userId = profileId,
            index = index,
            onActivated = function()
                var22(index)
            end,
            onHoverChanged = function(bool4: boolean)
                var18(function(num1: number?): number?
                    return if bool4 then index elseif num1 == index then nil else num1
                end)
            end
        })
    end, { var22, activeIndex, profileId })

    local renderEmptyState = React.useCallback(function()
        return React.createElement(View, { tag = "col align-x-center align-y-center grow size-full" })
    end, {})

    local subtitle = if usernameFromId == nil or usernameFromId == "" then nil else `@{usernameFromId}`
    local header = React.createElement(View, {
        Size = UDim2.new(1, 0, 0, 56),
        padding = {
            left = UDim.new(0, var6.Padding.Large),
            right = UDim.new(0, var6.Padding.Large)
        },
        tag = "row align-x-left align-y-center gap-small"
    }, {
        BackButton = React.createElement(
            IconButton,
            {
                LayoutOrder = 1,
                icon = ChevronLargeLeft,
                size = ButtonSize.Medium,
                onActivated = var21
            }
        ),
        User = React.createElement(View, {
            LayoutOrder = 2,
            Size = UDim2.new(0, 0, 1, 0),
            tag = "grow"
        }, {
            UserTile = React.createElement(UserTile, {
                userId = profileId or "",
                title = title,
                subtitle = subtitle,
                layoutMode = LayoutMode.wide,
                userPresenceType = nil,
                avatarSize = UDim2.fromOffset(40, 40),
                titleStyle = var6.Typography.HeadingSmall,
                subtitleStyle = var6.Typography.BodyMedium,
                isTitleLoading = title == nil,
                isSubtitleLoading = usernameFromId == nil
            })
        })
    })

    local var26 = React.useMemo(function()
        for _, moment in moments do
            if if FFlagProfileMomentSceneOutfitPoster then isPlayableVideoMoment(moment) else moment.metadata.captureType == Enum.CaptureType.Video then
                return true
            end
        end
        return false
    end, { moments })

    local var27 = useNavigationFocus()
    local moment = if activeIndex == nil then nil else moments[activeIndex]

    if FFlagProfileMomentSceneOutfitPoster then
        if moment == nil then
            var27 = false
        else
            var27 = isPlayableVideoMoment(moment) and var27
        end
    elseif moment == nil or moment.metadata.captureType ~= Enum.CaptureType.Video then
        var27 = false
    end

    local footer = if #moments > 0 then React.createElement(
        Foundation.Text,
        {
            Text = var15.feedEndTitle,
            tag = "auto-xy padding-large text-body-medium text-align-x-center content-muted"
        }
    ) else nil
    local element3 = React.createElement(View, {
        padding = {
            left = UDim.new(0, var6.Padding.Large),
            right = UDim.new(0, var6.Padding.Large),
            top = UDim.new(0, var6.Padding.Large),
            bottom = UDim.new(0, var6.Padding.Large)
        },
        tag = "grow size-full-0"
    }, {
        ScrollingGridView = React.createElement(ScrollingGridView, {
            aspectRatio = 1.5,
            items = moments,
            itemConfig = {
                padding = 8,
                maxItemsPerRow = 3,
                minItemsPerPage = 9,
                minItemWidth = 100
            },
            renderItem = renderItem,
            renderEmptyState = renderEmptyState,
            shouldShowShowMoreButton = hasMore,
            showMoreButtonText = "Show More",
            onShowMoreCallback = loadMore,
            enableInfiniteScroll = if var16 then true else nil,
            footer = footer
        })
    })

    if var26 then
        element3 = React.createElement(MomentsCarouselMediaProvider, {
            moments = if var27 then moments else var3,
            activeIndex = activeIndex or 1,
            playbackActive = var27,
            handoffRef = if FFlagMomentsOptimisticProfilePending then var19 else nil
        }, { Grid = element3 })
    end

    if FFlagAXEnableProfileTab and bool3 then
        return React.createElement(View, {
            backgroundStyle = {
                Color3 = theme.BackgroundDefault.Color,
                Transparency = theme.BackgroundDefault.Transparency
            },
            padding = bool1 and {
                top = UDim.new(0, var10 + var6.Padding.XLarge)
            } or nil,
            tag = if bool1 then "col gap-medium size-full" else "col gap-medium size-full padding-top-xlarge"
        }, { Header = header, Grid = element3 })
    end

    if not bool2 then
        return React.createElement(FullscreenPageWithSafeArea, {
            includeStatusBar = true,
            BackgroundColor3 = theme.BackgroundDefault.Color,
            BackgroundTransparency = theme.BackgroundDefault.Transparency
        }, {
            Content = React.createElement(
                View,
                {
                    padding = {
                        top = UDim.new(0, var6.Padding.XLarge)
                    },
                    tag = "col gap-medium size-full"
                },
                { Header = header, Grid = element3 }
            )
        })
    end

    local var28 = 56 + var6.Padding.XLarge
    return React.createElement(ProfileModalView, {
        topBarHeight = 56,
        viewWidth = var11,
        navigateBack = var21,
        renderTopBar = function()
            return React.createElement(
                View,
                {
                    Size = UDim2.new(1, 0, 0, var28),
                    padding = {
                        top = UDim.new(0, var6.Padding.XLarge)
                    },
                    tag = "col"
                },
                { Header = header }
            )
        end,
        renderContent = function()
            return React.createElement(View, { padding = { top = UDim.new(0, var28) }, tag = "col size-full" }, { Grid = element3 })
        end
    })
end

return MomentsGridPage
