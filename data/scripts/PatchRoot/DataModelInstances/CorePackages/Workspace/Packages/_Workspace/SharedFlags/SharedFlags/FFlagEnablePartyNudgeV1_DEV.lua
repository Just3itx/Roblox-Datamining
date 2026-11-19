-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T00:51:28Z
-- Luau bytecode version: 9 | Luau type version: 3
local GetFFlagIsSquadEnabled = require(script.Parent.GetFFlagIsSquadEnabled)
return game:DefineFastFlag("EnablePartyNudgeV1_DEV", false) and GetFFlagIsSquadEnabled()
