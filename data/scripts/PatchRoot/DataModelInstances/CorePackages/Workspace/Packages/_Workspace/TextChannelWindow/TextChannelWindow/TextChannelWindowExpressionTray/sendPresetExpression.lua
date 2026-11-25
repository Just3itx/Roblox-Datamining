-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChannelWindow = script:FindFirstAncestor("TextChannelWindow")
local Logger = require(TextChannelWindow.Logger)
local sendPreset = require(script.Parent.sendPreset)

local function sendPresetExpression(str1: string, arg1): boolean
    local var1 = sendPreset(str1, arg1)
    if var1 == "Sent" then
        return true
    end

    if var1 == "NoChannel" then
        Logger:warning("Preset not sent: no reachable channel")
    elseif var1 == "DirectChat" then
        Logger:warning("Preset not sent: direct chats do not support Quick Words")
    end
    return false
end

return sendPresetExpression
