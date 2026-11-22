-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local _types = require(script.Parent.types)
local FFlagHttpClientMrRouterHeaders = require(script.Parent.Flags.FFlagHttpClientMrRouterHeaders)

local MrRouterHeaders = nil
if FFlagHttpClientMrRouterHeaders then
    local httpClientParent = script:FindFirstAncestor("HttpClient").Parent
    MrRouterHeaders = require(httpClientParent.MrRouterHeaders)
end

local function toLowerKeyedHeaders(headers)
    if typeof(headers) ~= "table" then
        return nil
    end
    local result = {}
    for k, header in headers do
        result[tostring(k):lower()] = tostring(header)
    end
    return result
end

local function createRequestInternalNetwork(arg1)
    local transportFailuresAsResponses = not (arg1 == nil) and arg1.transportFailuresAsResponses

    return {
        request = function(arg2, callback: (...any) -> (...any))
            local headers = arg2.headers
            if FFlagHttpClientMrRouterHeaders then
                headers = MrRouterHeaders.injectMrRouterHeaders(arg2.headers)
            end

            local var1 = HttpService:RequestInternal({
                Url = arg2.url,
                Method = arg2.method,
                Headers = headers,
                Body = arg2.body,
                OnMessage = arg2.onMessage,
                Priority = arg2.priority
            })

            local bool1 = false

            var1:Start(function(bool2: boolean, arg3)
                if bool1 then
                    return
                end
                bool1 = true
                if typeof(arg3) ~= "table" or not bool2 and not transportFailuresAsResponses then
                    if transportFailuresAsResponses then
                        callback(false, tostring(arg3 or "RequestInternal failed"))
                    else
                        callback(false, tostring(arg3 and arg3.StatusMessage or "RequestInternal failed"))
                    end

                    return
                end

                local Stats = arg3.Stats
                local tbl1

                if typeof(Stats) == "table" then
                    tbl1 = {}
                    for k, stat in arg3.Stats do
                        if typeof(k) == "string" and typeof(stat) == "number" then
                            tbl1[k] = stat
                        elseif k == "WasRequestRetried" and typeof(stat) == "boolean" then
                            tbl1[k] = if stat then 1 else 0
                        end
                    end
                else
                    tbl1 = nil
                end

                callback(true, {
                    statusCode = tonumber(arg3.StatusCode) or 0,
                    responseBody = arg3.Body,
                    headers = toLowerKeyedHeaders(arg3.Headers),
                    httpError = arg3.HttpError,
                    stats = tbl1,
                    wasTransportFailure = if transportFailuresAsResponses then not bool2 else nil
                })
            end)

            return function()
                if bool1 then
                    return
                end
                bool1 = true
                pcall(function()
                    var1:Cancel()
                end)
            end
        end
    }
end

return createRequestInternalNetwork
