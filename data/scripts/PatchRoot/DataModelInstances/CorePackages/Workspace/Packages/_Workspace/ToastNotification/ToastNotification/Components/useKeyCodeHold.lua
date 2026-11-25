-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:31:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local ToastNotificationParent = script:FindFirstAncestor("ToastNotification").Parent

local React = require(ToastNotificationParent.React)

local function useKeyCodeHold(keyCode: boolean?, num1: number, num2: number, callback: (...any) -> (...any), bool1: boolean?)
    local holding, var2 = React.useState(false)
    local holdProgress, var4 = React.useBinding(0)
    local var5 = React.useRef(nil)

    React.useEffect(function()
        if bool1 then
            return
        end

        local connection = UserInputService.InputBegan:Connect(function(input: InputObject, gameProcessedEvent: boolean)
            if gameProcessedEvent then
                return
            end

            if input.KeyCode == keyCode then
                var2(true)
            end
        end)

        local connection2 = UserInputService.InputEnded:Connect(function(input: InputObject)
            if input.KeyCode == keyCode then
                var2(false)
            end
        end)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
            var2(false)
        end
    end, { bool1, keyCode })

    React.useEffect(function()
        if not holding then
            return
        end

        local function disconnect() -- Luacid: Inlined by compiler; 3 call sites recovered
            if var5.current then
                var5.current:Disconnect()
                var5.current = nil
            end
        end

        local num3 = 0
        var5.current = RunService.Heartbeat:Connect(function(deltaTime: number)
            num3 += deltaTime

            if num3 < num1 then
                return
            end

            if num2 == 0 then
                disconnect()
                callback()
                return
            end

            local num4 = math.clamp((num3 - num1) / num2, 0, 1)
            var4(num4)

            if num4 >= 1 then
                disconnect()
                callback()
            end
        end)

        return function()
            disconnect()
            var4(0)
        end
    end, {
        holding,
        callback,
        num1,
        num2
    })
    return { holding = holding, holdProgress = holdProgress }
end

return useKeyCodeHold
