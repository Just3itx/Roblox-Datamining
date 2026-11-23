-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getCornerRadii = require(script.Parent.Parent.getCornerRadii)

local function getMomentShareCardCornerRadii(bool1: boolean?, bool2: boolean?, num1: number)
    return getCornerRadii({ topLeft = not (not bool1 and bool2), topRight = not not (bool1 or bool2) }, num1)
end

return getMomentShareCardCornerRadii
