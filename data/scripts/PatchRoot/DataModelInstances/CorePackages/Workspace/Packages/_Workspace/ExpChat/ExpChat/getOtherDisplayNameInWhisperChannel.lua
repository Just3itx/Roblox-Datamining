-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local function getOtherDisplayNameInWhisperChannel(arg1, arg2)
    for _, child in ipairs(arg1:GetChildren()) do
        if not child:IsA("TextSource") then
            continue
        end

        local userId = child.UserId
        local player = Players:GetPlayerByUserId(userId)
        if player and player ~= arg2 then
            return player.DisplayName
        end
    end

    return nil
end

return getOtherDisplayNameInWhisperChannel
