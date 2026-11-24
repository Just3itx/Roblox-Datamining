-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")

return function(): boolean
    return TextChatService.ChatVersion ~= Enum.ChatVersion.LegacyChatService
end
