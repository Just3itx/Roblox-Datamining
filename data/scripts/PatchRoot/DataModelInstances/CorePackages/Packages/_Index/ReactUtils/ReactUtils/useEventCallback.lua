-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactUtils = script:FindFirstAncestor("ReactUtils")

local React = require(ReactUtils.Parent.React)
local useRefToState = require(ReactUtils.useRefToState)

local function useEventCallback(func1: (...any) -> (...any))
    local var1 = useRefToState(func1)
    return React.useCallback(function(...)
        return var1.current(...)
    end, {})
end

return useEventCallback
