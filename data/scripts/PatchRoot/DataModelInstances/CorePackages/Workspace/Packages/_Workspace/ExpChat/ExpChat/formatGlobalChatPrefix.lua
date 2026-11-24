-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local ExpChat = script:FindFirstAncestor("ExpChat")

local isGlobalMessagePrefixEnabled = require(ExpChat.isGlobalMessagePrefixEnabled)
local isGlobalChatMessage = require(ExpChat.isGlobalChatMessage)

local function formatGlobalChatPrefix(str1: string, tbl1, str2: string?, arg1): string
    local var1 = arg1 or Players
    if not isGlobalMessagePrefixEnabled() or not isGlobalChatMessage(tbl1) or #str1 == 0 or str2 == nil or str2 == "" then
        return str1
    else
        local var2 = tonumber(tbl1.userId)
        if var2 == nil or var1:GetPlayerByUserId(var2) == nil then
            return str1
        end

        local localPlayer = var1.LocalPlayer
        if localPlayer ~= nil and var2 == localPlayer.UserId then
            return str1
        end

        local var3, var4 = string.match(str1, "^(<font[^>]*>)(.*)$")
        if var3 ~= nil and var4 ~= nil then
            return `{var3}{str2} \194\183 {var4}`
        end

        return `{str2} \194\183 {str1}`
    end
end
return formatGlobalChatPrefix
