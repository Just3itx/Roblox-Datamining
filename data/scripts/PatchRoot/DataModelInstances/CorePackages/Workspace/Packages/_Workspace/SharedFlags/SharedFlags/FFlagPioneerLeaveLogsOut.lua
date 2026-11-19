-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T14:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagEnablePioneerPostAuthGameJoin = require(script.Parent.FFlagEnablePioneerPostAuthGameJoin)

return game:DefineFastFlag("PioneerLeaveLogsOut", false)
    and FFlagEnablePioneerPostAuthGameJoin
    and game:GetEngineFeature("ExperienceLeaveReasonEnabled")
    and game:GetEngineFeature("PioneerReturnToLuaAppOnReasonedLeave")
