-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)
local Promise = require(DataHydrationParent.Promise)
local UrlBase = require(DataHydrationParent.UrlBuilder).UrlBase

local pollAnalyticsOperation = require(DataHydration.pollAnalyticsOperation)
local _CampaignStatsTypes = require(script.Parent.CampaignStatsTypes)
local WINDOW_DAYS = require(script.Parent.CampaignStatsConstants).WINDOW_DAYS

local module = {}

local function sumByCampaign(queryResult)
    local result = ({})
    if queryResult == nil or queryResult.values == nil then
        return result
    end
    for _, value in queryResult.values do
        local value2 = nil
        if value.breakdownValue ~= nil then
            for _, value3 in value.breakdownValue do
                if value3.dimension == "CampaignId" then
                    value2 = value3.value
                    break
                end
            end
        end

        if value2 == nil or value2 == "RAQI_RESERVED_DIMENSION_VALUES_NO_VALUE" then
            continue
        end

        local num1 = 0
        if value.dataPoints ~= nil then
            for _, dataPoint in value.dataPoints do
                num1 += dataPoint.value or 0
            end
        end
        result[value2] = (result[value2] or 0) + num1
    end
    return result
end

local function queryMetricByCampaign(metric: string, num1: number, tbl1, tbl2)
    local url = ("%s/analytics-query-gateway/v1/metrics/resource/%s/id/%d"):format(
        tbl2.baseUrl or UrlBase.APIS,
        "RESOURCE_TYPE_UNIVERSE",
        num1
    )

    local body = {
        resourceType = "RESOURCE_TYPE_UNIVERSE",
        resourceId = tostring(num1),
        query = 0
    }
    local query = {
        metric = metric,
        granularity = "METRIC_GRANULARITY_NONE",
        startTime = tbl1.startIso,
        endTime = tbl1.queryEndIso,
        breakdown = {{
            dimensions = { "CampaignId" }
        }},
        filter = 0
    }
    local tbl5 = {
        dimension = "AttributionDateHour",
        operation = "FILTER_OPERATION_GTE",
        values = { tostring(tbl1.startMs) }
    }
    local tbl6 = {
        dimension = "AttributionDateHour",
        operation = "FILTER_OPERATION_LT",
        values = { tostring(tbl1.endMs) }
    }
    query.filter = { tbl5, tbl6 }
    body.query = query

    return pollAnalyticsOperation({
        network = tbl2.network,
        url = url,
        body = body,
        analyticsKey = "ads-campaign-stats.query",
        mapResult = function(arg1)
            return (sumByCampaign(arg1.queryResult))
        end,
        timeoutMessage = "analytics-query-gateway: campaign stats query did not complete"
    })
end

local function captureMetricOutcome(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1:andThen(function(value)
        return { succeeded = true, value = value }
    end, function(_)
        return {
            succeeded = false,
            value = {}
        }
    end)
end

function module.fetchCampaignStats(num1: number, tbl1)
    local tbl2 = tbl1 or {}
    local var1 = if tbl2.nowMs ~= nil then tbl2.nowMs else DateTime.now().UnixTimestampMillis
    local endMs = var1 - var1 % 3600000
    local startMs = endMs - WINDOW_DAYS * 86400000
    local tbl3 = {
        startMs = startMs,
        endMs = endMs,
        startIso = DateTime.fromUnixTimestampMillis(startMs):ToIsoDate(),
        queryEndIso = DateTime.fromUnixTimestampMillis(endMs + 2592000000):ToIsoDate()
    }

    return Promise.all({
        captureMetricOutcome((queryMetricByCampaign("AdsUANumPlaysDefaultViewByUniverse", num1, tbl3, tbl2))),
        captureMetricOutcome((queryMetricByCampaign("AdsUANumClicksDefaultViewByUniverse", num1, tbl3, tbl2))),
        queryMetricByCampaign("AdsUANumImpressionsDefaultViewByUniverse", num1, tbl3, tbl2):andThen(function(value)
            return { succeeded = true, value = value }
        end, function(_)
            return {
                succeeded = false,
                value = {}
            }
        end),
        captureMetricOutcome(queryMetricByCampaign("AdsUAPlaytimeDefaultViewByUniverse", num1, tbl3, tbl2))
    }):andThen(
        function(tbl4)
            local var3 = tbl4[1]
            local var4 = tbl4[2]
            local var5 = tbl4[3]
            local var6 = tbl4[4]

            local byCampaign = ({})
            local function entryFor(str1: string) -- Luacid: Inlined by compiler; 4 call sites recovered
                local tbl6 = byCampaign[str1]
                if tbl6 == nil then
                    tbl6 = { plays = 0, adClicks = 0, adViews = 0, playtimeSeconds = 0 }
                    byCampaign[str1] = tbl6
                end
                return tbl6
            end
            for value, plays in var3.value do
                entryFor(value).plays = plays
            end
            for value, adClicks in var4.value do
                entryFor(value).adClicks = adClicks
            end
            for value, adViews in var5.value do
                entryFor(value).adViews = adViews
            end
            for value, playtimeSeconds in var6.value do
                entryFor(value).playtimeSeconds = playtimeSeconds
            end
            return {
                byCampaign = byCampaign,
                failedMetrics = {
                    plays = not var3.succeeded,
                    adClicks = not var4.succeeded,
                    adViews = not var5.succeeded,
                    playtimeSeconds = not var6.succeeded
                }
            }
        end
    )
end
return module
