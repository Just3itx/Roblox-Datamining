-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default

return function(str1: string, str2: string)
    return default:GetIcon(str1, str2)
end
