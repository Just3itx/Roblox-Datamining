-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViewsParent = script:FindFirstAncestor("CollectionViews").Parent
local ArgCheck = require(CollectionViewsParent.ArgCheck)

local function calculateItemWidth(num1: number, num2: number, num3: number, num4: number, num5: number, num6: number?): number
    if num1 <= 0 then
        return 0
    end
    ArgCheck.assert(num1 >= 1)

    local num7 = num2 * (num1 - 1)
    return math.max(1, (num4 - (num3 * 2 + (num6 or 0)) - num7) / (num1 + num5))
end

return calculateItemWidth
