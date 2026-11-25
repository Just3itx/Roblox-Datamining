-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NotificationsUpsellConstants = require(script.Parent.Parent.NotificationsUpsellConstants)

local module = {}

function module.getPushUpsellPromptedCount(arg1, str1: string): number
    local success, result = pcall(function()
        return arg1:GetItem(str1)
    end)

    if not success then
        return -1
    end

    local var1 = tonumber(result)
    return if var1 == nil then 0 else var1
end

function module.getPushSysUpsellPromptTimestamp(arg1): number
    local success, result = pcall(function()
        return arg1:GetItem(NotificationsUpsellConstants.LocalStorageKeys.SysPromptShownTimestamp)
    end)

    if not success then
        return -1
    end

    local var1 = tonumber(result)
    return if var1 == nil then 0 else var1
end

function module.getPushEduUpsellResponseTimestamp(arg1): number
    local success, result = pcall(function()
        return arg1:GetItem(NotificationsUpsellConstants.LocalStorageKeys.EduPromptResponseTimestamp)
    end)

    if not success then
        return -1
    end

    local var1 = tonumber(result)
    return if var1 == nil then 0 else var1
end

function module.incrementPushUpsellPromptedCount(arg1, str1: string)
    local success, result = pcall(function()
        return arg1:GetItem(str1)
    end)

    if not success then
        return
    end

    local num1 = tonumber(result) or 0
    pcall(function()
        arg1:SetItem(str1, tostring(num1 + 1))
        arg1:Flush()
    end)
end

function module.setPushSysUpsellPromptTimestamp(arg1, num1: number)
    pcall(function()
        arg1:SetItem(NotificationsUpsellConstants.LocalStorageKeys.SysPromptShownTimestamp, tostring(num1))

        arg1:Flush()
    end)
end

function module.setPushEduUpsellResponseTimestamp(arg1, num1: number)
    pcall(function()
        arg1:SetItem(NotificationsUpsellConstants.LocalStorageKeys.EduPromptResponseTimestamp, tostring(num1))

        arg1:Flush()
    end)
end

function module.setPushEduUpsellResponse(arg1, str1: string)
    pcall(function()
        arg1:SetItem(NotificationsUpsellConstants.LocalStorageKeys.EduPromptResponse, str1)
        arg1:Flush()
    end)
end

return module
