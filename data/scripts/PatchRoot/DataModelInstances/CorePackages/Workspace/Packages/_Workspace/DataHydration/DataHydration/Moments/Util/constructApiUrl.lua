-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Http = require(DataHydrationParent.Http)
local _HttpClient = require(DataHydrationParent.HttpClient)
local FStringArgusApiUrlBase = require(DataHydration.Moments.FStringArgusApiUrlBase)

local function normalizeBaseUrl(str1: string): string -- Luacid: Inlined by compiler; 3 call sites recovered
    if str1:sub(#str1) == "/" then
        return str1:sub(1, #str1 - 1)
    end

    return str1
end

local function normalizePath(str1: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    if str1:sub(1, 1) == "/" then
        return str1
    end

    return `/{str1}`
end

local function getFStringApiUrlBase() -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = FStringArgusApiUrlBase()
    if var1 == "" then
        return nil
    end

    local str1 = normalizeBaseUrl(var1)
    return if str1:match("^https?://") == nil then nil else str1
end

local function constructApiUrl(str1: string)
    assert(type(str1) == "string", "path must be a string")
    local localPlayer = game:GetService("Players").LocalPlayer
    local fStringApiUrlBase = getFStringApiUrlBase()

    if fStringApiUrlBase == nil then
        fStringApiUrlBase = Http.Url.APIS_URL
    end

    local str2 = normalizeBaseUrl(fStringApiUrlBase)
    local str3 = `{str2}{normalizePath(str1)}`

    if str2 == "https://apis.roblox.com" or localPlayer == nil then
        return str3, nil
    end

    return str3, {
        ["robloxctx-authenticated-userid"] = tostring(localPlayer.UserId)
    }
end
return constructApiUrl
