-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactUtilsParent = script:FindFirstAncestor("ReactUtils").Parent
local React = require(ReactUtilsParent.React)

local function useDelayedActionHandler(num1: number, num2: number?, callback: (...any) -> (...any))
    local var1 = React.useRef(nil)
    local var2 = React.useRef(0)

    local function handleAction()
        local now = os.clock()

        if num2 ~= nil and var2.current ~= nil and now - var2.current < num2 then
            return
        end

        var2.current = now
        local current = var1.current

        if current ~= nil then
            task.cancel(current)
        end

        var1.current = task.delay(num1, function()
            callback()
        end)
    end

    React.useEffect(function()
        return function()
            local current = var1.current

            if current ~= nil then
                task.cancel(current)
            end
        end
    end, { var1 })

    return handleAction
end

return useDelayedActionHandler
