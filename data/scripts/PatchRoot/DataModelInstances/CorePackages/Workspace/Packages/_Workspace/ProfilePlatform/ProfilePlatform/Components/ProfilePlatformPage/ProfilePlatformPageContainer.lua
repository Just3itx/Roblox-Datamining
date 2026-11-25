-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local getDeepValue = require(ProfilePlatform.Utils.getDeepValue)
local Navigation = require(ProfilePlatformParent.Navigation)
local React = require(ProfilePlatformParent.React)
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local RobloxAppEnums = require(ProfilePlatformParent.RobloxAppEnums)
local SharedFlags = require(ProfilePlatformParent.SharedFlags)
local SocialLuaAnalytics = require(ProfilePlatformParent.SocialLuaAnalytics)
local SocialStopwatch = require(ProfilePlatformParent.SocialStopwatch)
local Cryo = require(ProfilePlatformParent.Cryo)
local checkQrSession = require(ProfilePlatform.Networking.checkQrSession)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useEffectOnMount = RoactUtils.Hooks.useEffectOnMount
local useLocalUserId = require(ProfilePlatformParent.RobloxAppHooks).useLocalUserId
local useSignalState = require(ProfilePlatformParent.SignalsReact).useSignalState
local ProfileRefreshSignal = require(ProfilePlatformParent.ProfilePlatformCommon).Signals.ProfileRefreshSignal
local parseComponentsFromJson = require(ProfilePlatform.Components.ProfilePlatformPage.parseComponentsFromJson)
local useAvailableComponents = require(ProfilePlatform.Hooks.useAvailableComponents)
local useProfileJson = require(ProfilePlatform.Hooks.useProfileJson)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useIsMeTab = require(ProfilePlatform.Hooks.useIsMeTab)
local ProfilePlatformEventReceiver = require(script.Parent.ProfilePlatformEventReceiver)
local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local Enums = require(ProfilePlatform.Common.Enums)
local getFriendStatusFromProfileResponse = require(script.Parent.getFriendStatusFromProfileResponse)

local getIsTrustedConnectionsStatusFromProfileResponse = require(script.Parent.getIsTrustedConnectionsStatusFromProfileResponse)
local refreshProfilePlatformActionInfo = require(ProfilePlatform.Networking.refreshProfilePlatformActionInfo)
local useActionsComponentRequest = require(ProfilePlatform.Hooks.useActionsComponentRequest)
local LoadingStages = SocialLuaAnalytics.Analytics.Enums.LoadingStages
local LoadingStagesExtension = require(ProfilePlatform.Analytics.LoadingStagesExtension)
local FFlagProfilePlatformEnableVR = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableVR)

local FFlagProfilePlatformEnableLazyLoadingComponents = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableLazyLoadingComponents)

local FFlagProfilePlatformRefreshActionsRespectPolicies = require(ProfilePlatform.Flags.FFlagProfilePlatformRefreshActionsRespectPolicies)
local FFlagProfilePlatformEnableMoments = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableMoments)
local FFlagProfilePlatformTrustedConnectionsMVP = SharedFlags.FFlagProfilePlatformTrustedConnectionsMVP
local FFlagAXEnableProfileTab = SharedFlags.FFlagAXEnableProfileTab
local FFlagJoinUserCTAsIxpEnabled = SharedFlags.FFlagJoinUserCTAsIxpEnabled
local FStringJoinUserCTAsIxpLayer = SharedFlags.FStringJoinUserCTAsIxpLayer
local IXPServiceWrapper = if FFlagJoinUserCTAsIxpEnabled then require(ProfilePlatformParent.IXPServiceWrapper).IXPServiceWrapper else nil
local layerName = game:DefineFastString("SocialProfilePeekViewLayer", "Social.ProfilePeekView")

local layerName2 = game:DefineFastString("SocialProfilePeekViewSecondaryLayer", "Social.ProfilePeekView.Secondary")
local layerName3 = game:DefineFastString("SocialSelfProfileViewLayer", "Social.SelfProfileView")
local IXPService = game:GetService("IXPService")

local bool1 = game:DefineFastFlag("EnableSocialProfilePeekViewExposureEvents", false)
local bool2 = game:DefineFastFlag("ProfilePlatformEnableRefreshSignal", false)

local bool3 = game:DefineFastFlag("ProfilePlatformEnableSessionization", false)
local SessionService = if bool3 then game:GetService("SessionService") else nil
local SessionType = if bool3 then require(ProfilePlatformParent.RobloxAppSessionization).SessionType else nil
local AvatarModelPrefetch = require(ProfilePlatformParent.EditProfileBackground).AvatarModelPrefetch

