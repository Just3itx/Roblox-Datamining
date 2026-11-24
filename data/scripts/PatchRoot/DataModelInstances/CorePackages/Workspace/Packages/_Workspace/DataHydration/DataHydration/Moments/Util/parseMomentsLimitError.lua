-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local DataHydration = script:FindFirstAncestor("DataHydration")

local _MomentsStoreTypes = require(DataHydration.Moments.MomentsStoreTypes)

local function parseMomentsLimitError(arg1): {limitSeconds: number, resetsAt: number}?
    local errorMessage = if type(arg1) == "table" then arg1.errorMessage else nil

    if type(errorMessage) ~= "string" then
        return nil
    end

    local var1 = string.find(errorMessage, "{", 1, true)
    if var1 == nil then
        return nil
    end
    local success, result = pcall(HttpService.JSONDecode, HttpService, string.sub(errorMessage, var1))
    if not success or type(result) ~= "table" then
        return nil
    end

    local limitSeconds = result.limitSeconds

    if result.errorCode ~= "MomentsDailyLimitReached" or type(limitSeconds) ~= "number" then
        return nil
    end

    return {
        limitSeconds = limitSeconds,
        resetsAt = if type(result.resetsAt) == "string" then result.resetsAt else nil
    }
end

return parseMomentsLimitError
