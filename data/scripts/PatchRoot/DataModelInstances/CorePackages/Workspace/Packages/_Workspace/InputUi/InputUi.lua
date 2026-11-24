-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local getSafeAreaSize = require(script.getSafeAreaSize)

return {
    ["jest.config"] = script["jest.config"],
    Gamepad = {
        useGamepadDisconnectOverlayEffect = require(script.Gamepad.useGamepadDisconnectOverlayEffect),
        GamepadDisconnectedModal = require(script.Gamepad.GamepadDisconnectedModal),
        GamepadDisconnectedModalView = require(script.Gamepad.GamepadDisconnectedModalView),
        GamepadDisconnectTokenMapper = require(script.Gamepad.GamepadDisconnectTokenMapper),
        GamepadUtils = require(script.Gamepad.GamepadUtils)
    },
    getSafeAreaSize = getSafeAreaSize
}
