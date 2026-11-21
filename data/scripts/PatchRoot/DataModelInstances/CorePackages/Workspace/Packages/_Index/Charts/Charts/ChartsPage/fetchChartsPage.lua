-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:30:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Charts = script:FindFirstAncestor("Charts")
local ChartsParent = Charts.Parent

local AppPage = require(ChartsParent.RobloxAppEnums).AppPage
local SduiSharedUtilities = require(ChartsParent.SduiSharedUtilities)
local SduiResponseType = SduiSharedUtilities.SduiResponseType
local getSduiApiStore = SduiSharedUtilities.getSduiApiStore
local getSduiTemplateStore = SduiSharedUtilities.getSduiTemplateStore
local getSduiClientPageScope = SduiSharedUtilities.getSduiClientPageScope
local SduiApiStorePostConfigContentType = SduiSharedUtilities.SduiApiStorePostConfigContentType
local SduiCapabilities = SduiSharedUtilities.SduiCapabilities

local ChartsPageSession = require(Charts.ChartsPage.ChartsPageSession)
local getChartsPagePostUrl = require(Charts.ChartsPage.getChartsPagePostUrl)
local getChartsPageStreamUrl = require(Charts.ChartsPage.getChartsPageStreamUrl)
local ChartsConstants = require(Charts.ChartsPage.ChartsConstants)
local ChartsPageScopeFields = require(Charts.ChartsPage.ChartsPageScopeFields)
local chartsMergeStrategy = require(Charts.ChartsPage.chartsMergeStrategy)
local buildChartsPageRequest = require(Charts.ChartsPage.buildChartsPageRequest)

local SharedFlags = require(ChartsParent.SharedFlags)
local FFlagEnableTopSongsSort = SharedFlags.FFlagEnableTopSongsSort
local GetFStringTopSongsSortExploreApiPageType = SharedFlags.GetFStringTopSongsSortExploreApiPageType
local FFlagSduiChartsRequestPlaceholders = SharedFlags.FFlagSduiChartsRequestPlaceholders
local FFlagSduiChartsPlaceholderMergeStrategySupport = SharedFlags.FFlagSduiChartsPlaceholderMergeStrategySupport
local FFlagChartsHydrationStreaming = SharedFlags.FFlagChartsHydrationStreaming
local FFlagSduiAdvertiseRuntimeSupportSets = SharedFlags.FFlagSduiAdvertiseRuntimeSupportSets

local function getCurrentFilterSelections() -- Luacid: Inlined by compiler; 1 call site recovered
    return getSduiClientPageScope(ChartsConstants.ConfigKey).get(ChartsPageScopeFields.FilterSelections)
end

local function getCurrentPageType() -- Luacid: Inlined by compiler; 1 call site recovered
    if FFlagEnableTopSongsSort then
        return (GetFStringTopSongsSortExploreApiPageType())
    end

    return nil
end

local function extractNextFeedPageToken(arg1)
    local pageEntries = arg1 and arg1.page_entries
    if not pageEntries then
        return nil
    end
    for _, value in pageEntries do
        local pageEntry = value.page_entry
        if not pageEntry or pageEntry.identifier ~= "charts_feed" then
            continue
        end

        local inputData = value.input_data
        local kind = inputData and inputData.kind
        local value2 = kind and kind.value
        local nextPageToken = value2 and value2.next_page_token
        if nextPageToken and nextPageToken ~= "" then
            return nextPageToken
        end
    end

    return nil
end

local function fetchChartsPage(loadTimer, bool1: boolean?)
    local configKey = ChartsConstants.ConfigKey
    local sduiApiStore = getSduiApiStore()

    local _, bool2 = sduiApiStore.getData(configKey)
    if bool1 or bool2 then
        bool2 = not sduiApiStore.isInFlight(configKey)
    end

    if bool2 then
        ChartsPageSession:Refresh()
    end

    local url = if FFlagChartsHydrationStreaming then getChartsPageStreamUrl() else getChartsPagePostUrl()
    local serviceContractsProto = require(ChartsParent.ServiceContractsProto)
    local chartsPage = serviceContractsProto.apppageplatform.charts.charts_page
    local clientCapabilities = serviceContractsProto.apppageplatform.shared.client_capabilities.ClientCapabilities
    local clientCapabilities2 = if FFlagSduiAdvertiseRuntimeSupportSets then SduiCapabilities.buildClientCapabilities() else clientCapabilities.new(
        {
            enabled_capabilities = SduiCapabilities.getEnabledCapabilityNumbers({ "CAPABILITY_SUPPORTS_HYDRATION_CLIENT_HINTS" })
        }
    )

    local function buildBody(feedPageToken: string?)
        return buildChartsPageRequest(chartsPage, {
            feedPageToken = feedPageToken,
            sessionId = ChartsPageSession:Get(),
            filterSelections = getCurrentFilterSelections(),
            pageType = getCurrentPageType(),
            includePlaceholders = if FFlagSduiChartsRequestPlaceholders then true else nil,
            hydrationStreamEnabled = if FFlagChartsHydrationStreaming then true else nil,
            cachedRobloxComponentToTemplateId = getSduiTemplateStore().getCachedRobloxComponentToTemplateId(AppPage.Games),
            clientCapabilities = clientCapabilities2
        })
    end

    local fetchIfNeeded = sduiApiStore.fetchIfNeeded
    local tbl1 = {
        responseType = SduiResponseType.Protobuf,
        url = url,
        surfaceKey = AppPage.Games,
        configKey = configKey,
        loadTimer = loadTimer,
        apiProto = chartsPage.GetChartsPageResponse,
        mergeStrategy = if FFlagSduiChartsPlaceholderMergeStrategySupport then chartsMergeStrategy else nil,
        postConfig = {
            contentType = SduiApiStorePostConfigContentType.Proto,
            protoMessage = chartsPage.GetChartsPageRequest,
            body = buildBody(nil)
        },
        enableTemplateCache = true,
        enableStreaming = if FFlagChartsHydrationStreaming then true else nil,
        allowNoConfigsBuilt = if FFlagChartsHydrationStreaming then true else nil,
        buildNextPageUrl = 0,
        buildNextPagePostBody = 0,
        buildRefreshUrl = 0,
        buildRefreshPostBody = 0
    }
    function tbl1.buildNextPageUrl(arg1)
        return if extractNextFeedPageToken(arg1) then url else nil
    end
    function tbl1.buildNextPagePostBody(arg1)
        local feedPageToken = extractNextFeedPageToken(arg1)
        if not feedPageToken then
            return nil
        end
        return buildBody(feedPageToken)
    end

    function tbl1.buildRefreshUrl()
        if not sduiApiStore.isInFlight(configKey) then
            ChartsPageSession:Refresh()
        end
        return url
    end

    function tbl1.buildRefreshPostBody()
        return buildBody(nil)
    end

    return fetchIfNeeded(tbl1, bool1), configKey
end

return fetchChartsPage
