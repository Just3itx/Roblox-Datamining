-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)
local Otter = require(scriptParentParent.Otter)

local function useMotor<T>(arg1, arg2: T, arg3: T)
    local var1 = React.useRef(nil)
    local var2 = React.useRef(nil)

    if not var1.current then
        local current = if typeof(arg1) == "number" then Otter.createSingleMotor(arg1) else Otter.createGroupMotor(arg1)

        function var2.current(arg4)
            current:setGoal(arg4)
        end
        var1.current = current
    end

    React.useEffect(function()
        local var3 = nil
        local var4 = nil
        if var1.current then
            if arg3 then
                var3 = var1.current:onComplete(arg3)
            end
            var4 = var1.current:onStep(arg2)
        end
        return function()
            if var3 then
                var3()
            end
            if var4 then
                var4()
            end
        end
    end, { arg2, arg3 })

    React.useEffect(function()
        return function()
            if var1.current then
                var1.current:destroy()
                var1.current = nil
            end
        end
    end, { var1.current })

    return var2.current
end

return useMotor
