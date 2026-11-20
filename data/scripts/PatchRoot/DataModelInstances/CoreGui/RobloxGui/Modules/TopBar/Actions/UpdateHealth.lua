-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:51:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local FFlagTopBarSignalizeHealthBar = require(CorePackages.Workspace.Packages.CoreGuiCommon).Flags.FFlagTopBarSignalizeHealthBar

local makeActionCreator = require(CorePackages.Packages.Rodux).makeActionCreator

if FFlagTopBarSignalizeHealthBar then
    return nil
end

return (makeActionCreator(script.Name, function(health, maxHealth)
    return { health = health, maxHealth = maxHealth }
end))
