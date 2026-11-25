-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:40:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent

local React = require(RoactUtilsParent.React)

return function(callback: ((...any) -> (...any))?)
    local var1 = React.useRef(false)
    local var2 = React.useRef(false)

    React.useEffect(function()
        if not var1.current then
            var1.current = true
            return
        end

        if not var2.current then
            var2.current = true
        end

        if callback then
            callback()
        end
    end)

    return var2
end
