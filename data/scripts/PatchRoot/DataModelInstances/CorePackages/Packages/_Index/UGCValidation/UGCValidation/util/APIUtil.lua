-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local ContentProvider = game:GetService("ContentProvider")

local module = {}

function module.getBaseDomain(): string
    local baseUrl = ContentProvider.BaseUrl
    if string.sub(baseUrl, #baseUrl) ~= "/" then
        baseUrl ..= "/"
    end
    local _, var1 = string.find(baseUrl, "://")
    local _, var2 = string.find(baseUrl, "%.", var1 + 1)
    return string.sub(baseUrl, var2 + 1)
end

local function requestAndRetry(callback: (...any) -> (...any), num1: number?)
    num1 = if num1 == nil then 0 else num1

    local success, result = pcall(callback)

    if success then
        return true, result
    end

    if num1 >= 2 then
        return false, result
    end
    local var1 = 2 ^ (num1 - 1)
    wait(var1)
    return requestAndRetry(callback, num1 + 1)
end

function module.requestAndRetryPost(apiUrl: string, str1: string)
    return requestAndRetry(function(): string
        return HttpRbxApiService:PostAsyncFullUrl(apiUrl, str1)
    end)
end

function module.requestAndRetryGet(apiUrl: string)
    return requestAndRetry(function(): string
        return HttpRbxApiService:GetAsyncFullUrl(apiUrl)
    end)
end

return module
