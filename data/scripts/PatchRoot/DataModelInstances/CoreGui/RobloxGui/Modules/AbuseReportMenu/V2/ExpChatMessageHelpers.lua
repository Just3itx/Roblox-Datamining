-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")

local CorePackages = game:GetService("CorePackages")
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagEnableGlobalChatAbuseReporting = SharedFlags.FFlagEnableGlobalChatAbuseReporting
local FFlagAbuseReportAttributedRBXSystemMessages = SharedFlags.FFlagAbuseReportAttributedRBXSystemMessages

local module = { CHANNEL_GENERAL = "RBXGeneral", CHANNEL_GLOBAL = "RBXGlobal" }

function module.areChannelTabsEnabled()
    local channelTabsConfiguration = TextChatService:FindFirstChildOfClass("ChannelTabsConfiguration")
    return not (channelTabsConfiguration == nil) and channelTabsConfiguration.Enabled
end

function module.localizeString(arg1, str1: string): string
    if not arg1 then
        return str1
    end
    local success, result = pcall(arg1.TranslateGameText, arg1, game, str1)
    return if success and type(result) == "string" then result else str1
end

function module.isSystemMessage(arg1): boolean
    return not (FFlagAbuseReportAttributedRBXSystemMessages or not arg1.textChannel or arg1.textChannel.Name ~= "RBXSystem")
        or not arg1.userId
        or arg1.userId == "0"
        or false
end

function module.formatChannelLabel(str1: string, arg1)
    if string.find(str1, "RBXGeneral") then
        return "General"
    end

    if string.find(str1, "^RBXTeam") then
        return "Team"
    end

    if not string.find(str1, "^RBXWhisper") then
        return if FFlagEnableGlobalChatAbuseReporting and str1 == "RBXGlobal" then "Global" else str1
    end

    if arg1 and Players.LocalPlayer then
        for _, child in ipairs(arg1:GetChildren()) do
            if not child:IsA("TextSource") then
                continue
            end

            local player = Players:GetPlayerByUserId(child.UserId)
            if player and player ~= Players.LocalPlayer then
                return player.DisplayName
            end
        end
    end

    return "Whisper"
end

function module.formatMessageLabel(arg1)
    local prefixText = arg1.prefixText or ""
    local text = arg1.text or ""
    return if #prefixText > 0 then prefixText .. " " .. text else text
end

function module.getMessageUsername(arg1)
    local var1 = tonumber(arg1.userId)

    if var1 and var1 ~= 0 then
        local player = Players:GetPlayerByUserId(var1)
        if player then
            return player.Name
        end
    end

    local textChatMessageInstance = arg1.textChatMessageInstance
    if textChatMessageInstance then
        local textSource = textChatMessageInstance.TextSource
        if textSource and textSource.Username and #textSource.Username > 0 then
            return textSource.Username
        end
    end

    return nil
end

function module.collectItems(arg1, arg2)
    local result = {}
    for _, value in ipairs(arg2) do
        local var1 = arg1[value]
        if not var1 or module.isSystemMessage(var1) then
            continue
        end

        table.insert(result, {
            id = var1.messageId,
            label = module.formatMessageLabel(var1),
            meta = {
                textChannel = var1.textChannel,
                userId = tostring(var1.userId),
                presetId = var1.presetId,
                presetChatVersion = var1.presetChatVersion,
                username = module.getMessageUsername(var1)
            }
        })
    end

    return result
end

function module.annotateWhisperItems(tbl1, arg1, str1: string)
    for _, value in ipairs(tbl1) do
        local var1 = arg1[value.id]
        if var1
            and var1.textChannel
            and typeof(var1.textChannel.Name) == "string"
            and string.sub(var1.textChannel.Name, 1, 10) == "RBXWhisper"
        then
            value.label = string.format("[%s] %s", str1, value.label)
        end
    end
end

return module
