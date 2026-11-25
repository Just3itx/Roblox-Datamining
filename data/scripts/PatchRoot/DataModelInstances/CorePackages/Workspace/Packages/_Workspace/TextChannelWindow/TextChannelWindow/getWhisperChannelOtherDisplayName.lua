-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local function getWhisperChannelOtherDisplayName(arg1, str1: string)
    for _, child in arg1:GetChildren() do
        if not child:IsA("TextSource") or tostring(child.UserId) == str1 then
            continue
        end

        local player = Players:GetPlayerByUserId(child.UserId)
        if player then
            return player.DisplayName
        end
    end

    return nil
end

return getWhisperChannelOtherDisplayName
