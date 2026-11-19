-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:11:01Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local withDefaults = require(Foundation.Utility.withDefaults)

local useInputGroup = require(script.Parent.useInputGroup)

local function useInputGroupDefaults(arg1, arg2)
    local var1 = useInputGroup()

    return withDefaults(arg1, withDefaults(var1, arg2))
end

return useInputGroupDefaults
