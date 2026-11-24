-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local _types = require(script.Parent.types)
local decodeFundingError = require(script.Parent.decodeFundingError)

local function getFundingError(arg1)
    if arg1.status ~= "failed" or arg1.response == nil then
        return nil, nil
    end
    local responseBody = arg1.response.responseBody
    if responseBody == nil or responseBody == "" then
        return nil, nil
    end
    if typeof(responseBody) == "buffer" then
        responseBody = buffer.tostring(responseBody)
    end

    local success, result = pcall(HttpService.JSONDecode, HttpService, responseBody)
    if not success or typeof(result) ~= "table" then
        return nil, nil
    end
    return decodeFundingError(result.error)
end

return getFundingError
