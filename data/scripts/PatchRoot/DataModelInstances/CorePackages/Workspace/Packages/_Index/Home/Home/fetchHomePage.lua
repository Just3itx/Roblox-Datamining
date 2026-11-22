-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Home = script:FindFirstAncestor("Home")
local HomeParent = Home.Parent

local AppPage = require(HomeParent.RobloxAppEnums).AppPage
local DiscoveryAvailability = require(HomeParent.DiscoveryAvailability)
local RetrievalStatus = require(HomeParent.Http).Enum.RetrievalStatus
local Promise = require(HomeParent.Promise)
local SetPageSessionTimestamp = require(HomeParent.PageSessionRodux).SetPageSessionTimestamp
local SduiCoreSystem = require(HomeParent.SduiCoreSystem)
local getSduiServiceDependenciesStore = SduiCoreSystem.getSduiServiceDependenciesStore
local SduiPoolStore = SduiCoreSystem.SduiPoolStore
local SduiLogger = SduiCoreSystem.SduiLogger
local SduiErrors = SduiCoreSystem.SduiErrors
local SduiParseHelpers = SduiCoreSystem.SduiParseHelpers
local OneByTwoTileTelemetry = require(HomeParent.SponsoredTilesTelemetry).OneByTwoTileTelemetry
local SduiSharedUtilities = require(HomeParent.SduiSharedUtilities)
local SduiResponseType = SduiSharedUtilities.SduiResponseType
local getSduiApiStore = SduiSharedUtilities.getSduiApiStore
local getSduiTemplateStore = SduiSharedUtilities.getSduiTemplateStore
local SduiApiStorePostConfigContentType = SduiSharedUtilities.SduiApiStorePostConfigContentType
local SduiCapabilities = SduiSharedUtilities.SduiCapabilities
local GetStartupStore = require(HomeParent.StartupStore).GetStartupStore

local HomeConstants = require(Home.HomeConstants)
local HomePageFocusedFetchUtils = require(Home.HomePageFocusedFetchUtils)
local HomePageSession = require(Home.HomePageSession)
local HomeOmniFeedCache = require(HomeParent.DiscoveryUtils).HomeOmniFeedCache
local SduiHomePageCachePayload = require(Home.SduiHomePageCachePayload)
local getHomePageUrl = require(Home.getHomePageUrl)
local buildHomePageRequest = require(Home.buildHomePageRequest)
local buildHomeFeedStats = require(Home.buildHomeFeedStats)
local measureHomeCollectionLayout = require(Home.measureHomeCollectionLayout)
local writeHomePageSduiPrefetchDescriptor = require(Home.writeHomePageSduiPrefetchDescriptor)
local writeHomePageSduiPrefetchClientCapabilities = require(Home.writeHomePageSduiPrefetchClientCapabilities)
local PrefetchProtocol = require(HomeParent.PrefetchProtocol).PrefetchProtocol
local FriendRecommendations = require(HomeParent.DataHydration.FriendsRecommendations).FriendRecommendations

local SharedFlags = require(HomeParent.SharedFlags)
local FFlagEnableHomePageSduiPrefetch = SharedFlags.FFlagEnableHomePageSduiPrefetch
local FFlagUseSignalsForStartup = SharedFlags.FFlagUseSignalsForStartup
local FFlagSduiAdvertiseRuntimeSupportSets = SharedFlags.FFlagSduiAdvertiseRuntimeSupportSets

local FFlagHomePageSduiPrefetchExtendedClientCapabilities = SharedFlags.FFlagHomePageSduiPrefetchExtendedClientCapabilities
local FFlagLuaAppSduiHomePageSupport = SharedFlags.FFlagLuaAppSduiHomePageSupport
local FFlagLuaAppSduiHomeFeedStats = SharedFlags.FFlagLuaAppSduiHomeFeedStats
local FFlagLuaAppAddHasOneByTwoFieldSdui = SharedFlags.FFlagLuaAppAddHasOneByTwoFieldSdui
local FFlagSduiPerSectionPoolSizing = SharedFlags.FFlagSduiPerSectionPoolSizing
local FFlagLuaAppEnableOneByTwoTileFunnelTelemetrySdui = SharedFlags.FFlagLuaAppEnableOneByTwoTileFunnelTelemetrySdui
local FFlagLuaAppHomeMomentVideoFallback = SharedFlags.FFlagLuaAppHomeMomentVideoFallback
local FFlagLuaAppSduiGameTileFooterTrailingComponent = SharedFlags.FFlagLuaAppSduiGameTileFooterTrailingComponent
local FFlagSduiUniverseItemConnectionsPlayed = SharedFlags.FFlagSduiUniverseItemConnectionsPlayed
local FFlagSduiActiveFriendsFooterTreatment = SharedFlags.FFlagSduiActiveFriendsFooterTreatment

