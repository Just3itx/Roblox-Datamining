-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")

local FIntFreeTrialTopBarChipSwipeThreshold = require(InExperienceShop.Flags.FIntFreeTrialTopBarChipSwipeThreshold)

local function isDismissSwipe(num1: number, num2: number): boolean
    local num3 = math.abs(num1)
    return FIntFreeTrialTopBarChipSwipeThreshold <= num3 and math.abs(num1) > math.abs(num2)
end

return isDismissSwipe
