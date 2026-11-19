-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

return require(CorePackages.Packages.Rodux).makeActionCreator("OPEN_REPORT_DIALOG", function(userId, userName)
    return { userId = userId, userName = userName }
end)
