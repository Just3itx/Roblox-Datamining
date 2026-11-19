-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local HttpService = game:GetService("HttpService")

local Promise = require(CorePackages.Packages.Promise)

local Extreme = Enum.ThrottlingPriority.Extreme
local ApplicationJson = Enum.HttpContentType.ApplicationJson

return function(httpRbxApiService)
    local function doHttpPost(str1: string, arg1)
        local var1 = nil
        assert(arg1.postBody, "Expected a postBody to be specified with this request")
        if type(arg1.postBody) == "table" then
            var1 = HttpService:JSONEncode(arg1.postBody)
        elseif type(arg1.postBody) == "string" then
            var1 = arg1.postBody
        else
            error("Expected postBody to be a string or table")
        end

        if not arg1.contentType then
            arg1.contentType = ApplicationJson
        end

        if not arg1.throttlingPriority then
            arg1.throttlingPriority = Extreme
        end

        return function()
            return httpRbxApiService:PostAsyncFullUrl(str1, var1, arg1.throttlingPriority, arg1.contentType)
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
            var1 = doHttpPost(str1, arg2)
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

            spawn(function()
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
            end)
        end)
    end
end
