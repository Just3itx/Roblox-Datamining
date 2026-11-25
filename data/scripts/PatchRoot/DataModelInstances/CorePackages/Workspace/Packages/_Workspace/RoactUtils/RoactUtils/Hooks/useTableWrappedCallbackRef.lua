-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent

local React = require(RoactUtilsParent.React)

local function useTableWrappedCallbackRef(arg1)
    local var1 = React.useRef(nil)

    React.useImperativeHandle(arg1, function()
        return var1.current
    end)

    return var1
end

return useTableWrappedCallbackRef
