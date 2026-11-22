-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")
local HttpService = game:GetService("HttpService")

local ServerTriggeredModalsParent = script:FindFirstAncestor("ServerTriggeredModals").Parent

local FIntEdpGameLeavePromptsRecentInstallWindowDays = require(ServerTriggeredModalsParent.SharedFlags).FIntEdpGameLeavePromptsRecentInstallWindowDays
local isAppFirstLaunchTimestampsSupported = require(script.Parent.isAppFirstLaunchTimestampsSupported)

local function readFirstLaunchTimestamp(str1: string)
    local item = AppStorageService:GetItem("AppFirstLaunchTimestamps")
    if typeof(item) ~= "string" or item == "" then
        return nil
    end

    local success, result = pcall(function()
        return HttpService:JSONDecode(item)
    end)
    if not success or type(result) ~= "table" then
        return nil
    end

    local var1 = result[str1]
    return if type(var1) == "number" then var1 else nil
end

local function isRecentInstall(str1: string?): boolean
    if not isAppFirstLaunchTimestampsSupported() then
        return false
    end

    if str1 == nil or str1 == "" or str1 == "-1" then
        return false
    end

    local var1 = readFirstLaunchTimestamp(str1)
    return not (var1 == nil) and FIntEdpGameLeavePromptsRecentInstallWindowDays * 86400 >= DateTime.now().UnixTimestamp - var1
end

return isRecentInstall
