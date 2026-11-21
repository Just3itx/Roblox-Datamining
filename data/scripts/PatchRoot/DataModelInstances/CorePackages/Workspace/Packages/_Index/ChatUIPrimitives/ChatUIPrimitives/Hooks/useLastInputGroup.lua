-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local InputType = require(ChatUIPrimitivesParent.InputType)
local getInputGroup = InputType.getInputGroup
local InputTypeConstants = InputType.InputTypeConstants

local FFlagLuaSupportMicroGamepadPreferredInput = require(ChatUIPrimitivesParent.SharedFlags).FFlagLuaSupportMicroGamepadPreferredInput

local function getInitialInputGroup(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1.PreferredInput == Enum.PreferredInput.Gamepad
        or FFlagLuaSupportMicroGamepadPreferredInput and arg1.PreferredInput == Enum.PreferredInput.MicroGamepad
    then
        return InputTypeConstants.Gamepad
    end

    if arg1.TouchEnabled then
        return InputTypeConstants.Touch
    end

    return InputTypeConstants.MouseAndKeyboard
end

local function useLastInputGroup(arg1)
    local var1 = arg1 or UserInputService
    local var2, var3 = React.useState(function()
        return getInitialInputGroup(var1)
    end)

    React.useEffect(function()
        local connection = var1.LastInputTypeChanged:Connect(function(lastInputType: Enum.UserInputType)
            var3(getInputGroup(lastInputType))
        end)
        return function()
            connection:Disconnect()
        end
    end, { var1 })

    return var2
end

return useLastInputGroup
