-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:21:15Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local function useAbsoluteSize(callback: ((...any) -> (...any))?)
    local var1, var2 = React.useState(Vector2.zero)

    return var1, (React.useCallback(function(arg1)
        var2(arg1.AbsoluteSize)
        if callback then
            callback(arg1)
        end
    end, { callback }))
end

return useAbsoluteSize
