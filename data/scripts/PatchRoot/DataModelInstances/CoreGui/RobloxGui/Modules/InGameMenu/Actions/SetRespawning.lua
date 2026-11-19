-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

return require(CorePackages.Packages.Rodux).makeActionCreator("SET_RESPAWNING", function(respawning)
    return { respawning = respawning }
end)
