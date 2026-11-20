-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:38:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local getModalWindowWidth = require(scriptParent.getModalWindowWidth)

local function getPartialPageModalMiddleContentWidth(num1: number, num2: number?)
    return getModalWindowWidth(num1) - 2 * (num2 or 24)
end

return getPartialPageModalMiddleContentWidth
