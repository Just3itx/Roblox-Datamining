-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local GamepadService = game:GetService("GamepadService")
local _RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local FFlagVCWasDisabledFromMenuOpen = require(scriptParentParent.SharedFlags).FFlagVCWasDisabledFromMenuOpen

local Input = require(scriptParent:WaitForChild("Input"))
local Interface = require(scriptParent:WaitForChild("Interface"))
local OnRenderStep = require(scriptParent:WaitForChild("OnRenderStep"))

local var1 = nil
local connection = nil
local connection2 = nil
local bool1 = false
local bool2 = false

local function enableVirtualCursor(position: Vector2)
    if not var1 then
        return
    end
    position = position or var1.CursorPosition

    var1.Enabled = true
    var1.CursorPosition = position

    Interface:EnableUI(position)
    GamepadService:SetGamepadCursorPosition(position)
    Input:EnableInput()
    Input:DisablePreview()

    RunService:BindToRenderStep("VirtualCursorStepped", Enum.RenderPriority.Input.Value + 1, var1.OnRenderStep)

    connection2 = GuiService.MenuOpened:Connect(function()
        if FFlagVCWasDisabledFromMenuOpen then
            bool2 = true
        end
        GamepadService.GamepadCursorEnabled = false
    end)
end

local function disableVirtualCursor()
    if not var1.Enabled then
        return
    end

    connection2:Disconnect()
    connection2 = nil
    var1.PreviouslySelectedObject = nil

    Interface:DisableUI()
    Input:DisableInput()
    Input:EnablePreview()

    RunService:UnbindFromRenderStep("VirtualCursorStepped")

    if var1.SelectedObject then
        if FFlagVCWasDisabledFromMenuOpen and not bool2 then
            GuiService.SelectedCoreObject = nil
        end
        GuiService.SelectedObject = nil
        if not FFlagVCWasDisabledFromMenuOpen then
            GuiService.SelectedCoreObject = nil
        end
        var1.SelectedObject = nil
    end

    if FFlagVCWasDisabledFromMenuOpen then
        bool2 = false
    end
    var1.Enabled = false
end

local tbl1 = {}
tbl1.__index = tbl1

function tbl1:GetEnabled()
    return self.Enabled
end

function tbl1.new()
    local module = {
        Enabled = false,
        CursorPosition = Vector2.new(),
        SelectedObject = nil,
        PreviouslySelectedObject = nil
    }

    function module.OnRenderStep(arg1)
        OnRenderStep(module, arg1)
    end

    connection = UserInputService.LastInputTypeChanged:Connect(function(lastInputType: Enum.UserInputType)
        if lastInputType ~= Enum.UserInputType.Gamepad1
            and lastInputType ~= Enum.UserInputType.Focus
            and GamepadService.GamepadCursorEnabled
        then
            GamepadService.GamepadCursorEnabled = false
            bool1 = true
        elseif lastInputType == Enum.UserInputType.Gamepad1 and bool1 then
            GamepadService.GamepadCursorEnabled = true
            bool1 = false
        end
    end)

    Input:EnablePreview()

    setmetatable(module, tbl1)

    var1 = module

    return module
end

GamepadService:GetPropertyChangedSignal("GamepadCursorEnabled"):Connect(function()
    local gamepadCursorEnabled = GamepadService.GamepadCursorEnabled
    if not var1 then
        return
    end

    if gamepadCursorEnabled then
        local vector2 = UserInputService:GetMouseLocation()
        enableVirtualCursor(vector2)
        return
    end
    disableVirtualCursor()
end)

return tbl1.new()
