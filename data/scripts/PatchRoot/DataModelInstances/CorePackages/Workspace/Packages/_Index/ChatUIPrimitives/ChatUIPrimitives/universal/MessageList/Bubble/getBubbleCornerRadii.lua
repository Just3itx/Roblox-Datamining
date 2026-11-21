-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:40:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _groupMessages = require(script.Parent.Parent.groupMessages)
local _Types = require(script.Parent.Types)

local function getBubbleCornerRadii(arg1, arg2, num1: number)
    local num2 = if arg1.isFirst then num1 else 0
    local num3 = if arg1.isLast then num1 else 0

    return if arg2 == "left" then {
        topLeft = num2,
        topRight = num1,
        bottomLeft = num3,
        bottomRight = num1
    } else { topLeft = num1, topRight = num2, bottomLeft = num1, bottomRight = num3 }
end

return getBubbleCornerRadii
