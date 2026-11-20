-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependenciesText = require(SocialLibraries.dependencies).Text

return function(str1: string, arg1, num1: number)
    return dependenciesText.GetTextHeight(str1, arg1, num1)
end
