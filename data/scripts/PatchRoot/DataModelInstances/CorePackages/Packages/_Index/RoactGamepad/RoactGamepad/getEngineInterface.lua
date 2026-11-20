-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local tbl1 = {
    getGamepadConnected = function(userInputType: Enum.UserInputType): boolean
        return UserInputService:GetGamepadConnected(userInputType)
    end,
    getGamepadState = function(userInputType: Enum.UserInputType): {InputObject}
        return UserInputService:GetGamepadState(userInputType)
    end,
    getNavigationGamepads = function(): {InputObject}
        return UserInputService:GetNavigationGamepads()
    end,
    getSelection = function(): GuiObject
        return GuiService.SelectedCoreObject
    end,
    setSelection = function(selectedCoreObject)
        GuiService.SelectedCoreObject = selectedCoreObject
    end,
    subscribeToSelectionChanged = function(arg1): RBXScriptConnection
        return GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(arg1)
    end,
    subscribeToRenderStepped = function(arg1): RBXScriptConnection
        return RunService.RenderStepped:Connect(arg1)
    end,
    subscribeToGamepadConnected = function(arg1): RBXScriptConnection
        return UserInputService.GamepadConnected:Connect(arg1)
    end,
    subscribeToGamepadDisconnected = function(arg1): RBXScriptConnection
        return UserInputService.GamepadDisconnected:Connect(arg1)
    end,
    subscribeToInputBegan = function(arg1): RBXScriptConnection
        return UserInputService.InputBegan:Connect(arg1)
    end,
    subscribeToInputEnded = function(arg1): RBXScriptConnection
        return UserInputService.InputEnded:Connect(arg1)
    end
}

local tbl2 = {
    getSelection = function(): GuiObject
        return GuiService.SelectedObject
    end,
    setSelection = function(selectedObject)
        GuiService.SelectedObject = selectedObject
    end,
    subscribeToSelectionChanged = function(arg1): RBXScriptConnection
        return GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(arg1)
    end,
    getGamepadConnected = tbl1.getGamepadConnected,
    getGamepadState = tbl1.getGamepadState,
    getNavigationGamepads = tbl1.getNavigationGamepads,
    subscribeToRenderStepped = tbl1.subscribeToRenderStepped,
    subscribeToGamepadConnected = tbl1.subscribeToGamepadConnected,
    subscribeToGamepadDisconnected = tbl1.subscribeToGamepadDisconnected,
    subscribeToInputBegan = tbl1.subscribeToInputBegan,
    subscribeToInputEnded = tbl1.subscribeToInputEnded
}
return function(arg1)
    if arg1:IsDescendantOf(CoreGui) then
        return tbl1
    end
    if arg1:FindFirstAncestorWhichIsA("PlayerGui") == nil then
        error("Gamepad navigation not supported. Must be a child of CoreGui or a PlayerGui")
    end

    return tbl2
end
