-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:17:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

return require(CorePackages.Packages.Rodux).makeActionCreator(script.Name, function(enable)
    return { enable = enable }
end)
