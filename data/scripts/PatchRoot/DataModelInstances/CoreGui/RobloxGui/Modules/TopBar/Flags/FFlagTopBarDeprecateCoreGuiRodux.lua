-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")

local FFlagEnableConsoleExpControls = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableConsoleExpControls

local ChromeEnabled = require(CorePackages.Workspace.Packages.Chrome).Enabled

local FFlagTopBarSignalizeHealthBar = require(CorePackages.Workspace.Packages.CoreGuiCommon).Flags.FFlagTopBarSignalizeHealthBar

return game:DefineFastFlag("TopBarDeprecateCoreGuiRodux2", false)
    and FFlagTopBarSignalizeHealthBar
    and FFlagEnableConsoleExpControls
    and ChromeEnabled()
