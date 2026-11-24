-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:40:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local _HttpClient = require(DataHydrationParent.HttpClient)
local UrlBase = require(DataHydrationParent.UrlBuilder).UrlBase

local pollAnalyticsOperation = require(script.Parent.pollAnalyticsOperation)
local _CreatorAnalyticsStoreTypes = require(script.Parent.CreatorAnalyticsStoreTypes)

local function toMap(tbl1)
    if tbl1.metricMetadataResult == nil then
        error({ errorMessage = "analytics metadata response missing metricMetadataResult" })
    end
    local metadata = tbl1.metricMetadataResult.metadata
    local result = {}
    if metadata ~= nil then
        for _, value in metadata do
            if value.metric ~= nil and value.latestAvailableTime ~= nil then
                result[value.metric] = value.latestAvailableTime
            end
        end
    end
    return result
end

local function fetchMetricMetadata(metrics, tbl1)
    local tbl2 = tbl1 or {}
    local url = (tbl2.baseUrl or UrlBase.APIS) .. "/analytics-query-gateway/v1/metrics/metadata"
    return pollAnalyticsOperation({
        network = tbl2.network,
        url = url,
        body = {
            query = { metrics = metrics }
        },
        analyticsKey = "build-experience.experience-analytics-metadata",
        mapResult = toMap,
        timeoutMessage = "analytics metadata query did not complete after polling",
        delay = tbl2.delay
    })
end

return fetchMetricMetadata
