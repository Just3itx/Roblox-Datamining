-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:40:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent
local React = require(RoactUtilsParent.React)

return function(callback: (...any) -> (...any), arg1)
    local var1 = React.useRef(false)

    React.useEffect(function()
        if arg1 and not var1.current then
            callback()
            var1.current = true
        end
    end, { arg1 })
end
