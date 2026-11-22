-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local _types = require(script.Parent.types)

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

local function createRequestAsyncNetwork()
    return {
        request = function(arg1, callback: (...any) -> (...any))
            assert(arg1.onMessage == nil, "createRequestAsyncNetwork does not support onMessage; use createRequestInternalNetwork")

            local bool1 = false

            task.spawn(function()
                local success, result = pcall(function()
                    return HttpService:RequestAsync({ Url = arg1.url, Method = arg1.method, Headers = arg1.headers, Body = arg1.body })
                end)

                if bool1 then
                    return
                end
                bool1 = true

                if not success then
                    callback(false, tostring(result))
                    return
                end

                callback(true, {
                    statusCode = tonumber(result.StatusCode) or 0,
                    responseBody = result.Body,
                    headers = toLowerKeyedHeaders(result.Headers)
                })
            end)

            return function()
                bool1 = true
            end
        end
    }
end

return createRequestAsyncNetwork
