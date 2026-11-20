-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local InputType = require(scriptParentParent.Enums.InputType)
local useInputType = require(scriptParent.useInputType)

local function useIsGamepad(): boolean
    return useInputType() == InputType.Gamepad
end

return useIsGamepad
