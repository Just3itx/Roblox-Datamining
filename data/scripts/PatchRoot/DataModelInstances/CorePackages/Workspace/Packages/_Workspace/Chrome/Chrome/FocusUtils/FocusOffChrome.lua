-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamepadService = game:GetService("GamepadService")

local scriptParentParent = script.Parent.Parent

local FocusOffChromeSignal = require(scriptParentParent.FocusUtils.FocusOffChromeSignal)

local function focusOffChrome(callback: ((...any) -> (...any))?)
    if GamepadService.GamepadCursorEnabled then
        return
    end
    FocusOffChromeSignal:fire()
    if callback then
        callback()
    end
end

return focusOffChrome
