-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local FFlagEnableConsoleExpControls = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableConsoleExpControls

local isNewInGameMenuEnabled = require(RobloxGui.Modules.isNewInGameMenuEnabled)

return game:DefineFastFlag("TopBarDeprecateGameInfoRodux", false)
    and FFlagEnableConsoleExpControls
    and not isNewInGameMenuEnabled
