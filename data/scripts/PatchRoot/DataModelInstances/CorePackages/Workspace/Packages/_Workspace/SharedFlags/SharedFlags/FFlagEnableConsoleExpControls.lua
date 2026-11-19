-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T13:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParent = script.Parent
local FFlagEnableConsoleExpControlsIXP = require(scriptParent:WaitForChild("FFlagEnableConsoleExpControlsIXP"))

local FFlagEnableInExperienceHandheldControls = require(scriptParent:WaitForChild("FFlagEnableInExperienceHandheldControls"))
local bool1 = game:DefineFastFlag("EnableConsoleExpControls684", false)

return FFlagEnableConsoleExpControlsIXP or FFlagEnableInExperienceHandheldControls or bool1
