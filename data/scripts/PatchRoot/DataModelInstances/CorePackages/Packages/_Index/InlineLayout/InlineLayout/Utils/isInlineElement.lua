-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:39:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UtilsParent = script:FindFirstAncestor("Utils").Parent

local HardBreakElement = require(UtilsParent.Components.InlineLayout.InlineLayoutElements.HardBreakElement)
local InlineElementType = require(UtilsParent.Utils.InlineElementType)

local function isInlineElement(arg1): boolean
    if arg1 == HardBreakElement then
        return true
    end
    if type(arg1) ~= "table" then
        return false
    end

    local var1 = getmetatable(arg1)
    return not (var1 == nil) and var1.__type == InlineElementType
end

return isInlineElement
