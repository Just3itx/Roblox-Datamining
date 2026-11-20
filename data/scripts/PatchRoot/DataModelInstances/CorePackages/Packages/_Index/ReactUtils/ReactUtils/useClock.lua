-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactUtilsParent = script:FindFirstAncestor("ReactUtils").Parent
local React = require(ReactUtilsParent.React)

local function useClock()
    local var1, var2 = React.useBinding(0)

    React.useEffect(function()
        local var3 = task.spawn(function()
            while true do
                local var3 = task.wait()
                var2(var1:getValue() + var3)
            end
        end)

        return function()
            task.cancel(var3)
        end
    end, {})

    return var1
end

return useClock
