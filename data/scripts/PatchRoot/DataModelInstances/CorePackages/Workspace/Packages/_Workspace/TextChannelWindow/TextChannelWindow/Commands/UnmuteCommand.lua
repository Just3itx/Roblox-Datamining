-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChannelWindowParent = script:FindFirstAncestor("TextChannelWindow").Parent

local ChatMute = require(TextChannelWindowParent.ChatMute)

return {
    aliases = { "/unmute", "/um" },
    run = function(str1: string, str2: string)
        local str3 = string.split(str1, " ")[2]
        local var1 = ChatMute.resolveUnmuteTarget(str3, str2)

        if var1.playerInfo then
            ChatMute.unmutePlayer(var1.playerInfo)
        end

        return {
            key = var1.key,
            args = var1.args
        }
    end
}
