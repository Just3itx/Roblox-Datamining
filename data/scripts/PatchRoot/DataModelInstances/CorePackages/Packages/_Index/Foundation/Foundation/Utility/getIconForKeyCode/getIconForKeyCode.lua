-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:11:13Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _InputPlatform = require(Foundation.Enums.InputPlatform)
local KeyCodeIconMappings = require(script.Parent.KeyCodeIconMappings)

local function getIconForKeyCode(arg1, arg2)
    return KeyCodeIconMappings.getIconForKeyName(arg1.Name, arg2)
end

return getIconForKeyCode
