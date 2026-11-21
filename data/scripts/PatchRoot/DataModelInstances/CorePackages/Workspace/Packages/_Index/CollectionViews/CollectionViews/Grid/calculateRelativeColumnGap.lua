-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViewsParent = script:FindFirstAncestor("CollectionViews").Parent
local ArgCheck = require(CollectionViewsParent.ArgCheck)

local function calculateRelativeColumnGap(num1: number, num2: number, num3: number, num4: number): number
    if num1 < 2 then
        return 0
    end
    ArgCheck.assert(num1 >= 2)

    local num5 = num1 * num3 + (num1 - 1) * num2 + num4 * 2
    return if num5 > 0 then num2 / num5 else 0
end

return calculateRelativeColumnGap
