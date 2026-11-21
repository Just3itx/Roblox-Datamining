-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local HttpService = game:GetService("HttpService")

local React = require(scriptParentParentParentParent.React)

local GameJoinCard = script:FindFirstAncestor("GameJoinCard")
local FFlagMobileGameJoinCardEDPFromTitle = require(GameJoinCard.Flags.FFlagMobileGameJoinCardEDPFromTitle)
local FFlagMobileGameJoinCardEDPFromThumbnail = require(GameJoinCard.Flags.FFlagMobileGameJoinCardEDPFromThumbnail)
local FFlagGameJoinCardChatEntryPoint = require(GameJoinCard.Flags.FFlagGameJoinCardChatEntryPoint)
local FFlagMobileGameJoinCardVideo = require(scriptParentParentParentParent.SharedFlags).FFlagMobileGameJoinCardVideo
local useJoinCardBannerVideoId = require(GameJoinCard.Hooks.useJoinCardBannerVideoId)

local AnalyticsConstants = require(script.Parent.Parent.Parent.Analytics.AnalyticsConstants)
local GameJoinCardButtonAction = AnalyticsConstants.GameJoinCardButtonAction
local GameJoinCardSurface = AnalyticsConstants.GameJoinCardSurface
local viewEDPsourceValues = AnalyticsConstants.viewEDPsourceValues
local viewProfileSourceValues = AnalyticsConstants.viewProfileSourceValues
local useGameJoinCardAnalytics = require(script.Parent.Parent.Parent.Analytics.useGameJoinCardAnalytics)
local useAgeCheckUpsellAnalytics = require(script.Parent.Parent.Parent.Analytics.useAgeCheckUpsellAnalytics)
local useAgeCheckCompletionLogger = useAgeCheckUpsellAnalytics.useAgeCheckCompletionLogger
local useAgeCheckPressLogger = useAgeCheckUpsellAnalytics.useAgeCheckPressLogger
local GameJoinCardTelemetry = require(script.Parent.Parent.Parent.Telemetry.GameJoinCardTelemetry)
local FFlagMobileGameJoinCardThumbnail = require(script.Parent.Parent.Parent.Flags.FFlagMobileGameJoinCardThumbnail)
local Foundation = require(scriptParentParentParentParent.Foundation)
local getRbxThumb = Foundation.Utility.getRbxThumb
local ThumbnailType = Foundation.Enums.ThumbnailType
local ThumbnailSize = Foundation.Enums.ThumbnailSize
local RobloxAppEnums = require(scriptParentParentParentParent.RobloxAppEnums)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)
local SocialExperienceJoin = require(scriptParentParentParentParent.SocialExperienceJoin)
local useNavigation = require(scriptParentParentParentParent.Navigation).useNavigation
local useNavigationFocus = require(scriptParentParentParentParent.Navigation).useNavigationFocus
local usePlayerName = require(GameJoinCard.Hooks.usePlayerName)

local useQuery = require(scriptParentParentParentParent.ApolloClient).useQuery
local ApolloLocalState = require(scriptParentParentParentParent.ApolloLocalState)
local Players = game:GetService("Players")

local UserProfiles = require(scriptParentParentParentParent.UserProfiles)
local SocialCommon = require(scriptParentParentParentParent.SocialCommon)
local ChatEntryPointNames = SocialCommon.Enums.ChatEntryPointNames
local EnteredChatFromEntryPoint = SocialCommon.Actions.EnteredChatFromEntryPoint
local _VideoUtils = require(scriptParentParentParentParent.VideoUtils)

local SharedFlags = require(scriptParentParentParentParent.SharedFlags)

local FFlagSocialCarouselUseProfileStore = SharedFlags.FFlagSocialCarouselUseProfileStore
local FFlagUserProfilePlatformProfile = SharedFlags.FFlagUserProfilePlatformProfile
local FFlagSocialCarouselBuildPresence = SharedFlags.FFlagSocialCarouselBuildPresence

