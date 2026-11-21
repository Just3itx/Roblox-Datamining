-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local AppStorageService = game:GetService("AppStorageService")
local MessageBusService = game:GetService("MessageBusService")
local scriptParentParentParent = scriptParentParent.Parent

local dependencies = require(scriptParentParent.dependencies)

local React = require(scriptParentParentParent.React)
local Dash = require(scriptParentParentParent.Dash)
local Cryo = require(scriptParentParentParent.Cryo)
local RobloxAppHooks = require(scriptParentParentParent.RobloxAppHooks)
local SocialCommon = require(scriptParentParentParent.SocialCommon)
local useQuery = require(scriptParentParentParent.ApolloClient).useQuery
local ApolloLocalState = require(scriptParentParentParent.ApolloLocalState)
local ApolloFriends = require(scriptParentParentParent.ApolloFriends)
local queries = ApolloLocalState.queries
local SocialLuaAnalytics = require(scriptParentParentParent.SocialLuaAnalytics)
local AnalyticsFactory = SocialLuaAnalytics.Analytics.AnalyticsFactory
local DefaultAnalyticsService = SocialLuaAnalytics.Analytics.DefaultAnalyticsService
local EventTypes = SocialLuaAnalytics.Analytics.Enums.EventTypes
local Contexts = SocialLuaAnalytics.Analytics.Enums.Contexts

local useFetchContactImporterInfoOnce = require(scriptParentParent.Utils).useFetchContactImporterInfoOnce
local useAutoSyncContacts = require(scriptParentParent.Utils).useAutoSyncContacts
local userIdExists = SocialCommon.Utils.userIdExists
local PermissionsProtocol = require(scriptParentParentParent.PermissionsProtocol).PermissionsProtocol
local UserProfiles = require(scriptParentParentParent.UserProfiles)

local useLocalUserId = RobloxAppHooks.useLocalUserId

local UniversalAppPolicy = dependencies.UniversalAppPolicy
local getAppFeaturePolicies = require(scriptParentParentParent.UniversalAppPolicy).getAppFeaturePolicies

local PaginatedFriendsCarouselIXP = require(scriptParentParent.Experiments.PaginatedFriendsCarouselIXP)

local bool1 = game:DefineFastFlag("EarlierFetchTimeForFriendsCarousel_v1", false)
local bool2 = game:DefineFastFlag("PrefetchProfileNamesOnStartup_v2", false)

local FIntFriendsCarouselInitialFetchSize = require(scriptParentParentParent.SharedFlags).FIntFriendsCarouselInitialFetchSize

local FFlagRegisterQRCodeKeyInEngine = require(scriptParentParentParent.SharedFlags).FFlagRegisterQRCodeKeyInEngine

local FFlagAddFriendsPageHighlightUnseenTrustedRequests = require(scriptParentParentParent.SharedFlags).FFlagAddFriendsPageHighlightUnseenTrustedRequests

local FFlagSocialCarouselMigrateRecommendations = require(scriptParentParentParent.SharedFlags).FFlagSocialCarouselMigrateRecommendations

local FFlagFriendSortedByPresenceSignalsImplementation = require(scriptParentParentParent.SharedFlags).FFlagFriendSortedByPresenceSignalsImplementation

local useSignalState = require(scriptParentParentParent.SignalsReact).useSignalState
local var1 = require(scriptParentParentParent.DataHydration).Friends.FriendsStore.get()
local FriendsRequests = require(scriptParentParentParent.DataHydration.FriendsRequests)
local FriendsRequestsStore = FriendsRequests.FriendsRequestsStore
local UnseenRequestsStore = FriendsRequests.UnseenRequestsStore

local FriendsRecommendations = require(scriptParentParentParent.DataHydration.FriendsRecommendations)
local FriendsRecommendationsStore = FriendsRecommendations.FriendsRecommendationsStore
local DataSource = FriendsRecommendations.Enums.DataSource

local key = if FFlagRegisterQRCodeKeyInEngine then "ProfileQrCodeCameraSettingsModalSeen" else "ScreenshotEventTracking"

local messageId = MessageBusService:GetMessageId("Realtime", "appResume")
local var2 = if bool2 then UserProfiles.Stores.UserProfileStore.get() else nil
local EventStream = {
    ProfileQRCodeCameraSettingsModalSeen = {
        context = Contexts.ProfileQRCode,
        eventType = EventTypes.SettingsModalSeenSinceLastAppStart,
        formatRulesForAdditionalInfo = {
            cameraPermissionResponseStatus = Dash.identity
        }
    }
}

