-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:20:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)

local function forwardRefValue(arg1, current) -- Luacid: Inlined by compiler; 2 call sites recovered
    if type(arg1) == "function" then
        arg1(current)
    elseif type(arg1) == "table" then
        arg1.current = current
    end
end

local function useComposedRef<T>(arg1: T, arg2: T)
    return (React.useCallback(function(current)
        forwardRefValue(arg1, current)
        forwardRefValue(arg2, current)
    end, { arg1, arg2 }))
end

return useComposedRef
