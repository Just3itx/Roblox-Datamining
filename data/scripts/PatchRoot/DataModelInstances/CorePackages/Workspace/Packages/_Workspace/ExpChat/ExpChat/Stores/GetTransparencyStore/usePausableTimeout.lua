-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local React = require(ExpChatParent.React)

local function usePausableTimeout(bool1: boolean, num1: number, func1: (...any) -> (...any))
    local var1 = React.useRef(0)
    React.useEffect(function()
        if num1 <= 0 or not bool1 then
            return nil
        end
        local startTime = os.clock()
        local num2 = math.max(0, num1 - var1.current)
        local var2 = task.delay(num2, func1)
        return function()
            local var3 = var1
            var3.current += os.clock() - startTime
            pcall(task.cancel, var2)
        end
    end, { bool1, num1, func1 })
end

return usePausableTimeout