return UniversalAppPolicy.connect(function(arg1)
    return {
        isContactImporterPolicyEnabled = arg1.getContactImporterEnabled()
    }
end)(function(tbl2) -- name: Container
    local userId = useLocalUserId()

    local policyIsEnabled = tbl2.isContactImporterPolicyEnabled or getAppFeaturePolicies().getContactImporterEnabled()

    useFetchContactImporterInfoOnce({ policyIsEnabled = policyIsEnabled })

    local var5 = nil
    local friends = nil
    if bool1 then
        local var6, var7 = PaginatedFriendsCarouselIXP.usePaginatedFriendsCarouselExperiment()
        local variables = {
            userId = userId,
            sort = var6 and var7 or ApolloFriends.Enums.Sort.FriendshipScore
        }

        if FFlagFriendSortedByPresenceSignalsImplementation then
            local var8 = React.useMemo(function()
                return var1.GetAllFriends()
            end, {})

            local var9 = useSignalState(var8)
            friends = var9 and var9.friends or nil

            React.useEffect(function()
                var1.GetOnlineFriends()
            end, {})
        else
            var5 = useQuery(queries.allFriendsByUserId, {
                errorPolicy = "all",
                skip = not (var6 and userIdExists(userId)),
                notifyOnNetworkStatusChange = true,
                variables = Cryo.Dictionary.join(variables, { pageLimit = FIntFriendsCarouselInitialFetchSize, pageCursor = "" })
            })

            useQuery(
                queries.onlineFriendsByUserId,
                {
                    skip = not (var6 and userIdExists(userId)),
                    notifyOnNetworkStatusChange = true,
                    variables = variables
                }
            )
        end
    end

    if bool2 then
        if not FFlagFriendSortedByPresenceSignalsImplementation then
            friends = var5 and var5.data and var5.data.allFriendsByUserId and var5.data.allFriendsByUserId.friends
        end
        React.useEffect(function()
            if not userIdExists(userId) then
                return
            end

            local tbl3 = { tostring(userId) }

            if friends then
                for _, friend in friends do
                    if friend and friend.id then
                        table.insert(tbl3, tostring(friend.id))
                    end
                end
            end

            var2.fetchNamesByUserIds(tbl3)
        end, { userId, friends })
    end

    if FFlagSocialCarouselMigrateRecommendations then
        React.useEffect(function()
            if getAppFeaturePolicies().getSocialGraphSyncEnabled() then
                FriendsRecommendationsStore.get().getFriendsRecommendations(DataSource.HomepageFriendsCarousel)
            end
        end, { userId })
    end
    useAutoSyncContacts(policyIsEnabled)

    React.useEffect(function()
        if userIdExists(userId) then
            var1.GetFriendsCountByUserId(tostring(userId))
        end
    end, { userId })

    React.useEffect(function()
        if not userIdExists(userId) then
            return function() end
        end

        if FFlagAddFriendsPageHighlightUnseenTrustedRequests then
            UnseenRequestsStore.get().getUnseenRequestCount()
        else
            FriendsRequestsStore.get().getNewFriendsRequestCount()
        end
        local var6 = MessageBusService:Subscribe(messageId, function()
            if FFlagAddFriendsPageHighlightUnseenTrustedRequests then
                UnseenRequestsStore.get().refetchUnseenRequestCount()
                return
            end
            FriendsRequestsStore.get().refetchNewFriendRequestCount()
        end, false, true)
        return function()
            var6:Disconnect()
        end
    end, { userId })

    local var6 = React.useMemo(function()
        return AnalyticsFactory.setUpAnalyticsFactory(
            {
                eventLists = { EventStream = EventStream },
                analyticsImpl = {
                    EventStream = DefaultAnalyticsService.EventStream
                }
            }
        )()
    end, {})
    React.useEffect(function()
        if AppStorageService:GetItem(key) ~= "true" then
            return
        end

        PermissionsProtocol.default:checkOrRequestPermissions({ PermissionsProtocol.Permissions.CAMERA_ACCESS }):andThen(
            function(cameraPermissionResponseStatus)
                var6.fireAnalyticsEvent(
                    "ProfileQRCodeCameraSettingsModalSeen",
                    { cameraPermissionResponseStatus = cameraPermissionResponseStatus }
                )
            end
        )

        AppStorageService:SetItem(key, "false")
        AppStorageService:Flush()
    end, { userId, var6 })

    return nil
end)
