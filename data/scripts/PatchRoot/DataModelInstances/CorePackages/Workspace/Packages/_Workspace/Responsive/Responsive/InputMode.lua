-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local ResponsiveParent = script:FindFirstAncestor("Responsive").Parent

local AppCommonLib = require(ResponsiveParent.AppCommonLib)
local Signal = AppCommonLib.Signal

local SharedFlags = require(ResponsiveParent.SharedFlags)
local FFlagLuaAppResponsiveEnginePreferredInput = SharedFlags.FFlagLuaAppResponsiveEnginePreferredInput
local FFlagLuaSupportMicroGamepadPreferredInput = SharedFlags.FFlagLuaSupportMicroGamepadPreferredInput

local tbl1 = { Pointer = "Pointer", Touch = "Touch", Directional = "Directional" }

local tbl2 = {
    [Enum.UserInputType.MouseButton1] = tbl1.Pointer,
    [Enum.UserInputType.MouseButton2] = tbl1.Pointer,
    [Enum.UserInputType.MouseButton3] = tbl1.Pointer,
    [Enum.UserInputType.MouseWheel] = tbl1.Pointer,
    [Enum.UserInputType.MouseMovement] = tbl1.Pointer,
    [Enum.UserInputType.Keyboard] = tbl1.Pointer,
    [Enum.UserInputType.TextInput] = tbl1.Pointer,
    [Enum.UserInputType.Gamepad1] = tbl1.Directional,
    [Enum.UserInputType.Gamepad2] = tbl1.Directional,
    [Enum.UserInputType.Gamepad3] = tbl1.Directional,
    [Enum.UserInputType.Gamepad4] = tbl1.Directional,
    [Enum.UserInputType.Gamepad5] = tbl1.Directional,
    [Enum.UserInputType.Gamepad6] = tbl1.Directional,
    [Enum.UserInputType.Gamepad7] = tbl1.Directional,
    [Enum.UserInputType.Gamepad8] = tbl1.Directional,
    [Enum.UserInputType.Touch] = tbl1.Touch,
    [Enum.UserInputType.None] = tbl1.Pointer
}

local signal = Signal.new()
local tbl3 = { preferred = nil, last = nil }

local tbl4 = {
    [Enum.Platform.XBoxOne] = true,
    [Enum.Platform.XBox360] = true,
    [Enum.Platform.WiiU] = true,
    [Enum.Platform.PS3] = true,
    [Enum.Platform.PS4] = true,
    [Enum.Platform.PS5] = true,
    [Enum.Platform.Ouya] = true,
    [Enum.Platform.AndroidTV] = true
}

local tbl5 = {
    [Enum.Platform.IOS] = true,
    [Enum.Platform.Android] = true
}
local tbl6

if FFlagLuaAppResponsiveEnginePreferredInput then
    tbl6 = {}
    tbl6[Enum.PreferredInput.Gamepad] = tbl1.Directional
    tbl6[Enum.PreferredInput.Touch] = tbl1.Touch
    tbl6[Enum.PreferredInput.KeyboardAndMouse] = tbl1.Pointer
else
    tbl6 = nil
end

if FFlagLuaAppResponsiveEnginePreferredInput and FFlagLuaSupportMicroGamepadPreferredInput then
    tbl6[Enum.PreferredInput.MicroGamepad] = tbl1.Directional
end

function getPreferredInput()
    if FFlagLuaAppResponsiveEnginePreferredInput then
        local preferredInput = UserInputService.PreferredInput or Enum.PreferredInput.KeyboardAndMouse
        return tbl6[preferredInput] or tbl1.Pointer
    end
    local platform = UserInputService:GetPlatform()
    local var1 = AppCommonLib.isSpatial()
    local var2 = tbl4[platform] or false
    local var3 = tbl5[platform] or false

    if var1 then
        return tbl1.Pointer
    end

    if var2 then
        return tbl1.Directional
    end

    if var3 then
        return tbl1.Touch
    end

    return tbl1.Pointer
end

function updatePreferredInput()
    local preferred = getPreferredInput()
    if preferred == tbl3.preferred then
        return
    end

    tbl3.preferred = preferred
    if tbl3.last == nil then
        tbl3.last = tbl3.preferred
    end
    signal:fire()
end

function updateLastInput()
    local last = tbl2[UserInputService:GetLastInputType()]
    if last and last ~= tbl3.last then
        tbl3.last = last
        signal:fire()
    end
end

function init()
    if FFlagLuaAppResponsiveEnginePreferredInput then
        UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(updatePreferredInput)
    end
    UserInputService.GamepadConnected:Connect(updatePreferredInput)
    UserInputService:GetPropertyChangedSignal("KeyboardEnabled"):Connect(updatePreferredInput)
    UserInputService:GetPropertyChangedSignal("MouseEnabled"):Connect(updatePreferredInput)
    UserInputService:GetPropertyChangedSignal("TouchEnabled"):Connect(updatePreferredInput)
    UserInputService:GetPropertyChangedSignal("GamepadEnabled"):Connect(updatePreferredInput)
    AppCommonLib.connectToIsSpatialChanged(updatePreferredInput)
    UserInputService.LastInputTypeChanged:Connect(updateLastInput)
    updateLastInput()
    updatePreferredInput()
end

init()

return {
    Enum = tbl1,
    preferredInputRules = {
        {
            Key = tbl1.Directional,
            preferredInput = tbl1.Directional
        },
        {
            Key = tbl1.Pointer,
            preferredInput = tbl1.Pointer
        },
        {
            Key = tbl1.Touch,
            preferredInput = tbl1.Touch
        }
    },
    lastInputRules = {
        {
            Key = tbl1.Directional,
            lastInput = tbl1.Directional
        },
        {
            Key = tbl1.Pointer,
            lastInput = tbl1.Pointer
        },
        {
            Key = tbl1.Touch,
            lastInput = tbl1.Touch
        }
    },
    connect = function(arg1)
        return signal:connect(arg1)
    end,
    preferred = function()
        return tbl3.preferred
    end,
    last = function()
        return tbl3.last
    end
}
