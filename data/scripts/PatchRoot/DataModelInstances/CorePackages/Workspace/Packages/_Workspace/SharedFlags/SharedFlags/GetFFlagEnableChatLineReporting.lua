-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T03:20:31Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("EnableChatLineReporting2", false)

return function(): boolean
    return game:GetFastFlag("EnableChatLineReporting2") and game:GetEngineFeature("ChatLineAbuseReportAPIEnabled")
end
