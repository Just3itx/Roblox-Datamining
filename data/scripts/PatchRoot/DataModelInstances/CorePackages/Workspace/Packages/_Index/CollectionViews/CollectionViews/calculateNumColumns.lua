-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionViewsParent = script:FindFirstAncestor("CollectionViews").Parent
local ArgCheck = require(CollectionViewsParent.ArgCheck)

local function calculateNumColumns(num1: number, num2: number, num3: number, num4: number, num5: number, bool1: boolean?): number
    ArgCheck.assert(num1 >= 1)
    ArgCheck.assert(num2 >= 0)
    local num6 = math.floor((num5 + num2) / (num1 + num2))
    if bool1 then
        num6 = math.floor(num6 * 0.5) * 2
    end
    return math.min(num4, math.max(num3, num6))
end
return calculateNumColumns
