-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local scriptParentParentParent = script.Parent.Parent.Parent
local FFlagRoCaptchaReturnToServerInstance = require(scriptParentParentParent.Common.Flags.FFlagRoCaptchaReturnToServerInstance)

local module = {}

function module.isUniverseAllowed(str1: string, num1: number)
    local str2 = tostring(num1)
    for value in string.gmatch(str1, "[^,]+") do
        if string.match(value, "^%s*(.-)%s*$") == str2 then
            return true
        end
    end
    return false
end

function module.parseLaunchData(arg1)
    if type(arg1) ~= "string" or arg1 == "" then
        return nil
    end

    local success, result = pcall(HttpService.JSONDecode, HttpService, arg1)
    if not success or type(result) ~= "table" then
        return nil
    end

    local challengeId = result.challengeId
    local desiredPlaceId = tonumber(result.desiredPlaceId)
    if type(challengeId) ~= "string" or challengeId == "" then
        return nil
    end
    if not desiredPlaceId or desiredPlaceId <= 0 or desiredPlaceId % 1 ~= 0 then
        return nil
    end

    local serverInstanceId

    if FFlagRoCaptchaReturnToServerInstance then
        serverInstanceId = result.serverInstanceId
        if type(serverInstanceId) ~= "string"
            or not string.match(serverInstanceId, "^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$")
        then
            serverInstanceId = nil
        end
    else
        serverInstanceId = nil
    end

    return {
        challengeId = challengeId,
        desiredPlaceId = desiredPlaceId,
        serverInstanceId = serverInstanceId
    }
end

return module
