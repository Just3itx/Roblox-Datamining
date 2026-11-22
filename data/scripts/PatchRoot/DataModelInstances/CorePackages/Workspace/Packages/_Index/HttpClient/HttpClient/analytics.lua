-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local _types = require(script.Parent.types)

local throttlingPercentage = game:DefineFastInt("LuaHttpClientRequestTimerEventHundredthsPercent", 0)
game:DefineFastInt("LuaHttpClientRequestStatusEventHundredthsPercent", 0)
game:DefineFastInt("LuaHttpClientPayloadSizeEventHundredthsPercent", 0)

local function shouldSample(fastInt): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return not (fastInt <= 0) and (fastInt >= 10000 or math.random(1, 10000) <= fastInt)
end

local config = {
    eventName = "LuaHttpClient_RequestTimer",
    description = "Duration for lua-apps http-client HTTP requests, bucketed by analyticsKey",
    lastUpdated = { 26, 5, 29 },
    backends = { "Points", "EventIngest" },
    throttlingPercentage = throttlingPercentage
}

local tbl1 = {
    eventName = "LuaHttpClient_RequestStatus",
    description = "Status code + final state for lua-apps http-client HTTP requests",
    lastUpdated = { 26, 5, 29 },
    backends = { "RobloxTelemetryCounter" }
}

local config2 = {
    eventName = "LuaHttpClient_PayloadSize",
    description = "Response payload size for lua-apps http-client HTTP requests",
    lastUpdated = { 26, 5, 29 },
    backends = { "RobloxTelemetryStat" }
}

local tbl2 = {
    [Enum.HttpError.OK] = "OK",
    [Enum.HttpError.InvalidUrl] = "InvalidUrl",
    [Enum.HttpError.DnsResolve] = "DnsResolve",
    [Enum.HttpError.ConnectFail] = "ConnectFail",
    [Enum.HttpError.OutOfMemory] = "OutOfMemory",
    [Enum.HttpError.TimedOut] = "TimedOut",
    [Enum.HttpError.TooManyRedirects] = "TooManyRedirects",
    [Enum.HttpError.InvalidRedirect] = "InvalidRedirect",
    [Enum.HttpError.NetFail] = "NetFail",
    [Enum.HttpError.Aborted] = "Aborted",
    [Enum.HttpError.SslConnectFail] = "SslConnectFail",
    [Enum.HttpError.SslVerificationFail] = "SslVerificationFail",
    [Enum.HttpError.Unknown] = "Unknown"
}

local function payloadSizeOf(buf: buffer) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(buf) == "buffer" then
        return buffer.len(buf)
    elseif typeof(buf) == "string" then
        return string.len(buf)
    end
    return nil
end

local tbl3 = {
    "DurationInQueue",
    "DurationNameLookup",
    "DurationConnect",
    "DurationSSLHandshake",
    "DurationMakeRequest",
    "DurationReceiveResponse",
    "RoundTripTime"
}

return {
    defaultAnalytics = function(analyticsKey: string, method, _: string, arg1, durationMs: number, status)
        local customFields = {
            analyticsKey = analyticsKey,
            method = method,
            durationMs = durationMs,
            status = status
        }
        if arg1 and arg1.stats then
            for _, value in tbl3 do
                local stat = arg1.stats[value]
                if typeof(stat) == "number" then
                    customFields[value] = stat * 1000
                end
            end
            local wasRequestRetried = arg1.stats.WasRequestRetried
            if typeof(wasRequestRetried) == "number" then
                customFields.WasRequestRetried = wasRequestRetried
            end
        end

        TelemetryService:LogEvent(config, { customFields = customFields, standardizedFields = { "addOSInfo" } })

        if shouldSample((game:GetFastInt("LuaHttpClientRequestStatusEventHundredthsPercent"))) then
            TelemetryService:LogCounter(tbl1, {
                customFields = {
                    analyticsKey = analyticsKey,
                    method = method,
                    status = status,
                    statusCode = arg1 and arg1.statusCode or "unknown",
                    httpError = if arg1 and arg1.httpError then tbl2[arg1.httpError] else nil
                }
            })
        end

        local var1 = if arg1 then payloadSizeOf(arg1.responseBody) else nil

        if var1 == nil or not shouldSample((game:GetFastInt("LuaHttpClientPayloadSizeEventHundredthsPercent"))) then
            return
        end

        TelemetryService:LogStat(config2, { customFields = { analyticsKey = analyticsKey } }, var1)
    end
}
