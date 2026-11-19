-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

return require(CorePackages.Packages.Rodux).makeActionCreator("SET_RESPAWN_BEHAVIOR", function(respawnEnabled, customCallback)
    return { respawnEnabled = respawnEnabled, customCallback = customCallback }
end)
