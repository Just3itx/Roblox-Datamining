-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T16:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(): boolean
    return game:GetEngineFeature("EnableCrossExpVoice") and game:GetEngineFeature("VoiceChatSupported")
end
