-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")

local FFlagEnableConsoleExpControls = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableConsoleExpControls

local ChromeEnabled = require(CorePackages.Workspace.Packages.Chrome).Enabled
local FFlagTopBarDeprecateGamepadNavigationDialogRodux = require(script.Parent.FFlagTopBarDeprecateGamepadNavigationDialogRodux)

local CoreGuiCommon = require(CorePackages.Workspace.Packages.CoreGuiCommon)
local FFlagTopBarSignalizeMenuOpen = CoreGuiCommon.Flags.FFlagTopBarSignalizeMenuOpen
local FFlagTopBarSignalizeKeepOutAreas = CoreGuiCommon.Flags.FFlagTopBarSignalizeKeepOutAreas
local FFlagTopBarSignalizeScreenSize = CoreGuiCommon.Flags.FFlagTopBarSignalizeScreenSize

return game:DefineFastFlag("TopBarDeprecateDisplayOptionsRodux2", false)
    and ChromeEnabled()
    and FFlagEnableConsoleExpControls
    and FFlagTopBarDeprecateGamepadNavigationDialogRodux
    and FFlagTopBarSignalizeMenuOpen
    and FFlagTopBarSignalizeKeepOutAreas
    and FFlagTopBarSignalizeScreenSize
