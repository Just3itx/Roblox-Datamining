-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:30:42Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParentParentParentParent = script.Parent.Parent.Parent.Parent.Parent

local t = require(scriptParentParentParentParentParent.t)

return t.strictInterface(
    {
        Color = t.ColorSequence,
        Transparency = t.NumberSequence,
        Rotation = t.number,
        Offset = t.optional(t.Vector2)
    }
)
