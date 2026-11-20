-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactUtilsParent = script:FindFirstAncestor("ReactUtils").Parent
local React = require(ReactUtilsParent.React)

local useDebounce = require(script.Parent.useDebounce)

local function useDebouncedState(arg1, num1: number?)
    local var1, var2 = React.useState(arg1)

    return useDebounce(var1, num1), var2
end

return useDebouncedState
