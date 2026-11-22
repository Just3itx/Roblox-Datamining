-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local parseApiError = require(script.Parent.parseApiError)
local parseLegacyError = require(script.Parent.parseLegacyError)
local _types = require(script.Parent.types)
local isSuccess = require(script.Parent.httpStatus).isSuccess

local function bodyToString(buf: buffer) -- Luacid: Inlined by compiler; 5 call sites recovered
    if buf == nil then
        return nil
    elseif typeof(buf) == "buffer" then
        return buffer.tostring(buf)
    end
    return buf
end

local function tryJsonDecode(responseBody) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = bodyToString(responseBody)

    if var1 == nil or var1 == "" then
        return nil
    end
    local success, result = pcall(HttpService.JSONDecode, HttpService, var1)
    return if success then result else nil
end

return {
    decodeJson = function(func1: (...any) -> (...any))
        return function(arg1)
            local var1 = tryJsonDecode(arg1.responseBody)
            local var2 = parseApiError(var1)
            if var2 then
                return nil, `api error {var2.code}: {var2.message}`, var2.code
            elseif not isSuccess(arg1.statusCode) then
                return nil, `http {arg1.statusCode}: {bodyToString(arg1.responseBody) or ""}`, arg1.statusCode
            end
            return func1(var1), nil, nil
        end
    end,
    decodeLegacyJson = function(func1: (...any) -> (...any))
        return function(arg1)
            local var1 = tryJsonDecode(arg1.responseBody)
            local var2 = parseLegacyError(var1)
            if var2 then
                local error = var2.errors[1]
                return nil, `api error {error.code}: {error.message}`, error.code
            elseif not isSuccess(arg1.statusCode) then
                return nil, `http {arg1.statusCode}: {bodyToString(arg1.responseBody) or ""}`, arg1.statusCode
            else
                return func1(var1), nil, nil
            end
        end
    end
}
