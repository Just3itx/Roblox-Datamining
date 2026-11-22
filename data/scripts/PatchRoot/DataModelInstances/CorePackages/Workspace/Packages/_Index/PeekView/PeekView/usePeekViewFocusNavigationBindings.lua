-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeekViewParent = script:FindFirstAncestor("PeekView").Parent
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local React = require(PeekViewParent.React)

local function usePeekViewFocusNavigationBindings(callback)
    React.useEffect(function()
        local currentInput = nil
        local connection = RunService.Heartbeat:Connect(function(deltaTime: number)
            if currentInput and currentInput.KeyCode == Enum.KeyCode.Thumbstick2 then
                callback(currentInput, deltaTime)
            end
        end)
        local connection2 = UserInputService.InputChanged:Connect(function(input: InputObject, _: boolean)
            if input.KeyCode ~= Enum.KeyCode.Thumbstick2 then
                return
            end

            if input.UserInputState == Enum.UserInputState.Change then
                currentInput = input
                return
            end

            if input.UserInputState == Enum.UserInputState.End then
                currentInput = nil
            end
        end)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, { callback })
end

return usePeekViewFocusNavigationBindings
