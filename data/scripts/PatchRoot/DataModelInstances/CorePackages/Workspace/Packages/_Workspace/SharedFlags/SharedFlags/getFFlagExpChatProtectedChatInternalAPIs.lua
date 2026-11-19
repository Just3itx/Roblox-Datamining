-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T16:21:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("ExpChatUseInternalTextChatAPIs2", false)

return function(): boolean
    return game:GetFastFlag("ExpChatUseInternalTextChatAPIs2")
        and game:GetEngineFeature("TextChatServiceInternalAPIs2")
        and game:GetEngineFeature("TextChatServiceProtectedChatEnabled")
        and game:GetService("TextChatService"):IsProtectedChatEnabled()
end
