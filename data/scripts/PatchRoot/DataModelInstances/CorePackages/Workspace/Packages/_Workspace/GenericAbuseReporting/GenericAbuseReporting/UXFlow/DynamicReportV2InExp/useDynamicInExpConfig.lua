-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Dash = require(GenericAbuseReportingParent.Dash)
local React = require(GenericAbuseReportingParent.React)

local RoactNetworking = require(GenericAbuseReportingParent.RoactServiceTags).RoactNetworking
local useRoactService = require(GenericAbuseReportingParent.RobloxAppHooks).useRoactService

local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local AbuseVector = require(GenericAbuseReporting.Enums.AbuseVector)

local analyticsService = require(GenericAbuseReporting.BeduiV2.Analytics.analyticsService)
local fetchConfigWithAttributes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.fetchConfigWithAttributes)
local _inExperienceConfig = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.inExperienceConfig)
local FFlagAbuseReportImproveErrorEvents = require(GenericAbuseReporting.Flags.FFlagAbuseReportImproveErrorEvents)

local formatErrorDetailForAnalytics = analyticsService.formatErrorDetailForAnalytics
local getNewRunId = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.reducer).getNewRunId
local sendAnalyticsEvent = analyticsService.sendAnalyticsEvent
local TelemetryEventType = analyticsService.TelemetryEventType

local InExperience = AbuseVector.InExperience

local function getCacheKey(inExperience: string, bool1: boolean): string
    local tbl1 = {}
    for k in pairs(bool1) do
        table.insert(tbl1, k)
    end
    table.sort(tbl1)

    local tbl2 = { inExperience }
    for _, value in ipairs(tbl1) do
        local var1 = bool1[value]
        table.insert(tbl2, value .. "=" .. tostring(var1))
    end
    return table.concat(tbl2, ":")
end

local var1 = nil

return {
    useDynamicInExpConfig = function(bool1: boolean, bool2: boolean)
        local var2 = useRoactService(RoactNetworking)
        local key = getCacheKey(InExperience, bool2)
        local var3, var4 = React.useState(nil)
        local hasError, setHasError = React.useState(false)
        local var7 = React.useRef(0)
        local data = if var3 then var3.data else nil

        if var3 and var3.key ~= key then
            data = nil
        end

        React.useEffect(function()
            if not bool1 then
                var4(nil)
                return
            end

            local experienceTargetId = bool2.experienceTargetId
            local unixTimestampMillis = DateTime.now().UnixTimestampMillis
            if var1 and var1.key == key and unixTimestampMillis - var1.fetchedAtMs <= 1800000 then
                var4({ key = key, data = var1.data })

                setHasError(false)
                sendAnalyticsEvent({
                    abuse_vector = InExperience,
                    target_id = experienceTargetId,
                    run_id = "unknown",
                    total_duration = 0,
                    path = {},
                    config_name = var1.data.name
                }, {
                    sub_event_type = TelemetryEventType.ConfigLoaded,
                    config_load_detail = { load_duration_ms = 0, cache_hit = true, retry_count = 0 }
                })

                return
            end

            local current = var7.current + 1
            var7.current = current
            var4(nil)
            setHasError(false)

            local unixTimestampMillis2 = DateTime.now().UnixTimestampMillis
            fetchConfigWithAttributes(var2, InExperience, bool2):andThen(function(arg1)
                if var7.current ~= current then
                    return
                end
                local responseBody = arg1.responseBody
                var1 = {
                    key = key,
                    data = responseBody,
                    fetchedAtMs = DateTime.now().UnixTimestampMillis
                }
                var4({ key = key, data = responseBody })

                sendAnalyticsEvent({
                    abuse_vector = InExperience,
                    target_id = experienceTargetId,
                    run_id = "unknown",
                    total_duration = 0,
                    path = {},
                    config_name = responseBody.name
                }, {
                    sub_event_type = TelemetryEventType.ConfigLoaded,
                    config_load_detail = {
                        load_duration_ms = DateTime.now().UnixTimestampMillis - unixTimestampMillis2,
                        cache_hit = false,
                        retry_count = 0
                    }
                })
            end):catch(function(arg1)
                if var7.current ~= current then
                    return
                end
                warn("Failed to fetch Dynamic Report V2 config:", arg1)
                setHasError(true)
                local var9 = sendAnalyticsEvent
                local tbl1 = {
                    abuse_vector = InExperience,
                    target_id = experienceTargetId,
                    run_id = getNewRunId(),
                    total_duration = 0,
                    path = {}
                }
                local tbl2 = {
                    sub_event_type = TelemetryEventType.Error,
                    error_detail = 0
                }
                local tbl3

                if FFlagAbuseReportImproveErrorEvents then
                    tbl3 = formatErrorDetailForAnalytics("Failed to fetch config", arg1)
                else
                    tbl3 = { error_message = 0 }

                    local var10 = Dash.pretty(arg1, { depth = 2 })
                    tbl3.error_message = "Failed to fetch config: " .. string.sub(var10, 1, 256)
                end

                tbl2.error_detail = tbl3
                var9(tbl1, tbl2)
            end)
        end, {
            var2,
            bool1,
            bool2,
            key
        })
        return {
            config = data,
            hasError = hasError,
            setHasError = setHasError,
            abuseVector = InExperience
        }
    end,
    clearCacheForTesting = function()
        var1 = nil
    end,
    CONFIG_CACHE_TTL_MS = 1800000
}
