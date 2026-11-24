-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamepadService = game:GetService("GamepadService")

local scriptParentParent = script.Parent.Parent

local FocusOnChromeSignal = require(scriptParentParent.FocusUtils.FocusOnChromeSignal)

local function focusOnChrome(callback: ((...any) -> (...any))?, str1: string?)
    if GamepadService.GamepadCursorEnabled then
        return
    end
    if callback then
        callback()
    end
    FocusOnChromeSignal:fire(str1)
end

return focusOnChrome
