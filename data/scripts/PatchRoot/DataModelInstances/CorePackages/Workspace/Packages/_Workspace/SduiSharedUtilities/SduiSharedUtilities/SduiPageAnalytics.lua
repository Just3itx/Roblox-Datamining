-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")

local _SduiIntegrationTypes = require(SduiSharedUtilities.SduiIntegrationTypes)

local config = {
    eventName = "Sdui_PageLoadTimer",
    description = "Duration for sdui page loading, network requests",
    lastUpdated = { 25, 11, 18 },
    backends = { "Points", "EventIngest" },
    throttlingPercentage = game:DefineFastInt("SduiPageTimerEventHundredthsPercent", 0)
}
local config2 = {
    eventName = "Sdui_LoadMoreFromApi",
    description = "Event log for pagination request",
    lastUpdated = { 26, 1, 9 },
    backends = { "Points", "EventIngest" },
    throttlingPercentage = game:DefineFastInt("SduiLoadMoreFromApiEventHundredthsPercent", 0)
}

local tbl1 = {
    eventName = "Sdui_PageStatus",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 25, 11, 18 },
    description = "Status code for sdui page requests"
}

local config3 = {
    eventName = "Sdui_PagePayloadSize",
    backends = { "RobloxTelemetryStat" },
    lastUpdated = { 25, 11, 19 },
    description = "Payload size for sdui page requests"
}

local tbl2 = {
    eventName = "Sdui_RequestOutcome",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 26, 8, 31 },
    description = "Terminal outcome of sdui page requests, bucketed by endpoint"
}

local config4 = {
    eventName = "Sdui_RequestRetry",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 26, 8, 31 },
    description = "Retry attempts for sdui page requests, bucketed by endpoint"
}

local tbl3 = {
    [Enum.HttpError.OK] = "OK",
    [Enum.HttpError.InvalidUrl] = "InvalidUrl",
    [Enum.HttpError.DnsResolve] = "DnsResolve",
    [Enum.HttpError.ConnectFail] = "ConnectFail",
    [Enum.HttpError.OutOfMemory] = "OutOfMemory",
    [Enum.HttpError.TimedOut] = "Timedout",
    [Enum.HttpError.TooManyRedirects] = "TooManyRedirects",
    [Enum.HttpError.InvalidRedirect] = "InvalidRedirect",
    [Enum.HttpError.NetFail] = "NetFail",
    [Enum.HttpError.Aborted] = "Aborted",
    [Enum.HttpError.SslConnectFail] = "SslConnectFail",
    [Enum.HttpError.SslVerificationFail] = "SslVerificationFail",
    [Enum.HttpError.Unknown] = "Unknown"
}

local config5 = {
    eventName = "Sdui_MissingRoot",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 26, 10, 5 },
    description = "Mounted SDUI content has no root after the request deadline and grace period"
}

local config6 = {
    eventName = "Sdui_StaleResponseDiscarded",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 26, 10, 6 },
    description = "SDUI response work discarded after the authenticated account changed"
}

return {
    sendLoadTimerEvent = function(customFields)
        TelemetryService:LogEvent(config, { customFields = customFields, standardizedFields = { "addOSInfo" } })
    end,
    sendPageStatusEvent = function(pageKey: string, statusCode: number?, arg1)
        TelemetryService:LogCounter(tbl1, {
            customFields = {
                pageKey = pageKey,
                statusCode = statusCode or "unknown",
                httpError = if arg1 then tbl3[arg1] else nil
            }
        })
    end,
    sendPagePayloadSizeEvent = function(pageKey: string, buf: buffer)
        local var1

        if typeof(buf) == "buffer" then
            var1 = buffer.len(buf)
        else
            if typeof(buf) ~= "string" then
                return
            end

            var1 = string.len(buf)
        end
        TelemetryService:LogStat(config3, { customFields = { pageKey = pageKey } }, var1)
    end,
    sendLoadMoreEvent = function(surfaceKey: string)
        TelemetryService:LogEvent(config2, { customFields = { surfaceKey = surfaceKey }, standardizedFields = { "addOSInfo" } })
    end,
    sendRequestOutcomeCounter = function(pageKey: string, endpoint: string, outcome: string, statusCode: number?, httpError)
        TelemetryService:LogCounter(tbl2, {
            customFields = {
                pageKey = pageKey,
                endpoint = endpoint,
                outcome = outcome,
                statusCode = statusCode or "unknown",
                httpError = if httpError == nil or httpError == Enum.HttpError.OK then nil else tbl3[httpError]
            }
        })
    end,
    sendRequestRetryCounter = function(pageKey: string, endpoint: string, attempt: number)
        TelemetryService:LogCounter(config4, { customFields = { pageKey = pageKey, endpoint = endpoint, attempt = attempt } })
    end,
    sendMissingRoot = function(surface: string, str1: string, bool1: boolean)
        TelemetryService:LogCounter(config5, {
            customFields = {
                surface = surface,
                status = if str1 ~= "Ready" and str1 ~= "NotReady" and str1 ~= "Failed" then "unknown" else str1,
                inFlight = tostring(bool1)
            },
            standardizedFields = { "addOSInfo" }
        })
    end,
    sendStaleResponseDiscarded = function(surface: string, mode: string, stage: string)
        TelemetryService:LogCounter(
            config6,
            {
                customFields = { surface = surface, mode = mode, stage = stage },
                standardizedFields = { "addOSInfo" }
            }
        )
    end
}
