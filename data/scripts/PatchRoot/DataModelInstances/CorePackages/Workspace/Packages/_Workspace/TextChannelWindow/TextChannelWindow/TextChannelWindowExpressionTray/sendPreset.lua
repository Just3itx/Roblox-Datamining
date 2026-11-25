-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")

local TextChannelWindow = script:FindFirstAncestor("TextChannelWindow")
local isDirectChatChannel = require(TextChannelWindow.isDirectChatChannel)
local FFlagExpChatUniverseChatPresetEnabled = require(TextChannelWindow.Flags.FFlagExpChatUniverseChatPresetEnabled)

local FFlagExpChatTextChannelWindowQuickWordsNonDirect = require(TextChannelWindow.Flags.FFlagExpChatTextChannelWindowQuickWordsNonDirect)
local Logger = require(TextChannelWindow.Logger)

local function getRBXGeneralChannel(): TextChannel? -- Luacid: unused: defined but never referenced
    local rbxGeneral = TextChatService:FindFirstChild("RBXGeneral", true)
    return if rbxGeneral and rbxGeneral:IsA("TextChannel") then rbxGeneral else nil
end

local function sendPreset(presetId: string, arg1)
    local var1 = arg1

    if FFlagExpChatTextChannelWindowQuickWordsNonDirect then
        if var1 ~= nil and isDirectChatChannel(var1) then
            return "DirectChat"
        end
    elseif var1 ~= nil and var1.Name ~= "RBXGeneral" then
        local rbxGeneral = TextChatService:FindFirstChild("RBXGeneral", true)
        var1 = rbxGeneral and rbxGeneral:IsA("TextChannel") and rbxGeneral or nil
    end

    if var1 then
        local success, result = pcall(function()
            var1:SendPresetAsync(presetId)
        end)
        if success then
            return "Sent"
        end

        Logger:warning("SendPresetAsync failed: {}", tostring(result))
        return "SendFailed"
    end

    if not FFlagExpChatUniverseChatPresetEnabled then
        return "NoChannel"
    end
    local success, result = pcall(function()
        TextChatService:SendUniverseChatPresetAsync(presetId)
    end)
    if success then
        return "Sent"
    end

    Logger:warning("SendUniverseChatPresetAsync failed: {}", tostring(result))
    return "SendFailed"
end

return sendPreset
