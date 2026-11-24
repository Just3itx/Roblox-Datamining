-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamepadService = game:GetService("GamepadService")
local scriptParentParent = script.Parent.Parent
local useProperty = require(scriptParentParent.GuiObjectUtils).useProperty

local function useGamepadCursorEnabled()
    return (useProperty(GamepadService, "GamepadCursorEnabled"))
end

return useGamepadCursorEnabled
