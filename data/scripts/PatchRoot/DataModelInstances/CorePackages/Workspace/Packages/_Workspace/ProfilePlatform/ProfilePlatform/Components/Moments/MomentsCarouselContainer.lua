-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local Navigation = require(ProfilePlatformParent.Navigation)
local NavigationRodux = require(ProfilePlatformParent.NavigationRodux)
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local SharedFlags = require(ProfilePlatformParent.SharedFlags)
local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage
local MomentsCommon = require(ProfilePlatformParent.MomentsCommon)

local MomentsCarousel = require(script.Parent.MomentsCarousel)
local useUserMoments = require(ProfilePlatform.Hooks.useUserMoments)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local Enums = require(ProfilePlatform.Common.Enums)
local makeProfileTileFields = require(ProfilePlatform.Analytics.makeProfileTileFields)

local fireAnalyticsEvent = MomentsCommon.Analytics.fireAnalyticsEvent
local EventNames2 = MomentsCommon.Analytics.EventNames

local useNavigation = Navigation.useNavigation
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local NavigateDown = NavigationRodux.Thunks.NavigateDown
local FFlagMomentsOptimisticProfilePending = SharedFlags.FFlagMomentsOptimisticProfilePending
local FFlagSignalsNavP3Dispatch = SharedFlags.FFlagSignalsNavP3Dispatch
local FFlagProfileMomentsFeedRootRoute = SharedFlags.FFlagProfileMomentsFeedRootRoute
local FFlagEnableArgus = SharedFlags.FFlagEnableArgus
local FFlagEnableArgusImmersiveNav = SharedFlags.FFlagEnableArgusImmersiveNav
local FFlagProfileRenderAvatarMoments = SharedFlags.FFlagProfileRenderAvatarMoments
local FFlagProfileMomentsLoadFailureAnalytics = require(ProfilePlatform.Flags.FFlagProfileMomentsLoadFailureAnalytics)
local var1 = FFlagProfileMomentsFeedRootRoute
    and FFlagEnableArgus
    and FFlagEnableArgusImmersiveNav
    and FFlagProfileRenderAvatarMoments
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ProfilePlatformParent.RobloxAppNavigation).NavigationCommands else nil
local var2 = FFlagProfileMomentsFeedRootRoute or FFlagProfileRenderAvatarMoments

local function MomentsCarouselContainer(tbl1)
    local var3 = useProfileWrapperContext()
    local var4 = useProfileAnalyticsContext()
    local var5 = useNavigation()
    local var6 = if var2 then useDispatch() else nil

    local profileId = var3.profileId
    local var7 = useUserMoments(profileId)
    local moments = var7.moments

    if FFlagProfileMomentsLoadFailureAnalytics then
        React.useEffect(function()
            if var7.hasFailed and profileId ~= nil then
                fireAnalyticsEvent(EventNames2.ProfileLoadFailed, { userId = profileId })
            end
        end, { var7.hasFailed, profileId })
    end

    local onActivateHeader = React.useCallback(function()
        var4.fireAnalyticsEvent(EventNames.MomentsSeeAll)
        var5.navigate(Enums.Screens.MomentsAll, { extraProps = { profileId = profileId } })
    end, { var4, var5, profileId })

    local onSelectMoment = React.useCallback(function(initialIndex: number)
        local moment = moments[initialIndex]
        if moment and profileId then
            local profileTileInteractionFields = makeProfileTileFields.makeProfileTileInteractionFields(moment, profileId, "carousel", initialIndex)
            if profileTileInteractionFields then
                fireAnalyticsEvent(EventNames2.ProfileMomentSelected, profileTileInteractionFields)
            end
        end
        local extraProps = {
            targetUserId = tonumber(profileId) or 0,
            initialIndex = initialIndex,
            initialMomentId = if FFlagMomentsOptimisticProfilePending and moment ~= nil then moment.momentId else nil
        }
        if not var2 then
            var5.navigate(Enums.Screens.MomentsFeed, { extraProps = extraProps })

            return
        end

        local tbl3 = {
            name = if var1 then AppPage.MomentsImmersive else AppPage.ProfileMomentsFeed,
            extraProps = extraProps
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl3))
            return
        end
        var6(NavigateDown(tbl3))
    end, {
        var4,
        var5,
        var6,
        profileId,
        moments
    })

    local onTileImpression = React.useCallback(function(num1: number)
        local moment = moments[num1]
        if not moment or not profileId or not moment.recommendationMetadata then
            return
        end
        local profileTileImpressionFields = makeProfileTileFields.makeProfileTileImpressionFields(moment, profileId, "carousel", num1)
        if profileTileImpressionFields then
            fireAnalyticsEvent(EventNames2.ProfileMomentTileImpression, profileTileImpressionFields)
        end
    end, { profileId, moments })

    if #moments == 0 then
        return React.None
    end

    return React.createElement(MomentsCarousel, {
        layoutOrder = tbl1.layoutOrder,
        moments = moments,
        onActivateHeader = onActivateHeader,
        onSelectMoment = onSelectMoment,
        onTileImpression = onTileImpression
    })
end

return MomentsCarouselContainer
