-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local _types = require(script.Parent.Parent.types)

local function trim(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return (str1:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function stripFrame(str1: string)
    local var1 = trim(str1)

    if var1 == "" then
        return nil
    end
    if var1:sub(1, 1) == ":" then
        return nil
    end
    if var1:sub(1, 5) == "data:" then
        var1 = trim((var1:sub(6)))
        if var1 == "" or var1 == "[DONE]" then
            return nil
        end
    end
    return var1
end

local function parseFrame(str1: string)
    local var1 = stripFrame(str1)
    if var1 == nil then
        return nil
    end

    local success, result = pcall(HttpService.JSONDecode, HttpService, var1)
    if not success or typeof(result) ~= "table" then
        return nil
    end

    if result.jsonrpc == nil then
        return nil
    end

    local bool1 = typeof(result.method) == "string" and result.method ~= ""
    local bool2 = result.id ~= nil
    local bool3 = typeof(result.error) == "table"

    if bool1 and not bool2 then
        local params = result.params
        return if params == nil or typeof(params) == "table" then {
            kind = "notification",
            notification = {
                method = result.method,
                params = params or {}
            }
        } else nil
    end

    if not bool2 or not bool3 or bool1 then
        return nil
    end

    return {
        kind = "response",
        response = {
            jsonrpc = result.jsonrpc,
            id = result.id,
            result = nil,
            error = result.error
        }
    }
end

return parseFrame
