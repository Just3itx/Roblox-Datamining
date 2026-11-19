-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
return require(CorePackages.Packages.Rodux).makeActionCreator(script.Name, function(errorMessage)
    return { errorMessage = errorMessage }
end)
