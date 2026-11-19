-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls
local FFlagUnibarMenuOpenHamburgerGamepadIXP = SharedFlags.FFlagUnibarMenuOpenHamburgerGamepadIXP
local bool1 = game:DefineFastFlag("UnibarMenuOpenHamburger", false)

return FFlagEnableConsoleExpControls and (FFlagUnibarMenuOpenHamburgerGamepadIXP or bool1)
