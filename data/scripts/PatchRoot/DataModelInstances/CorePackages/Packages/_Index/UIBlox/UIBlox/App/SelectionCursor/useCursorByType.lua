-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local useCursor = require(scriptParentParentParentParent.Foundation).Hooks.useCursor
local _React = require(scriptParentParentParentParent.React)
local mapCursorType = require(script.Parent.mapCursorType)

local function useCursorByType(arg1)
    return useCursor(mapCursorType(arg1))
end

return useCursorByType
