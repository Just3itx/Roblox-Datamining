-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("TextChatEnableUniverseChatTabs11", false)

return function(): boolean
    return game:GetFastFlag("TextChatEnableUniverseChatTabs11") and game:GetEngineFeature("TextChatUniverseChatChannelAllocated")
end
