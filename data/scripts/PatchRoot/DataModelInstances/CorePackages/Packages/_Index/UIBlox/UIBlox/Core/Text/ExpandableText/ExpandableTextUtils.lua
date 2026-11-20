-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GetTextHeight = require(script.Parent.Parent.GetTextHeight)

local function getExpandableTextHeights(arg1, arg2, arg3, arg4) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = arg1.BaseSize * arg1.Body.RelativeSize
    return GetTextHeight(arg3, arg1.Body.Font, var1, arg2), arg4 * var1
end

return {
    getExpandableTextHeights = getExpandableTextHeights,
    getCanExpand = function(arg1, arg2, arg3, arg4): boolean
        local var1, var2 = getExpandableTextHeights(arg1, arg2, arg3, arg4)
        return var2 < var1
    end
}
