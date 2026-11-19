-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T15:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
local bool1 = game:DefineFastFlag("VirtualCursorInputSink", false)
local engineFeature = game:GetEngineFeature("InputSink")

return bool1 and engineFeature
