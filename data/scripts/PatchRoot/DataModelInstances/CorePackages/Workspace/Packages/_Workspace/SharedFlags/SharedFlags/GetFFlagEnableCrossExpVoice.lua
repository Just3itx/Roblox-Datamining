-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T03:20:41Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
return function(): boolean
    return game:GetEngineFeature("EnableCrossExpVoice") and game:GetEngineFeature("VoiceChatSupported")
end
