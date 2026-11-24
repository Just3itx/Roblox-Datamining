-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local function parseGamePassTrialRedeemErrorCode(arg1)
    if typeof(arg1) ~= "table" then
        return nil
    end
    local errorMessage = arg1.errorMessage
    if type(errorMessage) ~= "string" then
        return nil
    end

    local var1 = string.find(errorMessage, "{", 1, true)
    if var1 == nil then
        return nil
    end
    local success, result = pcall(HttpService.JSONDecode, HttpService, string.sub(errorMessage, var1))
    return if success and type(result) == "table" and type(result.errorCode) == "string" then result.errorCode else nil
end

return parseGamePassTrialRedeemErrorCode
