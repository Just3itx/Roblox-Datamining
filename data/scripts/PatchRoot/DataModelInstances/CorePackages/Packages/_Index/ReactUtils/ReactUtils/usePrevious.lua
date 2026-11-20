-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactUtilsParent = script:FindFirstAncestor("ReactUtils").Parent
local React = require(ReactUtilsParent.React)

local function usePrevious(current)
    local var1 = React.useRef(nil)
    React.useEffect(function()
        var1.current = current
    end)
    return var1.current
end

return usePrevious
