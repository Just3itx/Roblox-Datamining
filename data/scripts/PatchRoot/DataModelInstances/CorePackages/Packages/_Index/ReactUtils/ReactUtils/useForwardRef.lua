-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactUtilsParent = script:FindFirstAncestor("ReactUtils").Parent
local React = require(ReactUtilsParent.React)

local function useForwardRef(arg1, func1: (...any) -> (...any))
    local var1 = React.useRef(nil)
    local var2 = React.useRef(nil)

    local var3 = React.useCallback(function(current)
        if var2.current then
            var2.current()
            var2.current = nil
        end
        if current then
            var1.current = current
            var2.current = func1(current)
        end
    end, { func1 })

    React.useImperativeHandle(arg1, function()
        return var1.current
    end)

    return var3
end

return useForwardRef
