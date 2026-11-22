-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperienceJoin = script:FindFirstAncestor("SocialExperienceJoin")
local SocialExperienceJoinParent = SocialExperienceJoin.Parent

local GameLaunch = require(SocialExperienceJoinParent.GameLaunch)
local LuaSocialLibrariesDeps = require(SocialExperienceJoinParent.LuaSocialLibrariesDeps)
local NavigationRodux = require(SocialExperienceJoinParent.NavigationRodux)
local Promise = require(SocialExperienceJoinParent.Promise)
local React = require(SocialExperienceJoinParent.React)
local RoactServiceTags = require(SocialExperienceJoinParent.RoactServiceTags)
local RoactUtils = require(SocialExperienceJoinParent.RoactUtils)
local RobloxAppEnums = require(SocialExperienceJoinParent.RobloxAppEnums)
local RobloxAppHooks = require(SocialExperienceJoinParent.RobloxAppHooks)
local RobloxAppSessionization = require(SocialExperienceJoinParent.RobloxAppSessionization)
local Games = require(SocialExperienceJoin.Rodux.Games)

local EventNames = require(SocialExperienceJoin.Analytics.EventNames)
local JoinExperienceStatus = require(SocialExperienceJoin.Analytics.JoinExperienceStatus)

local initializeSocialExperienceJoinAnalytics = require(SocialExperienceJoin.Analytics.initializeSocialExperienceJoinAnalytics)
local Constants = require(SocialExperienceJoin.Common.Constants)
local NetworkingGames = require(SocialExperienceJoin.Networking.NetworkingGames)
local myRoduxNetworking = require(SocialExperienceJoin.Networking.myRoduxNetworking)

local useAgeCheckUpsellState = require(script.Parent.useAgeCheckUpsellState)

local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local PlayabilityStatus = Games.Enums.PlayabilityStatus

local NetworkStatus = myRoduxNetworking.Enum.NetworkStatus
local LaunchGame = GameLaunch.LaunchGame
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch

local SetGamePlaySession = RobloxAppSessionization.SetGamePlaySession
local SessionType = RobloxAppSessionization.SessionType
local AppSessionService = RoactServiceTags.AppSessionService
local useRoactService = RobloxAppHooks.useRoactService

