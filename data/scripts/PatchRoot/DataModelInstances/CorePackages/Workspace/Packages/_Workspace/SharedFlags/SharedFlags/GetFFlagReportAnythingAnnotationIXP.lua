-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T16:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("ReportAnythingAnnotationIXP", false)

return function(): boolean
    return game:GetEngineFeature("ReportAnythingScreenshotOrientation") and game:GetFastFlag("ReportAnythingAnnotationIXP")
end