local FFlagFriendSortedByPresenceSignalsImplementation = SharedFlags.FFlagFriendSortedByPresenceSignalsImplementation
local FFlagEnableSplitPane = SharedFlags.FFlagEnableSplitPane
local FFlagGameJoinCardAnalyticsCardId = SharedFlags.FFlagGameJoinCardAnalyticsCardId
local FFlagGameJoinCardSourceAttribution = SharedFlags.FFlagGameJoinCardSourceAttribution
local FFlagJoinabilityCTARefactor = SharedFlags.FFlagJoinabilityCTARefactor
local FFlagJoinUserCTAsIxpEnabled = SharedFlags.FFlagJoinUserCTAsIxpEnabled
local FStringJoinUserCTAsIxpLayer = SharedFlags.FStringJoinUserCTAsIxpLayer
local FFlagMobileGameJoinCardGamepadSupport = SharedFlags.FFlagMobileGameJoinCardGamepadSupport
local IXPServiceWrapper = if FFlagJoinUserCTAsIxpEnabled then require(scriptParentParentParentParent.IXPServiceWrapper).IXPServiceWrapper else nil
local DataHydration = require(scriptParentParentParentParent.DataHydration)
local UserCtaAction = require(scriptParentParentParentParent.UserCtaCommon).Enums.UserCtaAction
local useLocalization = require(scriptParentParentParentParent.Localization).Hooks.useLocalization
local Signals = require(scriptParentParentParentParent.Signals)
local SignalsReact = require(scriptParentParentParentParent.SignalsReact)
local var1 = if FFlagSocialCarouselUseProfileStore then UserProfiles.Stores.UserProfileStore.get() else nil
local GameDetail = require(scriptParentParentParentParent.GameDetail)
local useExperienceBannerImage = GameDetail.useExperienceBannerImage
local OpenGameDetails = GameDetail.OpenGameDetails
local DiscoveryAnalytics = require(scriptParentParentParentParent.DiscoveryAnalytics)
local gamePlayIntent = DiscoveryAnalytics.Events.gamePlayIntent
local gameDetailReferral = DiscoveryAnalytics.Events.gameDetailReferral
local PeopleListInHomePage = DiscoveryAnalytics.Constants.Context.PeopleListInHomePage
local RoactServiceTags = require(scriptParentParentParentParent.RoactServiceTags)
local AppEventIngestService = RoactServiceTags.AppEventIngestService
local AppGuiService = RoactServiceTags.AppGuiService
local AppSessionService = RoactServiceTags.AppSessionService
local useRoactService = require(scriptParentParentParentParent.RobloxAppHooks).useRoactService
local RobloxAppSessionization = require(scriptParentParentParentParent.RobloxAppSessionization)
local SetGamePlaySession = RobloxAppSessionization.SetGamePlaySession
local SessionType = RobloxAppSessionization.SessionType

local useAppPolicy = require(scriptParentParentParentParent.UniversalAppPolicy).useAppPolicy

local AppPage = RobloxAppEnums.AppPage
local NotificationType = RobloxAppEnums.NotificationType

local dependencyArray = RoactUtils.Hooks.dependencyArray
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useJoinUserInExperience = SocialExperienceJoin.useJoinUserInExperience

local MobileGameJoinCard = require(script.Parent.MobileGameJoinCard)
local Actions = require(GameJoinCard.Components.Actions)
local containsAction = require(GameJoinCard.Components.Actions.containsAction)
local useJoinUserActions = require(GameJoinCard.Hooks.useJoinUserActions)
local useLogActionsResolveTime = require(GameJoinCard.Telemetry.useLogActionsResolveTime)

local DataStatus = DataHydration.DataStatus

local var2 = DataHydration.Presence.PresenceStore.get()

local FFlagProfileCTAHydratePresenceFromMetadata = require(scriptParentParentParentParent.DataHydration.FFlagProfileCTAHydratePresenceFromMetadata)

local tbl1 = {
    universeId = "",
    lastLocation = "",
    userPresenceType = "",
    placeId = "",
    rootPlaceId = "",
    gameId = ""
}

local tbl2 = { skipFetch = true }