local function resolveRequestIntent(str1: string?, bool1: boolean?) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(str1) == "string" and str1 ~= "" then
        return str1
    end

    if bool1 then
        return HomeConstants.RequestIntent.ManualRefresh
    end

    return HomeConstants.RequestIntent.LogIn
end

local function createHomePageRequestConfig(tbl1, tbl2)
    local homeApi = tbl1.homeApi
    return {
        responseType = SduiResponseType.Protobuf,
        url = getHomePageUrl(),
        surfaceKey = AppPage.Home,
        configKey = tbl2.configKey,
        loadTimer = tbl1.pageTimer,
        apiProto = homeApi.HomePageResponse,
        postConfig = {
            contentType = SduiApiStorePostConfigContentType.Proto,
            protoMessage = homeApi.HomePageRequest,
            body = buildHomePageRequest(homeApi, {
                sessionId = tbl2.sessionId,
                topicIds = tbl2.topicIds,
                requestIntent = tbl1.requestIntent,
                contextualFeatures = tbl1.contextualFeatures,
                cachedRobloxComponentToTemplateId = getSduiTemplateStore().getCachedRobloxComponentToTemplateId(AppPage.Home),
                clientCapabilities = tbl1.clientCapabilities,
                collectionLayout = tbl1.collectionLayout
            })
        },
        enableTemplateCache = true,
        enableStreaming = false,
        allowNoConfigsBuilt = true
    }
end

