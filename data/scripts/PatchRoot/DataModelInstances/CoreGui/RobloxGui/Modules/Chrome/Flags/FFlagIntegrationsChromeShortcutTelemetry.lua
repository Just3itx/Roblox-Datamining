-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
local Chrome = script.Parent.Parent.Parent.Chrome
local EnrolledConsoleExperienceControls = require(Chrome.Flags.EnrolledConsoleExperienceControls)

local bool1 = game:DefineFastFlag("IntegrationsChromeShortcutTelemetry", false)

return EnrolledConsoleExperienceControls or bool1