local function MobileGameJoinCardContainer()
    local dispatch = if FFlagMobileGameJoinCardEDPFromTitle
        or FFlagMobileGameJoinCardEDPFromThumbnail
        or FFlagGameJoinCardChatEntryPoint
        or FFlagJoinabilityCTARefactor then useDispatch() else nil
    local navigation = useNavigation()
    local isNavigationFocused = if FFlagMobileGameJoinCardGamepadSupport then useNavigationFocus() else nil
    local param = navigation.getParam("userId") or ""
    local param2 = navigation.getParam("homepageCarouselAbsolutePosition")
    local param3 = if FFlagGameJoinCardSourceAttribution then navigation.getParam("joinSource") else nil

    local onClose = React.useCallback(function()
        navigation.goBack()
    end, { navigation })

    local var7 = if FFlagGameJoinCardAnalyticsCardId then React.useMemo(function(): string
        return HttpService:GenerateGUID(false)
    end, {}) else nil

    local eventIngest = useRoactService(AppEventIngestService)
    local guiService = useRoactService(AppGuiService)
    local var10 = if FFlagMobileGameJoinCardEDPFromTitle or FFlagMobileGameJoinCardEDPFromThumbnail then useRoactService(AppSessionService) else nil

    local canUsePlatformChat = useAppPolicy(function(arg1)
        return arg1.getCanUsePlatformChat()
    end)

    local userId = tostring(Players.LocalPlayer and Players.LocalPlayer.UserId or "")
    local var12

    if FFlagFriendSortedByPresenceSignalsImplementation then
        local var13 = React.useMemo(function()
            return Signals.createComputed(function(arg1)
                return var2.GetPresenceByUserId(
                    param,
                    if FFlagJoinabilityCTARefactor and FFlagProfileCTAHydratePresenceFromMetadata then tbl2 else nil
                ).data(
                    arg1
                )
            end)
        end, { param })

        var12 = SignalsReact.useSignalState(var13)
    else
        local var13 = useQuery(
            ApolloLocalState.queries.onlineFriendsByUserId,
            {
                fetchPolicy = "cache-only",
                variables = { userId = userId, sort = 1 }
            }
        )

        var12 = React.useMemo(function()
            local onlineFriendsByUserId = var13.data and var13.data.onlineFriendsByUserId
            if not onlineFriendsByUserId then
                return nil
            end
            for _, value in onlineFriendsByUserId do
                if value.id == param then
                    return value.presence
                end
            end
            return nil
        end, { var13.data, param })
    end

    local var13, var14 = React.useState({ universeId = "", experienceName = "" })

    React.useEffect(function()
        if not var12 or tostring(var12.universeId) == "" then
            return
        end
        var14({ universeId = tostring(var12.universeId), experienceName = var12.lastLocation })
    end, { var12 })

    local universeId = var13.universeId
    local experienceName = var13.experienceName

    React.useEffect(function()
        if param == "" then
            return
        end

        local var15 = if var12 and var12.universeId ~= nil and tostring(var12.universeId) ~= "" then tostring(var12.universeId) else nil

        if FFlagJoinUserCTAsIxpEnabled then
            IXPServiceWrapper:LogFlagLinkedUserLayerExposure(FStringJoinUserCTAsIxpLayer)
        end
        useGameJoinCardAnalytics.logGameJoinCardPageLoaded({
            friendId = param,
            universeId = var15,
            absolutePosition = param2,
            joinGameCardId = if FFlagGameJoinCardAnalyticsCardId then var7 else nil
        })
    end, {})

    local var15

    if FFlagSocialCarouselBuildPresence then
        var15 = usePlayerName(param)
    elseif FFlagSocialCarouselUseProfileStore then
        local var16 = React.useMemo(function()
            return var1.fetchNamesByUserIds({ param })
        end, { param })

        local var17 = React.useMemo(function()
            return Signals.createComputed(function(arg1)
                local var17 = var16(arg1)
                local var18 = var17 and var17.data and var17.data[1]
                if var18 and var18.names then
                    return (var18.names.getCombinedName(arg1))
                end

                return nil
            end)
        end, { var16 })

        var15 = SignalsReact.useSignalState(var17) or ""
    else
        local var16 = UserProfiles.Hooks.useUserProfilesFetch({
            userIds = { param },
            query = if FFlagUserProfilePlatformProfile then UserProfiles.Queries.userProfilesCombinedNameByUserIds else UserProfiles.Queries.userProfilesCombinedAndPlatformByUserIds
        })

        var15 = React.useMemo(function()
            if var16.data then
                return UserProfiles.Selectors.getCombinedNameFromId(var16.data, param) or ""
            end

            return ""
        end, { var16.data, param })
    end

    local var16 = if var12 and var12.rootPlaceId ~= nil then tostring(var12.rootPlaceId) else nil
    local var17 = useExperienceBannerImage(universeId, var16)
    local thumbnailImageUrl = if FFlagMobileGameJoinCardThumbnail and universeId ~= "" then getRbxThumb(ThumbnailType.GameIcon, universeId, ThumbnailSize.Medium) else nil

    React.useEffect(function()
        if universeId == "" then
            return
        end
        GameJoinCardTelemetry.logBannerLoadResult(var17.status)
    end, { var17.status, universeId })

    local onBeforeJoin = React.useCallback(function()
        if not FFlagJoinabilityCTARefactor then
            navigation.goBack()
        end
    end, { navigation })

    local onAgeCheckCompletion = useAgeCheckCompletionLogger(universeId)

    local analyticProps = if FFlagGameJoinCardSourceAttribution then React.useMemo(function(): {context: any, subpage: any}?
        return if param3 == nil then nil else {
            context = param3.surface,
            subpage = param3.subpage
        }
    end, { param3 }) else nil

    local var21 = useJoinUserInExperience
    local tbl3 = {
        isHomePageCarousel = not FFlagGameJoinCardSourceAttribution or param3 == nil,
        analyticProps = analyticProps,
        joinAttemptOrigin = if FFlagGameJoinCardSourceAttribution and param3 ~= nil then param3.surface else nil,
        presence = var12 or tbl1,
        onBeforeJoin = onBeforeJoin,
        onAgeCheckCompletion = onAgeCheckCompletion
    }
    local var22 = var21(param, tbl3)
    local bannerVideoId = if FFlagMobileGameJoinCardVideo then useJoinCardBannerVideoId(universeId, var22.cachedPlayabilityStatus, navigation.getParam("isBannerVideoEnabled") == true) else nil
    local bannerVideoPlaybackContext = if FFlagMobileGameJoinCardVideo then navigation.getParam("videoPlaybackContext") else nil
    local var24, var25, var26

    if FFlagJoinabilityCTARefactor then
        local str2 = tostring(var12 and var12.userPresenceType)
        local str3 = tostring(var12 and var12.universeId)
        local str4 = tostring(var12 and var12.placeId)
        local str5 = tostring(var12 and var12.rootPlaceId)
        local ageCheckRequired = var22.ageCheckRequired
        local str6 = `{str2}:{str3}:{str4}:{str5}:{tostring(ageCheckRequired)}`
        var24, var25 = useJoinUserActions(param, true, str6)
        var26 = useLocalization(Actions.TextKeys)
    else
        var25 = nil
        var24 = nil
        var26 = nil
    end

    useLogActionsResolveTime(if FFlagJoinabilityCTARefactor then var25 else nil, true, GameJoinCardSurface.Mobile)

    local onAgeCheckPressed = useAgeCheckPressLogger({
        userId = param,
        universeId = universeId,
        absolutePosition = param2,
        joinGameCardId = if FFlagGameJoinCardAnalyticsCardId then var7 else nil,
        joinAgeCheckUpsellFlow = var22.joinAgeCheckUpsellFlow
    })
    local bool1 = if FFlagJoinabilityCTARefactor then var25 == DataStatus.Ready and containsAction(var24, UserCtaAction.UnlockExperience) else var22.ageCheckRequired == true

    React.useEffect(function()
        if not bool1 or universeId == "" then
            return
        end
        useGameJoinCardAnalytics.logJoinCardAgeCheckUpsellImpression({ universeId = universeId })
    end, { bool1, universeId })

    local var28 = React.useCallback(function()
        local friendId = param
        if friendId ~= "" then
            useGameJoinCardAnalytics.logGameJoinCardButtonEvent(GameJoinCardButtonAction.JoinGame, {
                friendId = friendId,
                universeId = if universeId == "" then nil else universeId,
                absolutePosition = param2,
                joinGameCardId = if FFlagGameJoinCardAnalyticsCardId then var7 else nil
            })
        end
        if friendId == "" or not var12 then
            return
        end

        local var29 = if var12.placeId == nil or tostring(var12.placeId) == "" then "" else tostring(var12.placeId)
        local rootPlaceId = tonumber(var12.rootPlaceId)
        if var29 == "" or rootPlaceId == nil then
            return
        end
        gamePlayIntent(
            eventIngest,
            PeopleListInHomePage,
            {
                placeId = var29,
                rootPlaceId = rootPlaceId,
                friendId = friendId,
                joinAttemptId = HttpService:GenerateGUID(false)
            }
        )
    end, dependencyArray(param, universeId, param2, var12))

    local var29 = React.useCallback(function()
        (if FFlagEnableSplitPane then navigation.push else navigation.navigate)(AppPage.ProfilePlatform, { detail = param })
    end, { navigation, param })

    local onViewProfile = React.useCallback(function(arg1)
        if param ~= "" then
            local tbl4 = {
                friendId = param,
                universeId = if universeId == "" then nil else universeId,
                absolutePosition = param2,
                joinGameCardId = if FFlagGameJoinCardAnalyticsCardId then var7 else nil
            }
            if arg1 == viewProfileSourceValues.UserTile then
                useGameJoinCardAnalytics.logGameJoinCardButtonEvent(GameJoinCardButtonAction.OpenProfileFromUserTile, tbl4)
            elseif arg1 == viewProfileSourceValues.ViewProfileButton then
                useGameJoinCardAnalytics.logGameJoinCardButtonEvent(GameJoinCardButtonAction.OpenProfileFromViewProfile, tbl4)
            end
        end

        var29()
    end, dependencyArray(var29, param, universeId, param2))

    local var31 = if FFlagMobileGameJoinCardEDPFromTitle or FFlagMobileGameJoinCardEDPFromThumbnail then React.useCallback(function()
        local rootPlaceId = var12 and var12.rootPlaceId
        local pid = if rootPlaceId ~= nil and tostring(rootPlaceId) ~= "" then tostring(rootPlaceId) else universeId
        local var32 = param2 or 0
        if var10 then
            SetGamePlaySession(var10, SessionType.StructuralIdentifier.GameDetailSource, false)
        end
        gameDetailReferral(eventIngest, "home", {
            ad = "no",
            friendId = param,
            pg = "home",
            pid = pid,
            pos = var32,
            rowOnPage = 1,
            sortPos = var32,
            tis = 1,
            universeId = universeId
        })
        dispatch(OpenGameDetails(universeId, navigation))
    end, {
        dispatch,
        navigation,
        universeId,
        var12,
        param2,
        param,
        eventIngest,
        var10
    }) else nil

    local onViewExperienceDetails = if FFlagMobileGameJoinCardEDPFromTitle or FFlagMobileGameJoinCardEDPFromThumbnail then React.useCallback(function(arg1)
        if param ~= "" then
            local tbl4 = {
                friendId = param,
                universeId = if universeId == "" then nil else universeId,
                absolutePosition = param2,
                joinGameCardId = if FFlagGameJoinCardAnalyticsCardId then var7 else nil
            }
            local var32 = if arg1 == viewEDPsourceValues.Thumbnail then GameJoinCardButtonAction.ViewExperienceDetailsFromThumbnail elseif arg1 == viewEDPsourceValues.Title then GameJoinCardButtonAction.ViewExperienceDetailsFromTitle else nil

            if var32 then
                useGameJoinCardAnalytics.logGameJoinCardButtonEvent(var32, tbl4)
            end
        end
        if universeId ~= "" then
            var31()
        end
    end, {
        var31,
        universeId,
        param,
        param2,
        var7
    }) else nil

    local onJoin = React.useCallback(function()
        var28()
        var22.joinExperience()
    end, dependencyArray(var28, var22))

    local onChat = React.useCallback(function()
        if param == "" then
            return
        end
        useGameJoinCardAnalytics.logGameJoinCardButtonEvent(GameJoinCardButtonAction.Chat, {
            friendId = param,
            universeId = if universeId == "" then nil else universeId,
            absolutePosition = param2,
            joinGameCardId = if FFlagGameJoinCardAnalyticsCardId then var7 else nil
        })
        if FFlagGameJoinCardChatEntryPoint then
            dispatch(EnteredChatFromEntryPoint(ChatEntryPointNames.GameJoinCard))
        end
        guiService:BroadcastNotification(param, NotificationType.LAUNCH_CONVERSATION)
    end, dependencyArray(param, universeId, param2, navigation, guiService, dispatch))

    local bool2, tbl4

    if FFlagJoinabilityCTARefactor then
        bool2 = var25 == DataStatus.NotReady
        tbl4 = {}
        if var25 == DataStatus.Ready and var26 ~= nil then
            local resolveJoinCardActions = Actions.resolveJoinCardActions
            local tbl5 = {
                localized = var26,
                userId = param,
                telemetry = {
                    universeId = if universeId == "" then nil else universeId,
                    absolutePosition = param2,
                    joinGameCardId = if FFlagGameJoinCardAnalyticsCardId then var7 else nil
                },
                presence = 0,
                experience = 0,
                eventIngest = 0,
                dispatch = 0,
                guiService = 0,
                navigation = 0,
                joinAgeCheckUpsellFlow = 0
            }
            local presence = {
                placeId = if var12 and var12.placeId ~= nil then tostring(var12.placeId) else nil,
                rootPlaceId = var16
            }
            tbl5.presence = presence

            tbl5.experience = {
                isLoading = var22.isLoading,
                isInExperience = var22.isInExperience,
                joinExperience = var22.joinExperience,
                playExperience = var22.playExperience
            }
            tbl5.eventIngest = eventIngest
            tbl5.dispatch = dispatch
            tbl5.guiService = guiService
            tbl5.navigation = navigation
            tbl5.joinAgeCheckUpsellFlow = var22.joinAgeCheckUpsellFlow

            for _, value in (resolveJoinCardActions(var24, tbl5)) do
                if value.id == UserCtaAction.Chat and not canUsePlatformChat then
                    continue
                end

                if value.id == UserCtaAction.ViewProfile or value.id == UserCtaAction.Chat then
                    value.keepOpenOnActivate = true
                end
                table.insert(tbl4, value)
            end
        end
    else
        tbl4 = nil
        bool2 = false
    end

    local createElement = React.createElement
    local var35 = MobileGameJoinCard
    local tbl5 = {
        isNavigationFocused = isNavigationFocused,
        onClose = onClose,
        onJoin = onJoin,
        onViewProfile = onViewProfile,
        onViewExperienceDetails = onViewExperienceDetails,
        onChat = onChat,
        canUsePlatformChat = canUsePlatformChat,
        userId = param,
        universeId = universeId,
        homepageCarouselAbsolutePosition = param2,
        playerName = var15,
        experienceName = experienceName,
        bannerImageUrl = var17.url,
        thumbnailImageUrl = thumbnailImageUrl,
        bannerVideoId = bannerVideoId,
        bannerVideoPlaybackContext = bannerVideoPlaybackContext,
        isLoading = var22.isLoading,
        isInExperience = var22.isInExperience,
        ageCheckRequired = var22.ageCheckRequired,
        onAgeCheckPressed = onAgeCheckPressed,
        wasPlayabilityCached = var22.playabilityFromCache,
        actions = not FFlagJoinabilityCTARefactor and {} or tbl4,
        areActionsLoading = 0
    }

    if not FFlagJoinabilityCTARefactor then
        bool2 = nil
    end

    tbl5.areActionsLoading = bool2
    return createElement(var35, tbl5)
end

return MobileGameJoinCardContainer
