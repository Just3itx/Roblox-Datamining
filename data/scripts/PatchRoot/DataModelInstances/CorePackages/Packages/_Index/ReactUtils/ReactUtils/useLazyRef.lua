-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactUtilsParent = script:FindFirstAncestor("ReactUtils").Parent
local React = require(ReactUtilsParent.React)

local function useLazyRef(func1: (...any) -> (...any))
    local var1 = React.useRef(nil)
    if var1.current == nil then
        var1.current = func1()
    end
    assert(var1.current ~= nil, "Ref must be defined after initialization function is called")
    return var1
end

return useLazyRef
