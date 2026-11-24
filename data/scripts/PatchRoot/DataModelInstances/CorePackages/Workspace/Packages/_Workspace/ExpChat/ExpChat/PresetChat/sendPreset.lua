-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:20:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")

local ExpChat = script:FindFirstAncestor("ExpChat")
local FFlagExpChatUniverseChatPresetEnabled = require(ExpChat.Flags.FFlagExpChatUniverseChatPresetEnabled)

local function getRBXGeneralChannel(): TextChannel? -- Luacid: unused: defined but never referenced
    local rbxGeneral = TextChatService:FindFirstChild("RBXGeneral", true)
    return if rbxGeneral and rbxGeneral:IsA("TextChannel") then rbxGeneral else nil
end

local function sendPreset(presetId: string, arg1): string
    local var1 = arg1

    if var1 ~= nil and var1.Name ~= "RBXGeneral" then
        local rbxGeneral = TextChatService:FindFirstChild("RBXGeneral", true)
        var1 = rbxGeneral and rbxGeneral:IsA("TextChannel") and rbxGeneral or nil
    end

    if var1 then
        return if pcall(function()
            var1:SendPresetAsync(presetId)
        end) then "Sent" else "SendFailed"
    end

    if FFlagExpChatUniverseChatPresetEnabled then
        return if pcall(function()
            TextChatService:SendUniverseChatPresetAsync(presetId)
        end) then "Sent" else "SendFailed"
    end

    return "NoChannel"
end

return sendPreset
