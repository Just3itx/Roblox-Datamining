-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local GamepadService = game:GetService("GamepadService")
local _RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local FFlagVirtualCursorForTVRemoteKeycodes = require(scriptParentParent.SharedFlags).FFlagVirtualCursorForTVRemoteKeycodes

local Properties = require(scriptParent.Properties)
local Interface = require(scriptParent.Interface)
local getDirectionalMoveVector = require(scriptParent.getDirectionalMoveVector)

local module = {}

local vector2 = Vector2.new()
local vector2_2 = Vector2.new()
local bool1 = false
local bool2 = false
local SelectedObject = nil
os.clock()
local connection = nil
local connection2 = nil
local connection3 = nil
local bool3 = false
local tbl1 = {}

local function processThumbstickInput(arg1): Vector2
    local x, var1

    if arg1.Magnitude >= Properties.ThumbstickDeadzone then
        local num1 = math.atan2(arg1.y, arg1.x)
        local num2 = math.abs(math.cos(num1) * Properties.ThumbstickDeadzone)
        local num3 = math.abs(math.sin(num1) * Properties.ThumbstickDeadzone)

        x = math.max(math.abs(arg1.x) - num2, 0) / (1 - num2) * math.sign(arg1.x)
        var1 = math.max(math.abs(arg1.y) - num3, 0) / (1 - num3) * math.sign(arg1.y)
    else
        x = 0
        var1 = 0
    end
    return Vector2.new(x, -var1)
end

local function onThumbstick2Input(_, userInputState, arg1)
    if userInputState == Enum.UserInputState.Change then
        vector2_2 = Vector2.new(arg1.Position.x, arg1.Position.y * -1)
        return Enum.ContextActionResult.Sink
    end

    vector2_2 = Vector2.new()
    return Enum.ContextActionResult.Pass
end

local function getRectCenter(rect: Rect) -- Luacid: Inlined by compiler; 5 call sites recovered
    return (rect.Min + rect.Max) / 2
end

local function processPreviewEnabled(bool4: boolean)
    if bool4 and not bool2 then
        if SelectedObject then
            Interface:EnableUI((getRectCenter(SelectedObject.SelectionRect2D)))
        else
            Interface:EnableUI((getRectCenter(GuiService.SelectedObject.SelectionRect2D)))
        end
        bool2 = true
    elseif not bool4 and bool2 then
        Interface:DisableUI()
        bool2 = false
    end

    if connection3 then
        connection3:Disconnect()
    end

    if bool2 and GuiService.SelectedObject then
        local selectedObject = GuiService.SelectedObject
        connection3 = selectedObject:GetPropertyChangedSignal("SelectionRect2D"):Connect(function()
            if selectedObject and bool2 then
                Interface:TweenCursorPosition((getRectCenter(selectedObject.SelectionRect2D)))
            end
        end)
    end

    if bool4 then
        Interface:TweenCursorPosition((getRectCenter(GuiService.SelectedObject.SelectionRect2D)))
    end
end

local function onThumbstick1Input()
    if GuiService.SelectedObject then
        local gamepadState = UserInputService:GetGamepadState(Enum.UserInputType.Gamepad1)

        local zero = Vector2.zero
        for _, inputObject in gamepadState do
            if inputObject.KeyCode == Enum.KeyCode.Thumbstick1 then
                zero = processThumbstickInput(inputObject.Position)
            end
        end

        if bool3 and zero == Vector2.zero then
            bool3 = false
        end

        processPreviewEnabled(not (zero == Vector2.zero) and bool3 and GuiService.SelectedCoreObject == nil)
        return
    end

    if bool2 then
        Interface:DisableUI()
        bool2 = false
    end

    if connection3 then
        connection3:Disconnect()
    end

    if not bool2 or not GuiService.SelectedObject then
        return
    end

    local selectedObject = GuiService.SelectedObject
    connection3 = selectedObject:GetPropertyChangedSignal("SelectionRect2D"):Connect(function()
        if selectedObject and bool2 then
            Interface:TweenCursorPosition((getRectCenter(selectedObject.SelectionRect2D)))
        end
    end)
end

