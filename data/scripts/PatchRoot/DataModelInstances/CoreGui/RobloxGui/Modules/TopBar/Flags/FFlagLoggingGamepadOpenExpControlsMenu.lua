-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
local Chrome = script.Parent.Parent.Parent.Chrome
local EnrolledConsoleExperienceControls = require(Chrome.Flags.EnrolledConsoleExperienceControls)

local bool1 = game:DefineFastFlag("LoggingGamepadOpenExpControlsMenu", false)

return EnrolledConsoleExperienceControls and bool1
