-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:51:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local _MomentsTypes = require(DataHydrationParent.MomentsTypes)

local function parseCommentsError(str1: string?)
    if type(str1) ~= "string" or str1 == "" then
        return nil
    end

    local var1 = string.find(str1, "{", 1, true)
    if var1 ~= nil then
        str1 = string.sub(str1, var1)
    end

    local success, result = pcall(HttpService.JSONDecode, HttpService, str1)
    if not success or type(result) ~= "table" then
        return nil
    end

    return if type(result.errorCode) == "string" and type(result.message) == "string" then {
        errorCode = result.errorCode,
        message = result.message
    } else nil
end

return parseCommentsError
