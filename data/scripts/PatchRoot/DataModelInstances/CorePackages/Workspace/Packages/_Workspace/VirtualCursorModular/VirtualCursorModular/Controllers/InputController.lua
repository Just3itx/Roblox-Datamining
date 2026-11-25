-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local ContextActionService = game:GetService("ContextActionService")
local GamepadService = game:GetService("GamepadService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local Util = require(scriptParentParent.Util)
local ProcessThumbstickInput = Util.ProcessThumbstickInput
local GetRectCenter = Util.GetRectCenter
local GetThumbstickInputFromDirectionalInput = Util.GetThumbstickInputFromDirectionalInput

local Enums = require(scriptParentParent.Enums)

local module = {}
module.__index = module

function module.new(_cursorController)
    return (setmetatable({
        _cursorController = _cursorController,
        _moveVector = Vector2.new(),
        _scrollVector = Vector2.new(),
        _enabled = false,
        _behavior = Enums.Behavior.SelectionPreview,
        _previousSelection = nil,
        _selectedObjectChangedConnection = nil,
        _gamepadSelectionRect2DChangedConnection = nil,
        _selectedRectChangedConnection = nil,
        _inputBeganConnection = nil,
        _inputEndedConnection = nil,
        _activeDirections = {}
    }, module))
end

function module:Destroy()
    if self._selectedObjectChangedConnection then
        self._selectedObjectChangedConnection:Disconnect()
    end

    if self._gamepadSelectionRect2DChangedConnection then
        self._gamepadSelectionRect2DChangedConnection:Disconnect()
    end

    if self._selectedRectChangedConnection then
        self._selectedRectChangedConnection:Disconnect()
    end

    if self._inputBeganConnection then
        self._inputBeganConnection:Disconnect()
    end

    if self._inputEndedConnection then
        self._inputEndedConnection:Disconnect()
    end
end

function module:OnMove(_, arg1)
    if self._behavior ~= Enums.Behavior.SelectionPreview then
        return Enum.ContextActionResult.Pass
    end

    if GuiService.SelectedObject == nil then
        return Enum.ContextActionResult.Pass
    end

    if arg1 then
        self._moveVector = ProcessThumbstickInput(Vector2.new(arg1.Position.X, arg1.Position.Y))
    end

    local bool1 = GuiService.SelectedCoreObject == nil or GuiService.SelectedObject ~= nil
    local bool2 = self._moveVector ~= Vector2.zero

    local bool3 = bool1 and bool2

    if bool3 and not self._cursorController:GetEnabled() then
        if self._previousSelection then
            self._cursorController:Enable(GetRectCenter(self._previousSelection.SelectionRect2D))
        elseif GuiService.SelectedObject then
            self._cursorController:Enable(GetRectCenter(GuiService.SelectedObject.SelectionRect2D))
        end
    elseif not bool3 and self._cursorController:GetEnabled() then
        self._cursorController:Disable()
    end

    local _selectedRectChangedConnection = self._selectedRectChangedConnection
    if _selectedRectChangedConnection then
        _selectedRectChangedConnection:Disconnect()
        self._selectedRectChangedConnection = nil
    end

    if bool3 and GuiService.SelectedObject then
        local selectedObject = GuiService.SelectedObject
        self._selectedRectChangedConnection = selectedObject:GetPropertyChangedSignal("SelectionRect2D"):Connect(function()
            if selectedObject and self._behavior == Enums.Behavior.SelectionPreview then
                self._cursorController:TweenPosition(GetRectCenter(selectedObject.SelectionRect2D))
            end
        end)

        self._cursorController:TweenPosition(GetRectCenter(GuiService.SelectedObject.SelectionRect2D))
    end

    return Enum.ContextActionResult.Pass
end

function module:OnScroll(userInputState, arg1)
    if self._behavior == Enums.Behavior.VirtualCursor then
        if userInputState == Enum.UserInputState.Change and arg1 then
            self._scrollVector = Vector2.new(arg1.Position.X, arg1.Position.Y) * Vector2.new(1, -1)
            return Enum.ContextActionResult.Sink
        end

        self._scrollVector = Vector2.zero
    end

    return Enum.ContextActionResult.Pass
end

function module:OnActivate(userInputState, _): Enum.ContextActionResult
    if userInputState == Enum.UserInputState.Begin then
        if GuiService.SelectedObject or GuiService.SelectedCoreObject then
            self._cursorController:PlayTweenActivate()
        end
    elseif userInputState == Enum.UserInputState.End and (GuiService.SelectedObject or GuiService.SelectedCoreObject) then
        self._cursorController:PlayTweenDefault()
    end

    return Enum.ContextActionResult.Pass
end

function module:OnDirectionalButtons(userInputState, arg1)
    if self._behavior ~= Enums.Behavior.VirtualCursor or not arg1 then
        return Enum.ContextActionResult.Pass
    end

    local keyCode = arg1.KeyCode

    if keyCode ~= Enum.KeyCode.ButtonUp
        and keyCode ~= Enum.KeyCode.ButtonDown
        and keyCode ~= Enum.KeyCode.ButtonLeft
        and keyCode ~= Enum.KeyCode.ButtonRight
    then
        return Enum.ContextActionResult.Pass
    end

    local pass = Enum.ContextActionResult.Pass
    if userInputState == Enum.UserInputState.Begin or userInputState == Enum.UserInputState.Change then
        self._activeDirections[arg1.KeyCode] = arg1.Position.Z
        pass = Enum.ContextActionResult.Sink
    else
        self._activeDirections[arg1.KeyCode] = nil
    end

    local zero = Vector2.zero
    for k, _activeDirection in self._activeDirections do
        zero += GetThumbstickInputFromDirectionalInput(k, _activeDirection)
    end

    if zero.Magnitude > 1 then
        zero = zero.Unit
    end

    self._moveVector = ProcessThumbstickInput(zero)

    return pass
end

function module:GetMoveVector()
    return self._moveVector
end

function module:GetScrollVector()
    return self._scrollVector
end

function module:SetBehavior(_behavior)
    local _behavior2 = self._behavior
    self._behavior = _behavior

    if _behavior2 == Enums.Behavior.VirtualCursor then
        self._moveVector = Vector2.new()
        self._scrollVector = Vector2.new()
        table.clear(self._activeDirections)

        ContextActionService:UnbindCoreAction(Enums.Action.DirectionalMove)
        ContextActionService:UnbindCoreAction(Enums.Action.Scroll)

        local _gamepadThumbstick1ChangedConnection = self._gamepadThumbstick1ChangedConnection
        if _gamepadThumbstick1ChangedConnection then
            _gamepadThumbstick1ChangedConnection:Disconnect()
            self._gamepadThumbstick1ChangedConnection = nil
        end

        local _inputBeganConnection = self._inputBeganConnection
        if _inputBeganConnection then
            _inputBeganConnection:Disconnect()
            self._inputBeganConnection = nil
        end

        local _inputEndedConnection = self._inputEndedConnection
        if _inputEndedConnection then
            _inputEndedConnection:Disconnect()
            self._inputEndedConnection = nil
        end

        self:OnScroll(Enum.UserInputState.Cancel, nil)
    elseif _behavior2 == Enums.Behavior.SelectionPreview then
        ContextActionService:UnbindCoreAction(Enums.Action.Move)

        local _selectedObjectChangedConnection = self._selectedObjectChangedConnection
        if _selectedObjectChangedConnection then
            _selectedObjectChangedConnection:Disconnect()
            self._selectedObjectChangedConnection = nil
        end

        local _selectedRectChangedConnection = self._selectedRectChangedConnection
        if _selectedRectChangedConnection then
            _selectedRectChangedConnection:Disconnect()
            self._selectedRectChangedConnection = nil
        end
    end

    if self._behavior ~= Enums.Behavior.VirtualCursor then
        if self._behavior == Enums.Behavior.SelectionPreview then
            self._selectedObjectChangedConnection = GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(function()
                self:OnMove(Enum.UserInputState.Change, nil)
                self._previousSelection = GuiService.SelectedObject
            end)

            ContextActionService:BindCoreActionAtPriority(Enums.Action.Move, function(_: string, arg1, arg2)
                return self:OnMove(arg1, arg2)
            end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Thumbstick1)
        end

        return
    end

    ContextActionService:BindCoreActionAtPriority(Enums.Action.Scroll, function(_: string, arg1, arg2)
        return self:OnScroll(arg1, arg2)
    end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Thumbstick2)

    ContextActionService:BindCoreActionAtPriority(Enums.Action.DirectionalMove, function(_: string, arg1, arg2)
        return self:OnDirectionalButtons(arg1, arg2)
    end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.ButtonUp, Enum.KeyCode.ButtonDown, Enum.KeyCode.ButtonLeft, Enum.KeyCode.ButtonRight)

    self._gamepadThumbstick1ChangedConnection = GamepadService.GamepadThumbstick1Changed:Connect(function(event: Vector2)
        self._moveVector = ProcessThumbstickInput(event)
    end)

    self._inputBeganConnection = UserInputService.InputBegan:Connect(function(input: InputObject, _: boolean)
        if input.KeyCode == Enum.KeyCode.ButtonA or input.KeyCode == Enum.KeyCode.ButtonCenter then
            self:OnActivate(Enum.UserInputState.Begin, input)
        end
    end)

    self._inputEndedConnection = UserInputService.InputEnded:Connect(function(input: InputObject, _: boolean)
        if input.KeyCode == Enum.KeyCode.ButtonA or input.KeyCode == Enum.KeyCode.ButtonCenter then
            self:OnActivate(Enum.UserInputState.End, input)
        end
    end)
end

return module
