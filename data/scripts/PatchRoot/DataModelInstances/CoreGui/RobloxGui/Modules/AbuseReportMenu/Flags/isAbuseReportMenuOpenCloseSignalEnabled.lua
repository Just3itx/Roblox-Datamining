-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("AbuseReportMenuOpenCloseSignal", false)

return function(): boolean
    if not game:GetEngineFeature("AbuseReportMenuOpenCloseSignal") then
        return false
    end

    return game:GetFastFlag("AbuseReportMenuOpenCloseSignal")
end
