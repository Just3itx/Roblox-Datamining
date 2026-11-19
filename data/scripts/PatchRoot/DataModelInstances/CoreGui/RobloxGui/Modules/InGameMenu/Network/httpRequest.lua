-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:41:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local Promise = require(script.Parent.Parent.Utility.Promise)

local Extreme = Enum.ThrottlingPriority.Extreme
local ApplicationJson = Enum.HttpContentType.ApplicationJson

return function(httpRbxApiService)
    local function doHttpPost(arg1, arg2) -- Luacid: unused: defined but never referenced
        assert(arg2.postBody, "Expected a postBody to be specified with this request")
        assert(type(arg2.postBody) == "string", "Expected postBody to be a string")

        if not arg2.contentType then
            arg2.contentType = ApplicationJson
        end

        if not arg2.throttlingPriority then
            arg2.throttlingPriority = Extreme
        end

        return function()
            return httpRbxApiService:PostAsyncFullUrl(arg1, arg2.postBody, arg2.throttlingPriority, arg2.contentType)
        end
    end

    local function doHttpGet(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
        return function()
            return httpRbxApiService:GetAsyncFullUrl(str1, Extreme)
        end
    end

    return function(str1: string, arg1, arg2)
        assert(type(str1) == "string", "Expected url to be a string")
        assert(type(arg1) == "string", "Expected requestMethod to be a string")
        assert(not arg2 or type(arg2) == "table", "Expected options to be a table")
        arg1 = string.upper(arg1)

        local var1 = nil
        if arg1 == "POST" then
            assert(arg2.postBody, "Expected a postBody to be specified with this request")
            assert(type(arg2.postBody) == "string", "Expected postBody to be a string")

            if not arg2.contentType then
                arg2.contentType = ApplicationJson
            end

            if not arg2.throttlingPriority then
                arg2.throttlingPriority = Extreme
            end

            var1 = function()
                return httpRbxApiService:PostAsyncFullUrl(str1, arg2.postBody, arg2.throttlingPriority, arg2.contentType)
            end
        elseif arg1 == "GET" then
            var1 = doHttpGet(str1)
        else
            error(string.format("Unsupported requestMethod : %s", arg1 or "nil"))
        end

        return Promise.new(function(callback, callback2)
            if not var1 then
                callback2()

                return
            end

            coroutine.wrap(function()
                local success, result = pcall(var1)

                if not success then
                    callback2(result)

                    return
                end

                local success2, result2 = pcall(function()
                    return HttpService:JSONDecode(result)
                end)
                if success2 then
                    callback({ responseBody = result2 })
                    return
                end

                callback2(result2)
            end)()
        end)
    end
end
