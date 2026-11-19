-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T03:20:51Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local bool1 = game:DefineFastFlag("EnableInAppBugReporting", false)

return function(): boolean
    return bool1 and game:GetEngineFeature("BugReporterProtocol")
end
