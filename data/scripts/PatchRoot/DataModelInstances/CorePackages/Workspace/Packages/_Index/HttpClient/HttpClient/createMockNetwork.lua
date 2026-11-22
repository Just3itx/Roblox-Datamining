-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local _types = require(script.Parent.types)

local function noopCancel() end

local function normalizeResponse(responseBody)
    if typeof(responseBody) == "string" then
        return { statusCode = 200, responseBody = responseBody }
    end

    if typeof(responseBody) ~= "table" then
        return { statusCode = 200, responseBody = nil }
    end

    if responseBody.statusCode == nil then
        return {
            statusCode = 200,
            responseBody = HttpService:JSONEncode(responseBody)
        }
    end

    return responseBody
end

local function createMockNetwork(arg1)
    local var1 = arg1 or {}
    local routes = var1.routes or {}

    return {
        request = function(arg2, callback: (...any) -> (...any))
            local respond = nil
            for _, value in routes do
                if string.find(arg2.url, value.pattern, 1, true) then
                    respond = value.respond
                    break
                end
            end

            local var2 = respond or var1.fallback

            if var2 == nil then
                callback(true, {
                    statusCode = 404,
                    responseBody = HttpService:JSONEncode({ message = "createMockNetwork: no route matched " .. arg2.url, code = 5 })
                })

                return noopCancel
            end

            local success, result = pcall(var2, arg2)
            if not success then
                callback(false, tostring(result))
            else
                callback(true, (normalizeResponse(result)))
            end
            return noopCancel
        end
    }
end

return createMockNetwork
