-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Cryo = require(scriptParentParentParent.Cryo)

local createSignal = require(script.Parent.Parent.createSignal)

local module = {}
module.__index = module

local tbl1 = {
    [Enum.UserInputType.Gamepad1] = true,
    [Enum.UserInputType.Gamepad2] = true,
    [Enum.UserInputType.Gamepad3] = true,
    [Enum.UserInputType.Gamepad4] = true,
    [Enum.UserInputType.Gamepad5] = true,
    [Enum.UserInputType.Gamepad6] = true,
    [Enum.UserInputType.Gamepad7] = true,
    [Enum.UserInputType.Gamepad8] = true,
    [Enum.UserInputType.Keyboard] = true
}

local tbl2 = {
    Enum.KeyCode.Thumbstick2,
    Enum.KeyCode.DPadDown,
    Enum.KeyCode.DPadUp,
    Enum.KeyCode.ButtonL3,
    Enum.KeyCode.ButtonL2,
    Enum.KeyCode.DPadRight,
    Enum.KeyCode.ButtonR1,
    Enum.KeyCode.ButtonSelect,
    Enum.KeyCode.ButtonStart,
    Enum.KeyCode.ButtonY,
    Enum.KeyCode.DPadLeft,
    Enum.KeyCode.ButtonR2,
    Enum.KeyCode.ButtonR3,
    Enum.KeyCode.ButtonX,
    Enum.KeyCode.Thumbstick1,
    Enum.KeyCode.ButtonB,
    Enum.KeyCode.ButtonA,
    Enum.KeyCode.ButtonL1
}

local tbl3 = {
    [Enum.KeyCode.DPadUp] = "NextSelectionUp",
    [Enum.KeyCode.Up] = "NextSelectionUp",
    [Enum.KeyCode.DPadDown] = "NextSelectionDown",
    [Enum.KeyCode.Down] = "NextSelectionDown",
    [Enum.KeyCode.DPadLeft] = "NextSelectionLeft",
    [Enum.KeyCode.Left] = "NextSelectionLeft",
    [Enum.KeyCode.DPadRight] = "NextSelectionRight",
    [Enum.KeyCode.Right] = "NextSelectionRight"
}

local function defaultInputObject(keyCode) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        KeyCode = keyCode,
        Delta = Vector3.new(),
        Position = Vector3.new(),
        UserInputType = Enum.UserInputType.Gamepad1,
        UserInputState = Enum.UserInputState.End
    }
end

local function wrapDisconnector(disconnect) -- Luacid: Inlined by compiler; 7 call sites recovered
    return { Disconnect = disconnect }
end

function module.new()
    local var1 = setmetatable({
        __mockSelected = nil,
        __connectedGamepads = {},
        __gamepadStates = {},
        __selectionChangedSignal = createSignal(),
        __inputSignal = createSignal(),
        __renderStepped = createSignal(),
        __gamepadConnected = createSignal(),
        __gamepadDisconnected = createSignal(),
        __interface = nil
    }, module)

    local tbl4 = {
        getSelection = function()
            return var1.__mockSelected
        end,
        setSelection = function(arg1)
            var1.__mockSelected = arg1

            var1.__selectionChangedSignal:fire()
        end,
        getGamepadConnected = function(arg1)
            return var1.__connectedGamepads[arg1] or false
        end,
        getGamepadState = function(arg1)
            if var1.__gamepadStates[arg1] == nil then
                var1:__initializeGamepadState(arg1)
            end

            return var1.__gamepadStates[arg1]
        end,
        getNavigationGamepads = function(_)
            return Cryo.Dictionary.keys(var1.__connectedGamepads)
        end,
        subscribeToSelectionChanged = function(arg1)
            return wrapDisconnector((var1.__selectionChangedSignal:subscribe(arg1)))
        end,
        subscribeToInputBegan = function(arg1)
            return wrapDisconnector((var1.__inputSignal:subscribe(arg1)))
        end,
        subscribeToInputChanged = function(arg1)
            return wrapDisconnector((var1.__inputSignal:subscribe(arg1)))
        end,
        subscribeToInputEnded = function(arg1)
            return wrapDisconnector((var1.__inputSignal:subscribe(arg1)))
        end,
        subscribeToRenderStepped = function(arg1)
            return wrapDisconnector((var1.__renderStepped:subscribe(arg1)))
        end,
        subscribeToGamepadConnected = function(arg1)
            return wrapDisconnector((var1.__gamepadConnected:subscribe(arg1)))
        end,
        subscribeToGamepadDisconnected = function(arg1)
            return wrapDisconnector((var1.__gamepadDisconnected:subscribe(arg1)))
        end
    }

    var1.__interface = tbl4

    return var1, tbl4
end

function module:__initializeGamepadState(arg1)
    self.__gamepadStates[arg1] = Cryo.List.map(tbl2, function(keyCode)
        return defaultInputObject(keyCode)
    end)
end

function module:simulateSelectionChanged(arg1)
    self.__mockSelected = arg1
    self.__selectionChangedSignal:fire()
end

function module:simulateInput(arg1)
    arg1 = Cryo.Dictionary.join(
        {
            Delta = Vector3.new(),
            Position = Vector3.new(),
            UserInputType = Enum.UserInputType.Gamepad1
        },
        arg1
    )

    assert(
        typeof(arg1.KeyCode) == "EnumItem" and arg1.KeyCode.EnumType == Enum.KeyCode,
        "Invalid inputObject.KeyCode: expected a member of Enum.KeyCode"
    )

    assert(tbl1[arg1.UserInputType], "Invalid inputObject.UserInputType")

    local keyCode = arg1.KeyCode
    local var1 = tbl3[keyCode]

    if var1 ~= nil and self.__interface.getSelection() ~= nil then
        self.__interface.setSelection(self.__interface.getSelection()[var1])
    end

    if arg1.UserInputType ~= Enum.UserInputType.Keyboard then
        local userInputType = arg1.UserInputType

        if not self.__connectedGamepads[userInputType] then
            self:connectGamepad(userInputType)
        end

        local var2 = self.__gamepadStates[userInputType]
        local where = Cryo.List.findWhere(var2, function(arg2): boolean
            return arg2.KeyCode == keyCode
        end)

        if where == nil then
            error(("Invalid InputObject: KeyCode %s is not possible on %s"):format(tostring(keyCode), tostring(userInputType)), 2)
        end

        for k, value in pairs(arg1) do
            var2[where][k] = value
        end
    end

    self.__inputSignal:fire(arg1)
end

function module:renderStep(arg1)
    self.__renderStepped:fire(arg1 == nil and 1 / 30 or arg1)
end

function module:connectGamepad(enumItem)
    assert(
        typeof(enumItem) == "EnumItem" and enumItem.EnumType == Enum.UserInputType,
        "Invalid argument #1: expected a member of Enum.UserInputType"
    )

    self.__connectedGamepads[enumItem] = true
    self:__initializeGamepadState(enumItem)

    self.__gamepadConnected:fire(enumItem)
end

function module:disconnectGamepad(enumItem)
    assert(
        typeof(enumItem) == "EnumItem" and enumItem.EnumType == Enum.UserInputType,
        "Invalid argument #1: expected a member of Enum.UserInputType"
    )

    self.__connectedGamepads[enumItem] = nil
    self.__gamepadDisconnected:fire(enumItem)
end

return module
