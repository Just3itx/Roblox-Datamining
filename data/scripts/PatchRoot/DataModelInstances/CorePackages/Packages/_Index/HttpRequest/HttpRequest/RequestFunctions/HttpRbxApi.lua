-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local HttpService = game:GetService("HttpService")

local StatusCode = require(script.Parent.Parent.StatusCode)

local Extreme = Enum.ThrottlingPriority.Extreme
local ApplicationJson = Enum.HttpContentType.ApplicationJson

local function doHttpGet(apiUrl: string, arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return pcall(function(): string
        return HttpRbxApiService:GetAsyncFullUrl(apiUrl, arg1.throttlingPriority or Extreme, arg1.httpRequestType or nil)
    end)
end

local function doHttpPost(apiUrl: string, arg1): boolean
    local var1 = nil
    assert(arg1.postBody, "Expected a postBody to be specified with this request")
    if type(arg1.postBody) == "table" then
        var1 = HttpService:JSONEncode(arg1.postBody)
    elseif type(arg1.postBody) == "string" then
        var1 = arg1.postBody
    else
        error("Expected postBody to be a string or table")
    end

    return pcall(function(): string
        return HttpRbxApiService:PostAsyncFullUrl(
            apiUrl,
            var1,
            arg1.throttlingPriority or Extreme,
            arg1.contentType or ApplicationJson,
            arg1.httpRequestType or nil
        )
    end)
end

local function createResponse(input: string)
    local ok = StatusCode.OK

    local success, _result = pcall(function()
        return HttpService:JSONDecode(input)
    end)

    if not success then
        ok = tonumber(input:sub(6, 8))
    end

    return {
        Body = input,
        StatusCode = ok,
        Headers = {}
    }
end

return function(apiUrl, arg1, arg2)
    return {
        Start = function(_, callback)
            local success = nil
            local var1 = nil
            if arg1 == "GET" then
                success, var1 = doHttpGet(apiUrl, arg2)
            elseif arg1 == "POST" then
                success, var1 = doHttpPost(apiUrl, arg2)
            else
                error("Unsupported method: " .. arg1)
            end

            callback(success, (createResponse(var1)))
        end,
        Cancel = function() end
    }
end
