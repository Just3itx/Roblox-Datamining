-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local InputType = require(scriptParentParent.Enums.InputType)
local React = require(scriptParentParentParent.React)

local useEventConnection = require(scriptParentParentParent.ReactUtils).useEventConnection

local tbl1 = {
    [Enum.UserInputType.Gamepad1] = InputType.Gamepad,
    [Enum.UserInputType.Gamepad2] = InputType.Gamepad,
    [Enum.UserInputType.Gamepad3] = InputType.Gamepad,
    [Enum.UserInputType.Gamepad4] = InputType.Gamepad,
    [Enum.UserInputType.Gamepad5] = InputType.Gamepad,
    [Enum.UserInputType.Gamepad6] = InputType.Gamepad,
    [Enum.UserInputType.Gamepad7] = InputType.Gamepad,
    [Enum.UserInputType.Gamepad8] = InputType.Gamepad,
    [Enum.UserInputType.MouseButton1] = InputType.MouseAndKeyboard,
    [Enum.UserInputType.MouseButton2] = InputType.MouseAndKeyboard,
    [Enum.UserInputType.MouseButton3] = InputType.MouseAndKeyboard,
    [Enum.UserInputType.MouseWheel] = InputType.MouseAndKeyboard,
    [Enum.UserInputType.MouseMovement] = InputType.MouseAndKeyboard,
    [Enum.UserInputType.Keyboard] = InputType.MouseAndKeyboard,
    [Enum.UserInputType.TextInput] = InputType.MouseAndKeyboard,
    [Enum.UserInputType.Touch] = InputType.Touch
}

local function useInputType(arg1)
    local var1 = arg1 or UserInputService

    local function getLastInputType() -- Luacid: Inlined by compiler; 2 call sites recovered
        local lastInputType = var1:GetLastInputType()
        return tbl1[lastInputType]
    end

    local var2, var3 = React.useState((getLastInputType()))

    local var4 = React.useCallback(function(arg2)
        local var4 = tbl1[arg2]
        if var4 ~= nil then
            var3(var4)
        end
    end)

    useEventConnection(var1.LastInputTypeChanged, var4)

    React.useEffect(function()
        var3((getLastInputType()))
    end, {})

    return var2
end

return useInputType
