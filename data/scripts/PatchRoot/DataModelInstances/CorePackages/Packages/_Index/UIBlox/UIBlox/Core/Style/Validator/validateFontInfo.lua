-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:30:41Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParentParentParentParent = script.Parent.Parent.Parent.Parent.Parent

local t = require(scriptParentParentParentParentParent.t)

local validateFontFace = require(script.Parent.validateFontFace)

return t.strictInterface({
    RelativeSize = t.numberMinExclusive(0),
    RelativeMinSize = t.numberMinExclusive(0),
    Font = t.union(t.EnumItem, validateFontFace),
    FontFace = t.optional(validateFontFace)
})
