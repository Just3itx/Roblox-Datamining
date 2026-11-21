-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local t = require(ChatUIPrimitivesParent.t)

return {
    isValid = t.strictInterface({ text = t.string, iconName = t.optional(t.string) })
}
