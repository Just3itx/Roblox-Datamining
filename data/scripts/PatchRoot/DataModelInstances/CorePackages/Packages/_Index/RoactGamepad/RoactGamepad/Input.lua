-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local debugPrint = require(script.Parent.debugPrint)
local InputBindingKind = require(script.Parent.InputBindingKind)
local Config = require(script.Parent.Config)

local tbl1 = {
    [Enum.UserInputType.Keyboard] = true,
    [Enum.UserInputType.Gamepad1] = true,
    [Enum.UserInputType.Gamepad2] = true,
    [Enum.UserInputType.Gamepad3] = true,
    [Enum.UserInputType.Gamepad4] = true,
    [Enum.UserInputType.Gamepad5] = true,
    [Enum.UserInputType.Gamepad6] = true,
    [Enum.UserInputType.Gamepad7] = true,
    [Enum.UserInputType.Gamepad8] = true
}

local tbl2 = ({})

local function initializeEngineGamepadState() -- Luacid: Inlined by compiler; 5 call sites recovered
    return {
        gamepadConnectedConnection = nil,
        gamepadDisconnectedConnection = nil,
        onStepConnections = 0,
        primaryGamepadState = {}
    }
end

local function getEngineState(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    if tbl2[arg1] == nil then
        tbl2[arg1] = initializeEngineGamepadState()
    end

    return tbl2[arg1]
end

local function updatePrimaryGamepad(arg1)
    local engineState = getEngineState(arg1)

    local gamepad1 = Enum.UserInputType.Gamepad1
    for _, value in ipairs(arg1.getNavigationGamepads()) do
        if arg1.getGamepadConnected(value) then
            gamepad1 = value
            break
        end
    end

    local gamepadState = arg1.getGamepadState(gamepad1)

    engineState.primaryGamepadState = {}
    for _, value in ipairs(gamepadState) do
        engineState.primaryGamepadState[value.KeyCode] = value
    end
end

local function getInputEvent(callback, arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return function(arg2)
        if arg1(arg2) then
            debugPrint("[EVENT] Process input: ", arg2.KeyCode, "-", arg2.UserInputState)
            callback(arg2)
        end
    end
end

local function wrapWithGamepadStateListener(arg1, arg2)
    local engineState = getEngineState(arg1)

    if engineState.onStepConnections == 0 then
        updatePrimaryGamepad(arg1)
        engineState.gamepadConnectedConnection = arg1.subscribeToGamepadConnected(function()
            updatePrimaryGamepad(arg1)
        end)
        engineState.gamepadDisconnectedConnection = arg1.subscribeToGamepadDisconnected(function()
            updatePrimaryGamepad(arg1)
        end)
    end
    engineState.onStepConnections += 1

    return function()
        arg2:Disconnect()

        engineState.onStepConnections -= 1
        if engineState.onStepConnections == 0 then
            engineState.gamepadConnectedConnection:Disconnect()
            engineState.gamepadConnectedConnection = nil
            engineState.gamepadDisconnectedConnection:Disconnect()
            engineState.gamepadDisconnectedConnection = nil
        end
    end
end

local function makeInputBinding(kind) -- Luacid: Inlined by compiler; 3 call sites recovered
    return function(enumItem, action, meta)
        assert(
            typeof(enumItem) == "EnumItem" and enumItem.EnumType == Enum.KeyCode,
            "Invalid argument #1: expected a member of Enum.KeyCode"
        )

        assert(typeof(action) == "function", "Invalid argument #2: expected a function")

        return { kind = kind, keyCode = enumItem, action = action, meta = meta }
    end
end

return {
    getUniqueKey = function(arg1): string
        if not arg1.keyCode then
            return tostring(arg1.kind)
        end

        return tostring(arg1.kind) .. "-" .. tostring(arg1.keyCode)
    end,
    connectToEvent = function(arg1, arg2)
        local function matchesBindingKeyCode(arg3) -- Luacid: unused: defined but never referenced
            if Config.DebugKeyboardBindings then
                local debugKeyboardBinding = Config.DebugKeyboardBindings[arg1.keyCode] or {}
                if table.find(debugKeyboardBinding, arg3.KeyCode) then
                    return true
                end
            end

            return arg3.KeyCode == arg1.keyCode
        end

        if arg1.kind == InputBindingKind.Begin then
            local function matchInput(arg3)
                local bool1 = tbl1[arg3.UserInputType]

                if bool1 then
                    if arg3.UserInputState == Enum.UserInputState.Begin then
                        if Config.DebugKeyboardBindings then
                            local debugKeyboardBinding = Config.DebugKeyboardBindings[arg1.keyCode] or {}
                            if table.find(debugKeyboardBinding, arg3.KeyCode) then
                                return true
                            end
                        end

                        bool1 = arg3.KeyCode == arg1.keyCode
                    else
                        bool1 = false
                    end
                end

                return bool1
            end

            local var1 = arg2.subscribeToInputBegan((getInputEvent(arg1.action, matchInput)))

            return function()
                var1:Disconnect()
            end
        end

        if arg1.kind == InputBindingKind.End then
            local function matchInput(arg3)
                local bool1 = tbl1[arg3.UserInputType]

                if bool1 then
                    if arg3.UserInputState == Enum.UserInputState.End then
                        if Config.DebugKeyboardBindings then
                            local debugKeyboardBinding = Config.DebugKeyboardBindings[arg1.keyCode] or {}
                            if table.find(debugKeyboardBinding, arg3.KeyCode) then
                                return true
                            end
                        end

                        bool1 = arg3.KeyCode == arg1.keyCode
                    else
                        bool1 = false
                    end
                end

                return bool1
            end

            local var1 = arg2.subscribeToInputEnded((getInputEvent(arg1.action, matchInput)))

            return function()
                var1:Disconnect()
            end
        end

        if arg1.kind == InputBindingKind.Step then
            local engineState = getEngineState(arg2)

            local var1 = arg2.subscribeToRenderStepped(function(arg3)
                arg1.action(engineState.primaryGamepadState[arg1.keyCode], arg3)
            end)

            return (wrapWithGamepadStateListener(arg2, var1))
        end

        if arg1.kind ~= InputBindingKind.MoveStep then
            return nil
        end

        local engineState = getEngineState(arg2)

        local var1 = arg2.subscribeToRenderStepped(function(arg3)
            local tbl3 = {
                [Enum.KeyCode.Thumbstick1] = engineState.primaryGamepadState[Enum.KeyCode.Thumbstick1],
                [Enum.KeyCode.DPadUp] = engineState.primaryGamepadState[Enum.KeyCode.DPadUp],
                [Enum.KeyCode.DPadDown] = engineState.primaryGamepadState[Enum.KeyCode.DPadDown],
                [Enum.KeyCode.DPadLeft] = engineState.primaryGamepadState[Enum.KeyCode.DPadLeft],
                [Enum.KeyCode.DPadRight] = engineState.primaryGamepadState[Enum.KeyCode.DPadRight]
            }

            arg1.action(tbl3, arg3)
        end)

        return (wrapWithGamepadStateListener(arg2, var1))
    end,
    PublicInterface = {
        onBegin = makeInputBinding(InputBindingKind.Begin),
        onEnd = makeInputBinding(InputBindingKind.End),
        onStep = makeInputBinding(InputBindingKind.Step),
        onMoveStep = function(action) -- name: onMoveStepInputBinding
            return {
                kind = InputBindingKind.MoveStep,
                action = action
            }
        end
    }
}
