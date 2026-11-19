-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T00:21:14Z
-- Luau bytecode version: 9 | Luau type version: 3
local scriptParent = script.Parent
local FFlagEnableConsoleExpControls = require(scriptParent:WaitForChild("FFlagEnableConsoleExpControls"))
local bool1 = game:DefineFastFlag("ChromeShortcutRemoveRespawnOnLeavePage", false)

return FFlagEnableConsoleExpControls and bool1
