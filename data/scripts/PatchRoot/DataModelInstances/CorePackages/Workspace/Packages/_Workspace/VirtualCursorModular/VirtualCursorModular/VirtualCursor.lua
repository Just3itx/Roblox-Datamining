-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:31:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualCursorModular = script:FindFirstAncestor("VirtualCursorModular")
local VirtualCursorModularParent = VirtualCursorModular.Parent

local _CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local GamepadService = game:GetService("GamepadService")

local SharedFlags = require(VirtualCursorModularParent.SharedFlags)
local FFlagEnableVirtualCursorMoveAssist = SharedFlags.FFlagEnableVirtualCursorMoveAssist
local FFlagVCWasDisabledFromMenuOpen = SharedFlags.FFlagVCWasDisabledFromMenuOpen
local FFlagEnableVirtualCursorDebugging = SharedFlags.FFlagEnableVirtualCursorDebugging

local InputController = require(VirtualCursorModular.Controllers.InputController)
local CursorController = require(VirtualCursorModular.Controllers.CursorController)
local SelectionController = require(VirtualCursorModular.Controllers.SelectionController)
local MoveAssistController = require(VirtualCursorModular.Controllers.MoveAssistController)

local Enums = require(VirtualCursorModular.Enums)

local tbl1 = {}
tbl1.__index = tbl1

function tbl1.new()
    local cursorController = CursorController.new()
    local inputController = InputController.new(cursorController)
    local moveAssistController = if FFlagEnableVirtualCursorMoveAssist then MoveAssistController.new() else nil
    local selectionController = SelectionController.new(inputController, cursorController, moveAssistController)
    local _moveAssistDebugView = if FFlagEnableVirtualCursorDebugging and moveAssistController then require(VirtualCursorModular.Controllers.MoveAssistDebugView).new() else nil
    local self = setmetatable({
        _cursorPosition = Vector2.new(),
        _selectedObject = nil,
        _previouslySelectedObject = nil,
        _wasDisabledFromOtherInput = false,
        _lastInputTypeChangedEventConnection = nil,
        _gamepadCursorEnabledConnection = nil,
        _menuOpenedEventConnection = nil,
        _cursorController = cursorController,
        _inputController = inputController,
        _selectionController = selectionController,
        _moveAssistController = moveAssistController,
        _moveAssistDebugView = _moveAssistDebugView,
        _boundToRenderStep = false,
        _wasDisabledFromMenuOpen = false
    }, tbl1)

    self:initialize()

    return self
end

function tbl1:Destroy()
    local _lastInputTypeChangedEventConnection = self._lastInputTypeChangedEventConnection
    if _lastInputTypeChangedEventConnection then
        _lastInputTypeChangedEventConnection:Disconnect()
        self._lastInputTypeChangedEventConnection = nil
    end

    local _gamepadCursorEnabledConnection = self._gamepadCursorEnabledConnection
    if _gamepadCursorEnabledConnection then
        _gamepadCursorEnabledConnection:Disconnect()
        self._gamepadCursorEnabledConnection = nil
    end

    local _menuOpenedEventConnection = self._menuOpenedEventConnection
    if _menuOpenedEventConnection then
        _menuOpenedEventConnection:Disconnect()
        self._menuOpenedEventConnection = nil
    end

    if self._boundToRenderStep then
        RunService:UnbindFromRenderStep("VirtualCursorStepped")
        self._boundToRenderStep = false
    end

    if self._inputController then
        self._inputController:Destroy()
    end

    if self._cursorController then
        self._cursorController:Destroy()
    end

    if self._moveAssistDebugView then
        self._moveAssistDebugView:Destroy()
        self._moveAssistDebugView = nil
    end
end

function tbl1:UpdateGamepadCursor()
    if GamepadService.GamepadCursorEnabled then
        self:EnableVirtualCursor((UserInputService:GetMouseLocation()))
        return
    end
    self:EnableSelectionPreview()
end

function tbl1:initialize()
    self._lastInputTypeChangedEventConnection = UserInputService.LastInputTypeChanged:Connect(function(lastInputType: Enum.UserInputType)
        if lastInputType ~= Enum.UserInputType.Gamepad1
            and lastInputType ~= Enum.UserInputType.Focus
            and GamepadService.GamepadCursorEnabled
        then
            GamepadService.GamepadCursorEnabled = false
            self._wasDisabledFromOtherInput = true
        elseif lastInputType == Enum.UserInputType.Gamepad1 and self._wasDisabledFromOtherInput then
            GamepadService.GamepadCursorEnabled = true
            self._wasDisabledFromOtherInput = false
        end
        if FFlagEnableVirtualCursorDebugging then
            print(
                "LastInputTypeChanged",
                lastInputType,
                "GamepadCursorEnabled",
                GamepadService.GamepadCursorEnabled,
                "_wasDisabledFromOtherInput",
                self._wasDisabledFromOtherInput
            )
        end
    end)

    self._gamepadCursorEnabledConnection = GamepadService:GetPropertyChangedSignal("GamepadCursorEnabled"):Connect(function()
        self:UpdateGamepadCursor()
    end)

    self:UpdateGamepadCursor()
end

function tbl1:onRenderStep(num1: number)
    self._selectionController:onRenderStep(num1)

    local _moveAssistDebugView = self._moveAssistDebugView
    local _moveAssistController = self._moveAssistController
    if _moveAssistDebugView and _moveAssistController then
        _moveAssistDebugView:update(_moveAssistController._debugSnapshot, self._cursorController:GetCursorScreenGuiOffset())
    end
end

function tbl1:EnableVirtualCursor(vector2: Vector2)
    self._cursorController:Enable(vector2)
    GamepadService:SetGamepadCursorPosition(vector2)
    self._inputController:SetBehavior(Enums.Behavior.VirtualCursor)

    if not self._boundToRenderStep then
        RunService:BindToRenderStep("VirtualCursorStepped", Enum.RenderPriority.Input.Value + 1, function(num1: number)
            self:onRenderStep(num1)
        end)
        self._boundToRenderStep = true
    end

    self._menuOpenedEventConnection = GuiService.MenuOpened:Connect(function()
        GamepadService.GamepadCursorEnabled = false
        if FFlagVCWasDisabledFromMenuOpen then
            self._wasDisabledFromMenuOpen = true
        end
    end)
end

function tbl1:EnableSelectionPreview()
    local _menuOpenedEventConnection = self._menuOpenedEventConnection
    if _menuOpenedEventConnection then
        _menuOpenedEventConnection:Disconnect()
        self._menuOpenedEventConnection = nil
    end

    self._cursorController:Disable()
    self._inputController:SetBehavior(Enums.Behavior.SelectionPreview)

    if self._boundToRenderStep then
        RunService:UnbindFromRenderStep("VirtualCursorStepped")
        self._boundToRenderStep = false
    end

    GuiService.SelectedObject = nil
    if not (FFlagVCWasDisabledFromMenuOpen and self._wasDisabledFromMenuOpen) then
        GuiService.SelectedCoreObject = nil
    end
    if FFlagVCWasDisabledFromMenuOpen then
        self._wasDisabledFromMenuOpen = false
    end
end

return tbl1.new()