local ProfilePlatformPage = require(script.Parent.ProfilePlatformPage)
local getProfilePlatform = require(ProfilePlatform.Networking.getProfilePlatform)

return function()
    local var1, var2 = React.useState(true)

    local var3 = useProfileWrapperContext()
    local var4 = useProfileAnalyticsContext()

    local profileId = var3.profileId
    local profileType = var3.profileType
    local var5 = if FFlagAXEnableProfileTab then useIsMeTab() else nil
    local var6 = useLocalUserId()
    local bool4 = tostring(profileId) == tostring(var6)

    local var7 = useDispatch()
    local var8 = if FFlagProfilePlatformTrustedConnectionsMVP then Navigation.useNavigation() else nil
    local var9 = useProfileJson()

    local var10 = useAvailableComponents()
    local var11 = if FFlagProfilePlatformRefreshActionsRespectPolicies then useActionsComponentRequest() else nil
    local var12 = React.useRef(0)

    local function func1(reloadCount: number?)
        local var13 = SocialStopwatch.Stopwatch.get(SocialStopwatch.Events.ProfileOpened)

        var4.fireAnalyticsEvent(
            EventNames.ProfileLoadingStage,
            {
                statValue = if var13 then var13.timeElapsed else nil,
                status = LoadingStages.Fetching,
                isProfilePlatform = true
            }
        )

        var7(
            getProfilePlatform.API({
                profileId = profileId,
                profileType = profileType,
                components = var10,
                includeComponentOrdering = true,
                onlyEssentialComponents = if FFlagProfilePlatformEnableLazyLoadingComponents then true else nil
            })
        ):andThen(
            function(arg1)
                if FFlagProfilePlatformEnableLazyLoadingComponents then
                    var2(false)
                end

                if FFlagProfilePlatformEnableVR and reloadCount > 1 then
                    var4.fireAnalyticsEvent(EventNames.ProfilePlatformPageReloaded, { reloadCount = reloadCount })

                    return
                end

                local deepValue = getDeepValue(arg1, `responseBody.components.{Enums.Components.Actions}.buttons`)
                local type = if deepValue and deepValue[1] then deepValue[1].type else nil

                if FFlagProfilePlatformTrustedConnectionsMVP
                    and getFriendStatusFromProfileResponse(arg1) == Enums.FriendStatus.Friends
                    and not getIsTrustedConnectionsStatusFromProfileResponse(arg1)
                    and var3.sourceInfo.source == Enums.Sources.QrCode
                then
                    var7(checkQrSession.API(profileId)):andThen(function(arg2)
                        if arg2.responseBody ~= true then
                            return
                        end

                        var8.push(RobloxAppEnums.AppPage.TrustedContactsModal, {
                            props = {
                                userId = profileId,
                                sentFromQrCode = true,
                                onRequestSent = function()
                                    return var7(refreshProfilePlatformActionInfo(profileId, var11))
                                end
                            }
                        })
                    end)
                end

                var4.fireAnalyticsEvent(EventNames.ProfilePageLoadedWithData, {
                    friendStatus = getFriendStatusFromProfileResponse(arg1),
                    absolutePosition = var3.sourceInfo.homepageCarouselAbsolutePosition,
                    isHomePageCarousel = var3.sourceInfo.source == Enums.Sources.HomepageFriendsCarousel,
                    source = var3.sourceInfo.source,
                    isRecommendation = var3.sourceInfo.isRecommendation,
                    var3.sourceInfo.recommendationContextType,
                    recommendationRank = var3.sourceInfo.recommendationRank,
                    recommendationSessionId = var3.sourceInfo.recommendationSessionId,
                    shareLinkId = var3.sourceInfo.shareLinkId,
                    primaryAction = type
                })
            end
        ):catch(
            function(_)
                var4.fireAnalyticsEvent(
                    EventNames.ProfileLoadingStage,
                    {
                        statValue = if var13 then var13.timeElapsed else nil,
                        status = LoadingStages.Failed,
                        isProfilePlatform = true
                    }
                )
            end
        )
        if not FFlagProfilePlatformEnableLazyLoadingComponents then
            return
        end

        var7(
            getProfilePlatform.API({
                profileId = profileId,
                profileType = profileType,
                components = var10,
                includeComponentOrdering = true,
                onlyEssentialComponents = false
            })
        ):andThen(
            function(_)
                var4.fireAnalyticsEvent(EventNames.ProfileLoadingStage, {
                    statValue = if var13 then var13.timeElapsed else nil,
                    status = LoadingStagesExtension.LazyLoaded,
                    isProfilePlatform = true
                })
            end
        ):catch(
            function(_)
                var4.fireAnalyticsEvent(
                    EventNames.ProfileLoadingStage,
                    {
                        statValue = if var13 then var13.timeElapsed else nil,
                        status = LoadingStages.Failed,
                        isProfilePlatform = true
                    }
                )
            end
        )
    end
    useEffectOnMount(function()
        if profileType ~= Enums.ProfileTypes.User then
            return
        end
        local var13 = tonumber(profileId)
        if var13 then
            AvatarModelPrefetch.prefetch(var13)
        end
    end)

    if bool2 then
        local current = useSignalState(ProfileRefreshSignal.getProfileRefreshSignal)
        local var14 = React.useRef(0)

        React.useEffect(function()
            if bool4 and current > var14.current then
                var14.current = current
                func1()
            end
        end, {
            current,
            bool4,
            profileId,
            func1
        })
    end
    if FFlagProfilePlatformEnableVR then
        React.useEffect(function()
            local current = var12.current + 1
            var12.current = current
            func1(current)
        end, { var10 })
    else
        useEffectOnMount(function()
            func1()
        end)
    end

    React.useEffect(function()
        return function()
            SocialStopwatch.Stopwatch.stop(SocialStopwatch.Events.ProfileOpened)

            var4.fireAnalyticsEvent(EventNames.ProfileClosed)
        end
    end, {})

    if bool1 then
        useEffectOnMount(function()
            IXPService:LogFlagLinkedUserLayerExposure(layerName)
            IXPService:LogFlagLinkedUserLayerExposure(layerName2)
            if bool4 then
                IXPService:LogFlagLinkedUserLayerExposure(layerName3)
            end
        end)
    end

    if FFlagJoinUserCTAsIxpEnabled then
        useEffectOnMount(function()
            if profileType == Enums.ProfileTypes.User and not bool4 then
                IXPServiceWrapper:LogFlagLinkedUserLayerExposure(FStringJoinUserCTAsIxpLayer)
            end
        end)
    end

    if bool3 then
        React.useEffect(function()
            local metadata = nil
            if SessionService:SessionExists(SessionType.StructuralIdentifier.ProfilePlatformPage) then
                metadata = SessionService:GetMetadata(
                    SessionType.StructuralIdentifier.ProfilePlatformPage,
                    SessionType.Metadata.ProfilePlatformPage.ProfileSessionId
                )
            else
                SessionService:SetSession(
                    SessionType.StructuralIdentifier.Level2a,
                    SessionType.StructuralIdentifier.ProfilePlatformPage,
                    SessionType.StructuralIdentifier.ProfilePlatformPage
                )
            end
            SessionService:SetMetadata(
                SessionType.StructuralIdentifier.ProfilePlatformPage,
                SessionType.Metadata.ProfilePlatformPage.ProfileSessionId,
                var3.profileSessionId
            )

            return function()
                if metadata ~= nil then
                    SessionService:SetMetadata(
                        SessionType.StructuralIdentifier.ProfilePlatformPage,
                        SessionType.Metadata.ProfilePlatformPage.ProfileSessionId,
                        metadata
                    )
                    return
                end

                SessionService:RemoveSession(SessionType.StructuralIdentifier.ProfilePlatformPage)
            end
        end, {})
    end

    local source = if FFlagProfilePlatformEnableMoments then var3.sourceInfo.source else nil
    local useMemo = React.useMemo

    local function func2()
        return Cryo.Dictionary.union(
            parseComponentsFromJson(
                var9.components,
                var9.componentOrdering,
                profileType,
                source,
                if FFlagAXEnableProfileTab then var5 else nil
            ),
            {
                ProfilePlatformEventReceiver = React.createElement(ProfilePlatformEventReceiver)
            }
        )
    end
    local components = var9.components
    local componentOrdering = var9.componentOrdering
    local var13 = if FFlagAXEnableProfileTab then var5 else nil
    local var14 = useMemo(func2, { components, componentOrdering, source, var13, profileType })

    return React.createElement(
        ProfilePlatformPage,
        {
            children = FFlagProfilePlatformEnableLazyLoadingComponents and var1 and {} or var14
        }
    )
end
