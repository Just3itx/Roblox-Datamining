-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local React = require(ExpChatParent.React)

local function calculateScaled(num1: number, num2: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return num1 + num2 * (1 - num1)
end

local function mergeBindableScalar<T>(arg1: T, arg2: T)
    return React.joinBindings(typeof(arg1) == "number" and { arg2 } or { arg2, arg1 }):map(function(arg3)
        local var1 = arg3[1]
        local var2 = arg3[2] or arg1

        if var2 == nil then
            return 1
        end

        return calculateScaled(var2, var1)
    end)
end

return mergeBindableScalar
