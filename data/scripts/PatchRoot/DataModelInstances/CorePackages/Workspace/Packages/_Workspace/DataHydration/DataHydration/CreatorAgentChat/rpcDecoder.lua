-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpService = game:GetService("HttpService")
local _HttpClient = require(DataHydrationParent.HttpClient)

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

local function rpcDecoder(func1: ((...any) -> (...any))?)
    return function(arg1)
        local var1 = tryJsonDecode(arg1.responseBody)
        if typeof(var1) == "table" and var1.error then
            local error = var1.error
            return nil, tostring(error.message or "JSON-RPC error"), error.code
        end
        if not (arg1.statusCode >= 200 and arg1.statusCode < 300) then
            local var2 = if typeof(arg1.responseBody) == "buffer" then buffer.tostring(arg1.responseBody) else arg1.responseBody or ""

            return nil, ("CAS HTTP %d: %s"):format(arg1.statusCode, var2), nil
        end

        local result = if typeof(var1) == "table" then var1.result else nil

        if func1 == nil then
            return result, nil, nil
        end

        local var2, var3 = func1(result)
        return var2, var3, nil
    end
end

return rpcDecoder
