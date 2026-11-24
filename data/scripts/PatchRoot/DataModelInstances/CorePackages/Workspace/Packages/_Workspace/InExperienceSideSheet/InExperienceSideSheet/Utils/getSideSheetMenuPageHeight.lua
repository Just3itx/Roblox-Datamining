-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")

local Constants = require(InExperienceSideSheet.Common.Constants)

return function(num1: number, num2: number)
    return num1 - Constants.MenuScreenMargin * 2 - num2
end
