-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local _React = require(scriptParentParentParentParent.React)
local useCursor = require(scriptParentParentParentParent.Foundation).Hooks.useCursor

local function useCursor2(uDim: UDim?, offset: number?, borderWidth: number?)
    return useCursor({ radius = uDim, offset = offset, borderWidth = borderWidth })
end

return useCursor2
