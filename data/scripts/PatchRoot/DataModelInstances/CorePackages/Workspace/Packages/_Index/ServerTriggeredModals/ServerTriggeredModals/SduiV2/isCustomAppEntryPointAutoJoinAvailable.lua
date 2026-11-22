-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isCustomAppEntryPointAutoJoinAvailable(): boolean
    return game:GetEngineFeature("CustomAppEntryPointAutoJoin")
end

return isCustomAppEntryPointAutoJoinAvailable
