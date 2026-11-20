-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
local Settings = script:FindFirstAncestor("Settings")

local FFlagRefactorInExpSettingsInDevelopment = require(Settings.Flags).FFlagRefactorInExpSettingsInDevelopment

local Integrations = Settings.Integrations

return {
    Settings = if FFlagRefactorInExpSettingsInDevelopment then require(Integrations.Settings) else nil,
    Constants = require(Integrations.Constants),
    Utils = require(Integrations.Utils)
}
