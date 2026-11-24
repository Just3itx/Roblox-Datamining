-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:40:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InputUiParent = script:FindFirstAncestor("InputUi").Parent
local React = require(InputUiParent.React)
local useInputType = require(InputUiParent.RoactUtils).Hooks.useInputType
local InputTypeConstants = require(InputUiParent.InputType).InputTypeConstants
local useIsGamepad = require(InputUiParent.RoactUtils).Hooks.useIsGamepad
local useGamepadConnectedEvent = require(script.Parent.useGamepadConnectedEvent)

local bool1 = game:DefineFastFlag("EnableGamepadHookForCorescriptGlobalEffects", false)

local function useGamepadDisconnectOverlayEffect(callback: (...any) -> (...any), callback2: (...any) -> (...any), arg1, str1: string?)
    local bool2 = if bool1 then useIsGamepad() else useInputType() == InputTypeConstants.Gamepad
    local var1 = React.useRef(false)

    local var2 = React.useCallback(function()
        if not var1.current then
            return
        end

        arg1:sendEventDeferred(str1 or "", "gamepadConnectionEvent", { connectionEvent = "gamepadReconnected" })

        var1.current = false
        callback2()
    end, { callback2 })

    local var3 = React.useCallback(function()
        if not bool2 then
            return
        end

        if var1.current then
            return
        end

        arg1:sendEventDeferred(str1 or "", "gamepadConnectionEvent", { connectionEvent = "gamepadDisconnected" })

        var1.current = true
        callback()
    end, { bool2, callback })

    useGamepadConnectedEvent(var2, var3)
end

return useGamepadDisconnectOverlayEffect