local AppPage = RobloxAppEnums.AppPage
local NavigateDown = NavigationRodux.Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(SocialExperienceJoinParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(SocialExperienceJoinParent.RobloxAppNavigation).NavigationCommands else nil
local AppGame = RoactServiceTags.AppGame

local useLocalUserId = RobloxAppHooks.useLocalUserId
local getDeepValue = LuaSocialLibrariesDeps.SocialLibraries.config({}).Dictionary.getDeepValue

local FFlagProfilePlatformImproveGameDetailsAnalytics = require(SocialExperienceJoinParent.SharedFlags).FFlagProfilePlatformImproveGameDetailsAnalytics
local FFlagGameJoinCardSourceAttribution = require(SocialExperienceJoinParent.SharedFlags).FFlagGameJoinCardSourceAttribution
local FFlagJoinabilityCTARefactor = require(SocialExperienceJoinParent.SharedFlags).FFlagJoinabilityCTARefactor

local FFlagSocialExperienceJoinPresenceStoreMigration = require(SocialExperienceJoin.Flags.FFlagSocialExperienceJoinPresenceStoreMigration)
local useGetPresenceByUserId = if FFlagSocialExperienceJoinPresenceStoreMigration then require(SocialExperienceJoinParent.FriendsCommon).Hooks.useGetPresenceByUserId else nil
local CentralOverlay = require(SocialExperienceJoinParent.CentralOverlay)
local SetCentralOverlay = CentralOverlay.Actions.SetCentralOverlay
local CloseCentralOverlay = CentralOverlay.Thunks.CloseCentralOverlay
local CentralOverlayType = RobloxAppEnums.CentralOverlayType

local bool1 = game:DefineFastFlag("SocialJoinUseUnifiedPurchaseFlow", false)
local bool2 = game:DefineFastFlag("GameJoinCardOnBeforeJoinCallback", false)
local bool3 = game:DefineFastFlag("SocialJoinPassPlaceIdToLaunch", false)

local tbl1 = { skipFetch = true }

return function(str1: string, tbl2)
    local var1 = useDispatch()
    local var2 = useRoactService(AppSessionService)
    local var3 = useRoactService(AppGame)
    local var4 = React.useMemo(function()
        return initializeSocialExperienceJoinAnalytics(tbl2.analyticProps)
    end, {})
    local uid = useLocalUserId()

    local var6 = if FFlagSocialExperienceJoinPresenceStoreMigration then useGetPresenceByUserId(str1, tbl1) else nil

    local var7 = useSelector(function(arg1)
        local var7 = if tbl2.presence then tbl2.presence elseif FFlagSocialExperienceJoinPresenceStoreMigration then var6 else getDeepValue(arg1, `{Constants.RODUX_KEY}.Presence.byUserId.{str1}`)
        local var8 = if var7 and var7.universeId then tostring(var7.universeId) else ""
        local isLoading = not (var8 == "")
            and (NetworkingGames.GetExperiencesPlayabilityStatus.getStatus(arg1, var8) == NetworkStatus.Fetching
                or NetworkingGames.GetExperiencesDetails.getStatus(arg1, var8) == NetworkStatus.Fetching
                or NetworkingGames.GetExperiencesProductInfo.getStatus(arg1, var8) == NetworkStatus.Fetching)
        local tbl3 = {
            universeId = var8,
            presenceType = if var7 and var7.userPresenceType then var7.userPresenceType else "",
            lastLocation = if var7 and var7.lastLocation then var7.lastLocation else nil,
            placeId = if var7 and var7.placeId then tostring(var7.placeId) else "",
            rootPlaceId = if var7 and var7.rootPlaceId then tostring(var7.rootPlaceId) else "",
            gameId = if var7 and var7.gameId then tostring(var7.gameId) else "",
            isLoading = isLoading
        }
        return tbl3
    end)

    local var8 = useAgeCheckUpsellState(var7.universeId, tbl2.onAgeCheckCompletion)

    local useCallback = React.useCallback
    local function func1(bool4: boolean)
        local function func2(universeId: string) -- Luacid: Inlined by compiler; 1 call site recovered
            return var1(NetworkingGames.GetExperiencesDetails.API({ universeId }))
        end

        local function func3(universeId: string)
            return var1(NetworkingGames.GetExperiencesProductInfo.API({ universeId }))
        end

        local function func4(status): (string?) -> () -- Luacid: Inlined by compiler; 4 call sites recovered
            return function(joinAttemptId: string?)
                SetGamePlaySession(var2, SessionType.StructuralIdentifier.GamePlayFromFriendsList, true)
                var4.fireAnalyticsEvent(EventNames.JoinExperience, {
                    placeId = var7.placeId,
                    rootPlaceId = var7.rootPlaceId,
                    gameInstanceId = var7.gameId,
                    profileUserId = str1,
                    uid = uid,
                    joinAttemptId = joinAttemptId,
                    status = status,
                    followUser = if FFlagJoinabilityCTARefactor then tostring(bool4) else nil,
                    isHomePageCarousel = tbl2.isHomePageCarousel or false,
                    absolutePosition = tbl2.homepageCarouselAbsolutePosition,
                    friendId = if FFlagProfilePlatformImproveGameDetailsAnalytics then str1 else nil
                })
            end
        end

        local function func5()
            func4(JoinExperienceStatus.PurchaseRequired)()

            Promise.all(func2(var7.universeId), func3(var7.universeId)):andThen(function()
                if not bool1 then
                    local tbl3 = {
                        name = AppPage.SocialPurchaseExperience,
                        detail = var7.universeId,
                        extraProps = {
                            userId = str1,
                            analyticProps = tbl2.analyticProps
                        }
                    }
                    if FFlagSignalsNavP3Dispatch then
                        NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl3))
                        return
                    end
                    var1(NavigateDown(tbl3))

                    return
                end

                local lastLocation = var7.lastLocation or ""

                local experienceIconUrl = string.format("rbxthumb://type=GameIcon&id=%s&w=150&h=150", var7.universeId)

                var1(
                    SetCentralOverlay(CentralOverlayType.UnifiedProductPurchaseModal, {
                        productPayload = {
                            universeId = var7.universeId,
                            kind = "Experience",
                            experienceName = lastLocation,
                            experienceIconUrl = experienceIconUrl
                        },
                        purchaseCallbacks = {
                            onFlowComplete = function()
                                var1(CloseCentralOverlay())
                            end,
                            onPurchaseSuccess = function()
                                if var8 then
                                    var8.refetchPlayability()
                                end
                            end
                        },
                        purchaseAnalyticsMetadata = { surface = "JoinUserInExperience" }
                    })
                )
            end)
        end

        local function func6()
            local var9 = if bool1 then JoinExperienceStatus.Unable else JoinExperienceStatus.PurchaseRequired
            func4(var9)(JoinExperienceStatus.Unable)

            local tbl3 = {
                name = AppPage.SocialUnableToJoinExperience,
                detail = var7.universeId,
                extraProps = {
                    userId = str1,
                    analyticProps = tbl2.analyticProps,
                    openGameDetailsPeekViewClosed = tbl2.openGameDetailsPeekViewClosed
                }
            }
            if FFlagSignalsNavP3Dispatch then
                NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl3))
                return
            end
            var1(NavigateDown(tbl3))
        end

        (function(str2: string)
            if var8 and var8.cachedPlayabilityStatus then
                return Promise.resolve(var8.cachedPlayabilityStatus)
            end
            return var1(NetworkingGames.GetExperiencesPlayabilityStatus.API({ str2 })):andThen(function(arg1)
                return arg1.responseBody[1].playabilityStatus
            end)
        end)(var7.universeId):andThen(function(arg1)
            if arg1 == PlayabilityStatus.PurchaseRequired.rawValue() then
                func5()
                return
            end

            if arg1 == PlayabilityStatus.Playable.rawValue() then
                if bool2 and tbl2.onBeforeJoin then
                    tbl2.onBeforeJoin()
                end
                local func1 = func4(JoinExperienceStatus.Success)

                LaunchGame(
                    if FFlagJoinabilityCTARefactor and not bool4 then var7.rootPlaceId elseif bool3 and var7.placeId ~= "" then var7.placeId else nil,
                    nil,
                    bool4 and { userId = str1 } or nil,
                    var3,
                    if FFlagGameJoinCardSourceAttribution then tbl2.joinAttemptOrigin or Constants.AnalyticsContext.PeopleListInHomePage else Constants.AnalyticsContext.PeopleListInHomePage,
                    func1
                )
            elseif var8 and var8.ageCheckRequired then
                var8.joinAgeCheckUpsellFlow()
            else
                func6()
            end
        end):catch(function()
            func4(JoinExperienceStatus.Failure)()
        end)
    end

    local tbl3

    if bool1 then
        tbl3 = {
            var1,
            var7.universeId,
            var7.placeId,
            var7.rootPlaceId,
            var7.gameId,
            var7.lastLocation,
            str1,
            uid,
            var4,
            var2,
            var3,
            tbl2.isHomePageCarousel,
            tbl2.homepageCarouselAbsolutePosition,
            tbl2.analyticProps,
            tbl2.openGameDetailsPeekViewClosed,
            tbl2.onBeforeJoin,
            if FFlagGameJoinCardSourceAttribution then tbl2.joinAttemptOrigin else nil,
            var8
        }
    else
        local universeId = var7.universeId
        local placeId = var7.placeId
        local rootPlaceId = var7.rootPlaceId
        local gameId = var7.gameId

        local isHomePageCarousel = tbl2.isHomePageCarousel
        local homepageCarouselAbsolutePosition = tbl2.homepageCarouselAbsolutePosition
        local joinAttemptOrigin = if FFlagGameJoinCardSourceAttribution then tbl2.joinAttemptOrigin else nil
        tbl3 = {
            var1,
            universeId,
            placeId,
            rootPlaceId,
            gameId,
            str1,
            uid,
            var4,
            var2,
            var3,
            isHomePageCarousel,
            homepageCarouselAbsolutePosition,
            joinAttemptOrigin,
            var8
        }
    end

    local var9 = useCallback(func1, tbl3)

    local joinExperience = React.useCallback(function()
        var9(true)
    end, { var9 })

    local var11 = if FFlagJoinabilityCTARefactor then React.useCallback(function()
        var9(false)
    end, { var9 }) else nil

    local isInExperience = if var7.presenceType and var7.lastLocation then var7.universeId ~= "" else false
    local isLoading = if var8 then var7.isLoading or not var8.playabilityChecked or var8.pendingParentalControlsResolution else var7.isLoading
    local useMemo = React.useMemo
    local function func2()
        return {
            joinExperience = joinExperience,
            playExperience = if FFlagJoinabilityCTARefactor then var11 else nil,
            joinAgeCheckUpsellFlow = not var8 and function() end or var8.joinAgeCheckUpsellFlow,
            ageCheckRequired = if var8 then var8.ageCheckRequired else false,
            cachedPlayabilityStatus = if var8 then var8.cachedPlayabilityStatus else nil,
            playabilityFromCache = if var8 then var8.playabilityFromCache else false,
            isInExperience = isInExperience,
            isLoading = isLoading
        }
    end

    local tbl4

    if bool1 then
        local var13 = if FFlagJoinabilityCTARefactor then var11 else nil
        tbl4 = {
            joinExperience,
            var13,
            isInExperience,
            isLoading,
            var8,
            isInExperience
        }
    else
        local presenceType = var7.presenceType
        local lastLocation = var7.lastLocation
        local var13 = if FFlagJoinabilityCTARefactor then var11 else nil
        tbl4 = {
            presenceType,
            lastLocation,
            joinExperience,
            var13,
            isLoading,
            var8,
            isInExperience
        }
    end

    return useMemo(func2, tbl4)
end