local function onDirectionalButtonsInput(_: string, userInputState, arg1)
    if not (FFlagVirtualCursorForTVRemoteKeycodes and bool1) then
        return Enum.ContextActionResult.Pass
    end

    local pass = Enum.ContextActionResult.Pass
    if userInputState == Enum.UserInputState.Begin or userInputState == Enum.UserInputState.Change then
        tbl1[arg1.KeyCode] = arg1.Position.Z
        pass = Enum.ContextActionResult.Sink
    else
        tbl1[arg1.KeyCode] = nil
    end

    vector2 = getDirectionalMoveVector(tbl1)

    return pass
end

local function onSelectedObjectChanged()
    bool3 = true

    onThumbstick1Input()

    SelectedObject = GuiService.SelectedObject
end

UserInputService.InputBegan:Connect(function(input: InputObject)
    if not bool1 then
        return
    end
    if input.UserInputType == Enum.UserInputType.Gamepad1
        and (input.KeyCode == Enum.KeyCode.ButtonA
            or FFlagVirtualCursorForTVRemoteKeycodes and input.KeyCode == Enum.KeyCode.ButtonCenter)
        and (GuiService.SelectedObject or GuiService.SelectedCoreObject)
    then
        Interface:PlayCursorTweenActivate()
    end
end)

UserInputService.InputEnded:Connect(function(input: InputObject)
    if bool1 then
        if input.UserInputType == Enum.UserInputType.Gamepad1
            and (input.KeyCode == Enum.KeyCode.ButtonA
                or FFlagVirtualCursorForTVRemoteKeycodes and input.KeyCode == Enum.KeyCode.ButtonCenter)
        then
            Interface:PlayCursorTweenDefault()
        end
    elseif input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.Thumbstick1 then
        onThumbstick1Input()
    end
end)

UserInputService.InputChanged:Connect(function(input: InputObject)
    if bool1 then
        return
    end
    if input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.Thumbstick1 then
        onThumbstick1Input()
    end
end)

function module.GetThumbstickVector(_)
    return vector2
end

function module.GetThumbstick2Vector(_)
    return vector2_2
end

function module.EnablePreview(_)
    connection = GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(onSelectedObjectChanged)
end

function module.DisablePreview(_)
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

function module.EnableInput(_)
    connection2 = GamepadService.GamepadThumbstick1Changed:Connect(function(event: Vector2)
        vector2 = processThumbstickInput(event)
    end)

    ContextActionService:BindCoreActionAtPriority("VirtualCursorThumbstick1Movement", function(_, _, _) end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Thumbstick1)

    ContextActionService:BindCoreActionAtPriority(
        "VirtualCursorThumbstick2Movement",
        onThumbstick2Input,
        false,
        Enum.ContextActionPriority.High.Value,
        Enum.KeyCode.Thumbstick2
    )

    if FFlagVirtualCursorForTVRemoteKeycodes then
        ContextActionService:BindCoreActionAtPriority(
            "VirtualCursorDirectionalButtonsMovement",
            onDirectionalButtonsInput,
            false,
            Enum.ContextActionPriority.High.Value,
            Enum.KeyCode.ButtonUp,
            Enum.KeyCode.ButtonDown,
            Enum.KeyCode.ButtonLeft,
            Enum.KeyCode.ButtonRight
        )
    end

    bool1 = true
end

function module.DisableInput(_)
    if connection2 then
        connection2:Disconnect()
        connection2 = nil
    end

    vector2 = Vector2.new()
    vector2_2 = Vector2.new()

    ContextActionService:UnbindCoreAction("VirtualCursorThumbstick1Movement")
    ContextActionService:UnbindCoreAction("VirtualCursorThumbstick2Movement")
    if FFlagVirtualCursorForTVRemoteKeycodes then
        ContextActionService:UnbindCoreAction("VirtualCursorDirectionalButtonsMovement")
        table.clear(tbl1)
    end

    if Enum.UserInputState.Cancel == Enum.UserInputState.Change then
        vector2_2 = Vector2.new((nil).Position.x, (nil).Position.y * -1)
        local _sink = Enum.ContextActionResult.Sink
    else
        vector2_2 = Vector2.new()
        local _pass = Enum.ContextActionResult.Pass
    end
    bool1 = false
end

return module
