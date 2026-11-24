-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local React = require(GenericAbuseReportingParent.React)

local scrollFrameUtils = require(script.Parent.scrollFrameUtils)

local function useThumbstickScroll(tbl1)
    React.useEffect(function()
        if not tbl1.enabled then
            return
        end

        local currentInput = nil

        local connection = RunService.Heartbeat:Connect(function(deltaTime: number)
            if currentInput == nil or currentInput.KeyCode ~= Enum.KeyCode.Thumbstick2 then
                return
            end

            local current = tbl1.containerRef.current
            if current == nil then
                return
            end

            local selectedCoreObject = GuiService.SelectedCoreObject
            local var1 = scrollFrameUtils.resolveScrollTarget(selectedCoreObject, current)
            if var1 == nil then
                return
            end

            scrollFrameUtils.scrollByAnalogInput(var1, currentInput, deltaTime)
        end)

        local connection2 = UserInputService.InputChanged:Connect(function(input: InputObject, _: boolean)
            if input.KeyCode ~= Enum.KeyCode.Thumbstick2 then
                return
            end

            if input.UserInputState == Enum.UserInputState.Change then
                currentInput = input
            elseif input.UserInputState == Enum.UserInputState.End then
                currentInput = nil
            end
        end)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, { tbl1.enabled, tbl1.containerRef })
end

return useThumbstickScroll
