-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent
local HttpService = game:GetService("HttpService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local TelemetryService = game:GetService("TelemetryService")

local Dash = require(GenericAbuseReportingParent.Dash)

local FFlagAbuseReportImproveErrorEvents = require(GenericAbuseReporting.Flags.FFlagAbuseReportImproveErrorEvents)

local tbl1 = { "errorMessage", "message", "error" }

local function getBoundedUtf8String(arg1, num1: number) -- Luacid: Inlined by compiler; 14 call sites recovered
    local str1 = tostring(arg1)
    if utf8.len(str1) == nil then
        return nil
    end
    if #str1 <= num1 then
        return str1
    end

    return string.sub(str1, 1, utf8.offset(str1, 0, num1 + 1) - 1)
end

local function setBoundedMetadata(tbl2, str1: string, arg1) -- Luacid: Inlined by compiler; 12 call sites recovered
    if arg1 == nil then
        return
    end

    local boundedUtf8String = getBoundedUtf8String(arg1, 1000)

    if boundedUtf8String ~= nil then
        tbl2[str1] = boundedUtf8String
    end
end

local function getFallbackErrorMessage(tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(tbl2) ~= "table" then
        return nil
    end

    for _, value in tbl1 do
        local var1 = tbl2[value]
        if type(var1) == "string" then
            return var1
        end
    end
    return nil
end

local function getHeader(headers, str1: string)
    if type(headers) ~= "table" then
        return nil
    end

    local str2 = string.lower(str1)
    for k, header in headers do
        if type(k) == "string" and string.lower(k) == str2 then
            return header
        end
    end
    return nil
end

local function setBoundedNumericHeaderMetadata(tbl2, str1: string, headers, str2: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = tonumber((getHeader(headers, str2)))
    if var1 then
        setBoundedMetadata(tbl2, str1, var1)
    end
end

local function isArray(tbl2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local num1 = 0
    for _ in tbl2 do
        num1 += 1
    end
    return num1 == #tbl2 and num1 > 0
end

local function flattenForTelemetry(tbl2)
    local result = ({})
    for value, value2 in tbl2 do
        if type(value2) == "table" then
            if isArray(value2) then
                local tbl3 = {}
                for _, value3 in value2 do
                    table.insert(tbl3, tostring(value3))
                end
                result[value] = "[" .. table.concat(tbl3, ", ") .. "]"
            else
                for value3, value4 in value2 do
                    result[tostring(value3)] = tostring(value4)
                end
            end
        else
            result[value] = tostring(value2)
        end
    end
    return result
end

local config = {
    eventName = "DynamicAbuseReportEventV2",
    description = "Event to track dynamic abuse report v2",
    lastUpdated = { 2026, 9, 10 },
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("DynamicAbuseReportV2ThrottleHundredthsPercent", 0),
    links = "https://github.rbx.com/Roblox/proto-schemas/pull/13201"
}

local function getCoreScriptVersion() -- Luacid: Inlined by compiler; 1 call site recovered
    if not game:GetEngineFeature("CoreScriptVersionEnabled") then
        return nil
    end

    local success, result = pcall(function(): string
        return RunService:GetCoreScriptVersion()
    end)

    return if success then result else nil
end

local client_version = getCoreScriptVersion()

return {
    sendAnalyticsEvent = function(tbl2, tbl3)
        local tbl4 = {
            user_id = LocalPlayer and LocalPlayer.UserId or nil,
            client_version = client_version
        }

        local tbl5 = flattenForTelemetry(Dash.join(tbl2, tbl3, tbl4))

        if FFlagAbuseReportImproveErrorEvents and tbl3.sub_event_type == "Error" and tbl3.error_detail.error_metadata ~= nil then
            local success, result = pcall(HttpService.JSONEncode, HttpService, tbl3.error_detail.error_metadata)
            if success and type(result) == "string" then
                tbl5.error_metadata = result
            else
                tbl5 = Dash.omit(tbl5, { "error_metadata" })
            end
        end

        TelemetryService:LogEvent(config, { customFields = tbl5, eventContext = tbl2.abuse_vector })
    end,
    TelemetryEventType = {
        ReportStarted = "OpenDialog",
        ReportAbandoned = "EarlyClose",
        ReportCompleted = "Close",
        Submit = "Submit",
        SubmitSuccess = "SubmitSuccess",
        SubmitFail = "SubmitFail",
        BackAction = "BackAction",
        NodeDone = "NodeDone",
        SelectItem = "SelectItem",
        IsUserBlockAvailable = "IsUserBlockAvailable",
        IsUserMuteAvailable = "IsUserMuteAvailable",
        DidBlockUser = "DidBlockUser",
        DidUnblockUser = "DidUnblockUser",
        DidMuteUser = "DidMuteUser",
        HelplineShown = "HelplineShown",
        HelplineOpened = "HelplineOpened",
        LinkOpened = "LinkOpened",
        Error = "Error",
        CommentInput = "CommentInput",
        TextChannelSwitch = "TextChannelSwitch",
        EmptyState = "EmptyState",
        SceneCaptureResult = "SceneCaptureResult",
        ConfigLoaded = "ConfigLoaded"
    },
    LinkOpenedSource = { Footer = "footer", NextAction = "next_action" },
    SubmitSource = { Flow = "flow", SceneSelection = "sceneSelection" },
    formatErrorDetailForAnalytics = function(str1: string, arg1, tbl2)
        local var1 = if type(arg1) == "string" then arg1 else nil
        local errorMetadata = {}
        if type(arg1) == "table" then
            setBoundedMetadata(errorMetadata, "status_code", arg1.StatusCode)
            setBoundedMetadata(errorMetadata, "http_error", arg1.HttpError)
            setBoundedMetadata(errorMetadata, "is_cached", arg1.IsCached)
            setBoundedMetadata(errorMetadata, "is_prefetch", arg1.IsPrefetch)

            if arg1.isJSONValid == false then
                errorMetadata.reason = "invalid_json"
            end

            local Stats = arg1.Stats
            if type(Stats) == "table" then
                local var2 = tonumber(Stats.RoundTripTime)
                if var2 then
                    setBoundedMetadata(errorMetadata, "round_trip_milliseconds", var2 * 1000)
                end
                setBoundedMetadata(errorMetadata, "was_request_retried", Stats.WasRequestRetried)
            end

            setBoundedNumericHeaderMetadata(errorMetadata, "retry_after_seconds", arg1.Headers, "Retry-After")

            setBoundedNumericHeaderMetadata(
                errorMetadata,
                "upstream_service_time_milliseconds",
                arg1.Headers,
                "x-envoy-upstream-service-time"
            )

            if next(errorMetadata) == nil then
                var1 = getFallbackErrorMessage(arg1)
                errorMetadata.reason = "unknown"
            end

            if type(arg1.Body) == "string" then
                setBoundedMetadata(errorMetadata, "body_size_bytes", #arg1.Body)
            end

            if tbl2 and tbl2.includeResponseBody and arg1.Body ~= nil then
                local var2 = if type(arg1.Body) == "string" then arg1.Body else Dash.pretty(arg1.Body, { depth = 10 })
                setBoundedMetadata(errorMetadata, "response_body", var2)
            end
        end

        if next(errorMetadata) == nil then
            errorMetadata.reason = "unknown"
        end

        setBoundedMetadata(errorMetadata, "runtime_message", var1)
        return {
            error_message = getBoundedUtf8String(str1, 1000) or "Unknown error",
            error_metadata = errorMetadata
        }
    end
}