local function readRequestId(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local requestId = if type(arg1) == "table" then arg1.request_id else nil
    return if requestId == nil or requestId == "" then nil else requestId
end

local function hasOneByTwoInResponse(arg1)
    if type(arg1) ~= "table" then
        return false
    end
    for _, value in arg1.page_entries or {} do
        local inputData = value.input_data
        local value2 = if inputData and inputData.kind then inputData.kind.value else nil
        local contentPools = if value2 then value2.content_pools else nil

        if not contentPools then
            continue
        end

        for _, contentPool in contentPools do
            for _, value3 in contentPool.items or {} do
                local layout = value3.layout
                local colSpan = if layout then layout.col_span or 1 else nil

                if layout and layout.row_span == 2 and colSpan == 1 then
                    return true
                end
            end
        end
    end
    return false
end

local function readFriendRecommendations(arg1)
    local hydrationData = if type(arg1) == "table" then arg1.hydration_data else nil
    local friendRecommendation = if type(hydrationData) == "table" then hydrationData.friend_recommendation else nil

    if type(friendRecommendation) == "table" then
        return (FriendRecommendations.mapFromProto(friendRecommendation))
    end

    return {}
end

local sduiPoolStore = nil

local function registerOneByTwoTileFunnelListener() -- Luacid: Inlined by compiler; 1 call site recovered
    sduiPoolStore = SduiPoolStore.getSduiPoolStore(HomeConstants.ConfigKey)
    sduiPoolStore.setOneByTwoTileFunnelListener(
        {
            onPlaced = OneByTwoTileTelemetry.logOneByTwoTilePlaced,
            onSkipped = OneByTwoTileTelemetry.logOneByTwoTileSkipped
        }
    )
end

local function logOneByTwoTileResponseReceivedFromDecodedResponse(arg1)
    if type(arg1) ~= "table" then
        return
    end
    for _, value in arg1.page_entries or {} do
        local value2 = value.input_data and value.input_data.kind and value.input_data.kind.value
        local contentPools = value2 and value2.content_pools
        if not contentPools then
            continue
        end

        for _, value3 in SduiCoreSystem.getOneByTwoTileFlowIdsFromPools(contentPools) do
            OneByTwoTileTelemetry.logOneByTwoTileResponseReceived({
                oneByTwoTileFlowId = value3.oneByTwoTileFlowId,
                contentType = value3.contentType,
                adId = value3.adId,
                alignmentType = value3.alignmentType,
                componentType = "OneByTwoTile",
                isSdui = true
            })
        end
    end
end

local function commitHomeSession(_, arg1)
    if not HomePageSession:Commit((readRequestId(arg1))) then
        return
    end

    local var1 = getSduiServiceDependenciesStore().getDependencies(AppPage.Home)
    assert(var1, "dependencies is nil")
    var1.dispatch(SetPageSessionTimestamp(AppPage.Home))
end

local function setHomePageDataSource(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    DiscoveryAvailability.Signals.getCacheStore().setHomePageDataSource(str1)
end

local function isServingCachedHomePage(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return DiscoveryAvailability.Signals.getCacheStore().getHomePageDataSource(false) == "Cache"
end

local function setHomePageDataStatuses(status: string)
    if FFlagUseSignalsForStartup then
        GetStartupStore(false).setHomePageDataStatus(status)
        GetStartupStore(false).setFetchHomePageDataStatusAll(status)
        return
    end
    local var1 = getSduiServiceDependenciesStore().getDependencies(AppPage.Home)
    if var1 == nil then
        return
    end
    var1.dispatch({ type = "SetHomePageDataStatus", status = status })
    var1.dispatch({ type = "SetFetchHomePageDataStatusAll", status = status })
end

local function fetchHomePage(pageTimer, tbl1)
    if FFlagLuaAppEnableOneByTwoTileFunnelTelemetrySdui then
        registerOneByTwoTileFunnelListener()
    end

    local configKey = HomeConstants.ConfigKey
    local sduiApiStore = getSduiApiStore()
    local forceRefresh = if tbl1 then tbl1.forceRefresh else nil
    local contextualFeatures = if tbl1 then tbl1.contextualFeatures else nil
    local requestIntent = if tbl1 then tbl1.requestIntent else nil
    local var1 = resolveRequestIntent(requestIntent, forceRefresh)
    local focusedRefresh = if tbl1 then tbl1.focusedRefresh else nil
    local _, var2 = sduiApiStore.getData(configKey)
    if (forceRefresh or var2) and not (sduiApiStore.isInFlight(configKey) or focusedRefresh) then
        setHomePageDataStatuses(RetrievalStatus.Fetching)

        local bool1 = false
        if FFlagEnableHomePageSduiPrefetch and HomePageSession:GetCommitted() == nil then
            local var3 = PrefetchProtocol.default:popPendingPrefetchGuid()
            if var3 ~= nil then
                bool1 = HomePageSession:Adopt(var3)
            end
        end
        if not bool1 then
            HomePageSession:Refresh()
        end
    end

    local serviceContractsProto = require(HomeParent.ServiceContractsProto)
    local homePage = serviceContractsProto.apppageplatform.home.home_page
    local clientCapabilities = serviceContractsProto.apppageplatform.shared.client_capabilities.ClientCapabilities
    local var3, var4

    if FFlagSduiAdvertiseRuntimeSupportSets then
        var3 = SduiCapabilities.getEnabledCapabilityNumbersWithoutExtendedMarker()
        var4 = SduiCapabilities.buildClientCapabilities()
    else
        var3 = SduiCapabilities.getEnabledCapabilityNumbers({
            "CAPABILITY_SUPPORTS_HYDRATION_CLIENT_HINTS",
            if FFlagSduiPerSectionPoolSizing then "CAPABILITY_SUPPORTS_MULTI_SIZE_POOL" else nil,
            if FFlagLuaAppHomeMomentVideoFallback then "CAPABILITY_SUPPORTS_VIDEO_PLAYER_ACCESS_CONTEXT" else nil,
            if FFlagSduiUniverseItemConnectionsPlayed then "CAPABILITY_SUPPORTS_UNIVERSE_ITEM_CONNECTIONS_PLAYED" else nil,
            if FFlagLuaAppSduiGameTileFooterTrailingComponent then "CAPABILITY_SUPPORTS_GAME_TILE_FOOTER_TRAILING_COMPONENT" else nil,
            if FFlagSduiActiveFriendsFooterTreatment then "CAPABILITY_SUPPORTS_GAME_TILE_ACTIVE_FRIENDS_TREATMENT" else nil
        })

        var4 = clientCapabilities.new({ enabled_capabilities = var3 })
    end

    local collectionLayout = if FFlagEnableHomePageSduiPrefetch then measureHomeCollectionLayout() else nil
    local tbl2 = {
        pageTimer = pageTimer,
        homeApi = homePage,
        requestIntent = var1,
        contextualFeatures = contextualFeatures,
        clientCapabilities = var4,
        collectionLayout = collectionLayout
    }
    local var6 = if focusedRefresh then HomePageFocusedFetchUtils.register(focusedRefresh) else nil

    if focusedRefresh and var6 == nil then
        return Promise.resolve(false), configKey
    end

    local homePageRequestConfig = createHomePageRequestConfig(tbl2, {
        configKey = configKey,
        sessionId = HomePageSession:Get(),
        topicIds = focusedRefresh and { focusedRefresh.topicId } or nil
    })
    homePageRequestConfig.mergeStrategy = SduiSharedUtilities.streamingFeedMergeStrategy
    if var6 then
        HomePageFocusedFetchUtils.applyToRequestConfig(homePageRequestConfig, var6)
    end

    if var6 == nil then
        function homePageRequestConfig.onSuccess(arg1, arg2)
            if FFlagLuaAppSduiHomePageSupport then
                FriendRecommendations.getStore().replaceFriendRecommendations((readFriendRecommendations(arg2)))
            end
            commitHomeSession(arg1, arg2)
            if FFlagLuaAppSduiHomeFeedStats then
                SduiLogger.reportSduiV2FeedStats(
                    buildHomeFeedStats(arg2),
                    AppPage.Home,
                    readRequestId(arg2),
                    nil,
                    if FFlagLuaAppAddHasOneByTwoFieldSdui then hasOneByTwoInResponse(arg2) else nil
                )
            end

            if FFlagLuaAppEnableOneByTwoTileFunnelTelemetrySdui then
                local success, result = pcall(function()
                    logOneByTwoTileResponseReceivedFromDecodedResponse(arg2)
                    return nil
                end)
                if not success then
                    SduiLogger.reportError(
                        SduiErrors.SduiErrorType.CodeError,
                        {
                            name = "OneByTwoTileResponseReceived",
                            message = SduiParseHelpers.stringifyValue(result)
                        },
                        AppPage.Home
                    )
                end
            end

            setHomePageDataStatuses(RetrievalStatus.Done)
            if arg2 then
                task.defer(function()
                    local sduiHomePageCachePayload = SduiHomePageCachePayload.buildSduiHomePageCachePayload(arg2)
                    if sduiHomePageCachePayload then
                        HomeOmniFeedCache.cacheSduiHomePageData(SduiHomePageCachePayload.serializeSduiHomePageCache(sduiHomePageCachePayload))
                    end
                end)

                setHomePageDataSource("API")
            end

            if not FFlagEnableHomePageSduiPrefetch then
                return
            end

            if FFlagHomePageSduiPrefetchExtendedClientCapabilities then
                writeHomePageSduiPrefetchClientCapabilities(var4)
                return
            end
            writeHomePageSduiPrefetchDescriptor(var3)
        end

        homePageRequestConfig.recoverFromError = {
            getDecodedResponse = function()
                return SduiHomePageCachePayload.deserializeSduiHomePageCache(HomeOmniFeedCache.getCachedSduiHomePageData())
            end,
            onApplied = function()
                setHomePageDataSource("Cache")
                setHomePageDataStatuses(RetrievalStatus.Done)
            end
        }

        function homePageRequestConfig.refresh(arg1)
            return (fetchHomePage(arg1, { forceRefresh = true, contextualFeatures = contextualFeatures }))
        end
    end

    local var7 = sduiApiStore.fetchIfNeeded(homePageRequestConfig, if var6 then true else forceRefresh)

    if var6 then
        return HomePageFocusedFetchUtils.resolve(var7, var6), configKey
    end

    return var7 and var7:catch(function(_)
        if not isServingCachedHomePage() then
            setHomePageDataStatuses(RetrievalStatus.Failed)
        end
    end), configKey
end

return fetchHomePage
