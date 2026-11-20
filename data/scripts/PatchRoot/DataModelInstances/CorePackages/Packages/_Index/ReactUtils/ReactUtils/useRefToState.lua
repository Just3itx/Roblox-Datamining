-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactUtilsParent = script:FindFirstAncestor("ReactUtils").Parent
local React = require(ReactUtilsParent.React)

local function useRefToState(current)
    local var1 = React.useRef(current)
    var1.current = current
    return var1
end

return useRefToState
