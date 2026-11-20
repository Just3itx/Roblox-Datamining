-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:41:28Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local t = require(scriptParentParentParentParent.t)

return t.strictInterface({
    targetValue = t.number,
    springParams = t.optional(t.strictInterface({ frequency = t.number, dampingRatio = t.number }))
})
