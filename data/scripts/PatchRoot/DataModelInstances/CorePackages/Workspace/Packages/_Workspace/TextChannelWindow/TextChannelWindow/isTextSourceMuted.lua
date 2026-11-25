-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChannelWindowParent = script:FindFirstAncestor("TextChannelWindow").Parent
local ChatMute = require(TextChannelWindowParent.ChatMute)

return function(arg1): boolean
    local str1 = tostring(arg1.UserId)
    if ChatMute.isUserIdMuted(str1) then
        return true
    end
    local player = game:GetService("Players"):GetPlayerByUserId(arg1.UserId)
    return not (player == nil) and (ChatMute.isUsernameMuted(player.Name) or ChatMute.isDisplayNameMuted(player.DisplayName))
end
