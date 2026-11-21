-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Charts = script:FindFirstAncestor("Charts")
local ChartsParent = Charts.Parent

local SduiSharedUtilities = require(ChartsParent.SduiSharedUtilities)
local SduiResponseType = SduiSharedUtilities.SduiResponseType
local getSduiApiStore = SduiSharedUtilities.getSduiApiStore
local getSduiTemplateStore = SduiSharedUtilities.getSduiTemplateStore
local getSduiClientPageScope = SduiSharedUtilities.getSduiClientPageScope
local SduiApiStorePostConfigContentType = SduiSharedUtilities.SduiApiStorePostConfigContentType
local SduiCapabilities = SduiSharedUtilities.SduiCapabilities

local ChartsConstants = require(Charts.ChartsPage.ChartsConstants)
local ChartsPageScopeFields = require(Charts.ChartsPage.ChartsPageScopeFields)
local ChartsPageSession = require(Charts.ChartsPage.ChartsPageSession)
local ChartsSortDetailScopeFields = require(Charts.ChartsSortDetailPage.ChartsSortDetailScopeFields)
local getChartsSortDetailPostUrl = require(Charts.ChartsSortDetailPage.getChartsSortDetailPostUrl)
local getChartsSortDetailPageKey = require(Charts.ChartsSortDetailPage.getChartsSortDetailPageKey)
local buildChartsSortDetailRequest = require(Charts.ChartsSortDetailPage.buildChartsSortDetailRequest)

local SharedFlags = require(ChartsParent.SharedFlags)
local FFlagSduiChartsSortDetailGenreFilter = SharedFlags.FFlagSduiChartsSortDetailGenreFilter
local FFlagSduiAdvertiseRuntimeSupportSets = SharedFlags.FFlagSduiAdvertiseRuntimeSupportSets

local function getInheritedFilterSelections() -- Luacid: Inlined by compiler; 3 call sites recovered
    return getSduiClientPageScope(ChartsConstants.ConfigKey).get(ChartsPageScopeFields.FilterSelections)
end

local function extractNextContentPageToken(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local nextContentPageToken = arg1 and arg1.next_content_page_token
    return if nextContentPageToken and nextContentPageToken ~= "" then nextContentPageToken else nil
end

local function getGenreForRequest(str1: string)
    local sduiClientPageScope = getSduiClientPageScope(str1)
    local var1 = sduiClientPageScope.get(ChartsSortDetailScopeFields.DesiredGenre)
    local var2 = sduiClientPageScope.get(ChartsSortDetailScopeFields.SafeGenre)
    local bool1 = typeof(var1) == "string" and var1 ~= ""
    local bool2 = typeof(var2) == "string" and var2 ~= ""
    return if bool1 and var1 ~= var2 then var1 elseif bool2 then var2 else nil
end

local function getFilterSelectionsWithGenre(str1: string)
    local inheritedFilterSelections = getInheritedFilterSelections()

    local selectedGenre = getGenreForRequest(str1)
    if selectedGenre == nil then
        return inheritedFilterSelections
    end

    local var1 = not inheritedFilterSelections and {} or table.clone(inheritedFilterSelections)
    var1.selectedGenre = selectedGenre
    return var1
end

local function resetStickyGenreIfStale(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local _, var1 = getSduiApiStore().getData(str1)
    if var1 then
        local sduiClientPageScope = getSduiClientPageScope(str1)
        sduiClientPageScope.set(ChartsSortDetailScopeFields.DesiredGenre, nil)
        sduiClientPageScope.set(ChartsSortDetailScopeFields.SafeGenre, nil)
    end
end

local function fetchChartsSortDetail(sortId: string, loadTimer)
    local inheritedFilterSelections = getInheritedFilterSelections()

    local configKey = getChartsSortDetailPageKey(sortId, nil, inheritedFilterSelections)

    if FFlagSduiChartsSortDetailGenreFilter then
        resetStickyGenreIfStale(configKey)
    end

    local chartsSortDetailPostUrl = getChartsSortDetailPostUrl()

    local serviceContractsProto = require(ChartsParent.ServiceContractsProto)
    local chartsPage = serviceContractsProto.apppageplatform.charts.charts_page

    local clientCapabilities = serviceContractsProto.apppageplatform.shared.client_capabilities.ClientCapabilities
    local clientCapabilities2 = if FFlagSduiAdvertiseRuntimeSupportSets then SduiCapabilities.buildClientCapabilities() else clientCapabilities.new(
        {
            enabled_capabilities = SduiCapabilities.getEnabledCapabilityNumbers({ "CAPABILITY_SUPPORTS_HYDRATION_CLIENT_HINTS" })
        }
    )

    local function buildBody(contentPageToken: string?)
        return buildChartsSortDetailRequest(chartsPage, {
            sortId = sortId,
            contentPageToken = contentPageToken,
            sessionId = ChartsPageSession:Get(),
            filterSelections = if FFlagSduiChartsSortDetailGenreFilter then getFilterSelectionsWithGenre(configKey) else getInheritedFilterSelections(),
            cachedRobloxComponentToTemplateId = getSduiTemplateStore().getCachedRobloxComponentToTemplateId("ChartsSortDetail"),
            clientCapabilities = clientCapabilities2
        })
    end

    getSduiApiStore().fetchIfNeeded({
        responseType = SduiResponseType.Protobuf,
        url = chartsSortDetailPostUrl,
        surfaceKey = "ChartsSortDetail",
        configKey = configKey,
        loadTimer = loadTimer,
        apiProto = chartsPage.GetChartsSortDetailResponse,
        postConfig = {
            contentType = SduiApiStorePostConfigContentType.Proto,
            protoMessage = chartsPage.GetChartsSortDetailRequest,
            body = buildBody(nil)
        },
        enableTemplateCache = true,
        buildNextPageUrl = function(arg1)
            return if extractNextContentPageToken(arg1) then chartsSortDetailPostUrl else nil
        end,
        buildNextPagePostBody = function(arg1)
            local contentPageToken = extractNextContentPageToken(arg1)

            if not contentPageToken then
                return nil
            end
            return buildBody(contentPageToken)
        end,
        buildRefreshUrl = function()
            return chartsSortDetailPostUrl
        end,
        buildRefreshPostBody = function()
            return buildBody(nil)
        end
    })

    return configKey
end

return fetchChartsSortDetail
