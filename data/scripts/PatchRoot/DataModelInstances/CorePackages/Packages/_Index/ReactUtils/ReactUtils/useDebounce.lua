-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactUtilsParent = script:FindFirstAncestor("ReactUtils").Parent
local React = require(ReactUtilsParent.React)

local function useDebounce(num1: number?, num2: number?)
    local var1, var2 = React.useState(num1)

    React.useLayoutEffect(function()
        local function updateValue() -- Luacid: Inlined by compiler; 1 call site recovered
            var2(num1)
        end

        if num2 ~= nil and num2 ~= 0 then
            local var3 = task.delay(num2, updateValue)

            return function()
                task.cancel(var3)
            end
        end

        updateValue()
    end, { num1, num2 })

    return var1
end

return useDebounce
