-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

return require(CorePackages.Packages.Rodux).makeActionCreator(script.Name, function(promptType, promptInfo)
    return { promptType = promptType, promptInfo = promptInfo }
end)
