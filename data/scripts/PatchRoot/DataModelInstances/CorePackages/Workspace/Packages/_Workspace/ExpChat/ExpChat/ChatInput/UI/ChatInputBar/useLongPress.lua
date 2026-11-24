-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local React = require(ExpChatParent.React)

local function isPointerInput(arg1): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return arg1.UserInputType == Enum.UserInputType.MouseButton1 or arg1.UserInputType == Enum.UserInputType.Touch
end

local function isGamepadActivation(arg1): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return arg1.KeyCode == Enum.KeyCode.ButtonA
end

local function isGestureInput(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return if isPointerInput(arg1) then true else not not (UserInputService.GamepadEnabled and isGamepadActivation(arg1))
end

local function useLongPress(tbl1)
    local onLongPress = tbl1.onLongPress
    local onTap = tbl1.onTap
    local thresholdSeconds = tbl1.thresholdSeconds or 0.5

    local var1 = React.useRef(nil)

    local var2 = React.useRef(false)

    React.useEffect(function()
        return function()
            local current = var1.current
            if current ~= nil then
                pcall(task.cancel, current)
                var1.current = nil
            end
        end
    end, {})

    local var3 = React.useCallback(function()
        if var2.current then
            var2.current = false
            return
        end
        if onTap ~= nil then
            onTap()
        end
    end, { onTap })

    local var4 = React.useCallback(function(_, arg1)
        if onLongPress == nil or not isGestureInput(arg1) then
            return
        end

        local current = var1.current
        if current ~= nil then
            pcall(task.cancel, current)
            var1.current = nil
        end
        var2.current = false
        var1.current = task.delay(thresholdSeconds, function()
            var1.current = nil
            var2.current = true
            if onLongPress ~= nil then
                onLongPress()
            end
        end)
    end, { onLongPress, thresholdSeconds })

    local var5 = React.useCallback(function(_, arg1)
        if onLongPress == nil or not isGestureInput(arg1) then
            return
        end
        local current = var1.current
        if current ~= nil then
            pcall(task.cancel, current)
            var1.current = nil
        end
    end, { onLongPress })

    if onLongPress == nil then
        return nil
    end

    return {
        [React.Event.Activated] = var3,
        [React.Event.InputBegan] = var4,
        [React.Event.InputEnded] = var5
    }
end

return useLongPress
