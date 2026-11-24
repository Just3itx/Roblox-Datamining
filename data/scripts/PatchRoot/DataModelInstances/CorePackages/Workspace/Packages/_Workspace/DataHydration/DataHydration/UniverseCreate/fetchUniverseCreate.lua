-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:30:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local UrlBase = require(DataHydrationParent.UrlBuilder).UrlBase

local withCsrfRetry = require(DataHydration.withCsrfRetry)
local _UniverseCreateStoreTypes = require(script.Parent.UniverseCreateStoreTypes)

local function tryJsonDecode(buf) -- Luacid: Inlined by compiler; 1 call site recovered
    if buf == nil or buf == "" then
        return nil
    end
    if typeof(buf) == "buffer" then
        buf = buffer.tostring(buf)
    end

    local success, result = pcall(HttpService.JSONDecode, HttpService, buf)
    return if success then result else nil
end

local function decode(arg1)
    local var1 = tryJsonDecode(arg1.responseBody)
    if typeof(var1) == "table" and typeof(var1.code) == "string" and typeof(var1.message) == "string" then
        return nil, ("%s: %s"):format(var1.code, var1.message), arg1.statusCode
    end
    if not (arg1.statusCode < 200 or arg1.statusCode >= 300) then
        return var1, nil, nil
    end

    local var2 = if typeof(arg1.responseBody) == "buffer" then buffer.tostring(arg1.responseBody) else arg1.responseBody or ""

    return nil, ("http %d: %s"):format(arg1.statusCode, var2), arg1.statusCode
end

local function fetchUniverseCreate(body, tbl1)
    local tbl2 = tbl1 or {}

    local networkImpl = tbl2.network or withCsrfRetry(HttpClient.createRequestInternalNetwork())
    local var2 = tbl2.baseUrl or UrlBase.APIS

    local request = HttpClient.createRequest({
        networkImpl = networkImpl,
        method = "POST",
        url = var2 .. "/universes/v1/universes/create",
        body = body,
        analyticsKey = "universes-create.create",
        decode = decode
    })
    return HttpClient.asPromise(request)
end

return fetchUniverseCreate
