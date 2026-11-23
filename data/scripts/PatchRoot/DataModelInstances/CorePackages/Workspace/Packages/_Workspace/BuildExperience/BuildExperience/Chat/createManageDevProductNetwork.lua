-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:51:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local _HttpClient = require(BuildExperienceParent.HttpClient)
local CreatorApiHttp = require(BuildExperienceParent.DataHydration.CreatorApiHttp)
local FFlagBuildExperienceManageDevProduct = require(BuildExperience.Flags.FFlagBuildExperienceManageDevProduct)
local FFlagBuildExperienceMonetizationNativeUI = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationNativeUI)
local var1 = FFlagBuildExperienceManageDevProduct or FFlagBuildExperienceMonetizationNativeUI

local function getHeader(headers, str1: string)
    if headers == nil then
        return nil
    end
    for k, header in headers do
        if string.lower(k) == string.lower(str1) then
            return header
        end
    end
    return nil
end

local function getCsrfToken(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    return (getHeader(arg1.headers, "x-csrf-token"))
end

local function withoutQuery(url: string) -- Luacid: Inlined by compiler; 7 call sites recovered
    return string.match(url, "^[^?]+") or url
end

local function getRequestId(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    return getHeader(tbl1.headers, "x-request-id") or getHeader(tbl1.headers, "x-correlation-id")
end

local function getResponseCode(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(arg1) == "table" then
        return arg1.statusCode
    end
    return tonumber(string.match(arg1, "status:%s*(%d%d%d)")) or tonumber(string.match(arg1, "HTTP%s+(%d%d%d)"))
end

local function classifyStartFailure(arg1): string
    local str1 = string.lower(tostring(arg1))

    if string.find(str1, "x-api-key", 1, true) then
        return "missing-open-cloud-api-key"
    end

    if string.find(str1, "accept", 1, true) and string.find(str1, "header", 1, true) then
        return "restricted-accept-header"
    end

    return "request-start-failure"
end

local function emit(tbl1, str1: string, bool1: boolean?) -- Luacid: Inlined by compiler; 7 call sites recovered
    local log = if tbl1 == nil then nil else tbl1.log

    if log ~= nil then
        pcall(log, str1)
    elseif var1 and bool1 then
        warn(str1)
    end
end

local function reportRequestStart(tbl1, arg1, num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var2 = if tbl1 == nil then "DeveloperProduct" elseif tbl1.label == nil then "DeveloperProduct" else tbl1.label
    local header = getHeader(arg1.headers, "content-type") or "<none>"
    emit(
        tbl1,
        `[{var2}] request transport=RequestInternal method={arg1.method} url={withoutQuery(arg1.url)} contentType={header} retryCount={num1}`,
        false
    )
end

local function reportResponse(tbl1, arg1, num1: number, bool1: boolean, arg2, bool2: boolean)
    local var2 = if tbl1 == nil then "DeveloperProduct" elseif tbl1.label == nil then "DeveloperProduct" else tbl1.label
    local responseCode = getResponseCode(arg2)
    local requestId = if typeof(arg2) == "table" then getRequestId(arg2) else nil
    local bool3 = typeof(arg2) == "table" and getCsrfToken(arg2) ~= nil
    emit(
        tbl1,
        `[{var2}] response transport=RequestInternal method={arg1.method} url={withoutQuery(arg1.url)} responseCode={tostring(responseCode)} requestId={requestId or "none"} csrfTokenPresent={tostring(bool3)} retryCount={num1} willRetry={tostring(bool2)} transportSuccess={tostring(bool1)}`,
        not bool1 or responseCode == nil or responseCode >= 400
    )
end

local function reportStartFailure(tbl1, arg1, num1: number, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    emit(
        tbl1,
        `[{if tbl1 == nil then "DeveloperProduct" elseif tbl1.label == nil then "DeveloperProduct" else tbl1.label}] request transport=RequestInternal method={arg1.method} url={withoutQuery(arg1.url)} retryCount={num1} startFailure={classifyStartFailure(arg2)}`,
        true
    )
end

local function withCsrfRetry(arg1, tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        request = function(arg2, callback: (...any) -> (...any))
            local bool1 = false
            local tbl2 = {}

            local function startAttempt(arg3, num1: number)
                reportRequestStart(tbl1, arg3, num1)
                local bool2 = false
                local success, result = pcall(arg1.request, arg3, function(arg4, arg5)
                    bool2 = true
                    if bool1 then
                        return
                    end

                    local csrfToken = if arg4 and typeof(arg5) == "table" and num1 == 0 then getCsrfToken(arg5) else nil
                    local bool3 = if arg4 and typeof(arg5) == "table" and arg5.statusCode == 403 then csrfToken ~= nil else false
                    reportResponse(tbl1, arg3, num1, arg4, arg5, bool3)

                    if not bool3 then
                        callback(arg4, arg5)
                        return
                    end

                    local headers = ({})
                    if arg3.headers ~= nil then
                        for k, header in arg3.headers do
                            headers[k] = header
                        end
                    end
                    headers["x-csrf-token"] = csrfToken
                    startAttempt({
                        url = arg3.url,
                        method = arg3.method,
                        headers = headers,
                        body = arg3.body,
                        onMessage = arg3.onMessage,
                        priority = arg3.priority
                    }, num1 + 1)
                end)

                if not success then
                    if not bool2 then
                        reportStartFailure(tbl1, arg3, num1, result)
                    end
                    error(result, 0)
                end
                table.insert(tbl2, result)
            end

            startAttempt(arg2, 0)

            return function()
                if bool1 then
                    return
                end
                bool1 = true
                for _, value in tbl2 do
                    value()
                end
            end
        end
    }
end

local function createManageDevProductNetwork(arg1, tbl1)
    return withCsrfRetry(CreatorApiHttp.withoutRestrictedAcceptHeader(arg1), tbl1)
end

return createManageDevProductNetwork
