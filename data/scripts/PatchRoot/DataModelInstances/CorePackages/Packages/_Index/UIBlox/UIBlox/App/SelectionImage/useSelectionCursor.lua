-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParent = script.Parent.Parent.Parent

local useCursor = require(scriptParentParentParentParent.Foundation).Hooks.useCursor
local mapCursorType = require(scriptParentParentParent.App.SelectionCursor.mapCursorType)

local function useSelectionCursor(arg1)
    return useCursor(mapCursorType(arg1, true))
end

return useSelectionCursor
