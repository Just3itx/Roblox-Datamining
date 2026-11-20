-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")

local FFlagEnableConsoleExpControls = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableConsoleExpControls

local ChromeEnabled = require(CorePackages.Workspace.Packages.Chrome).Enabled

return game:DefineFastFlag("TopBarDeprecateRespawnRodux2", false) and FFlagEnableConsoleExpControls and ChromeEnabled()
