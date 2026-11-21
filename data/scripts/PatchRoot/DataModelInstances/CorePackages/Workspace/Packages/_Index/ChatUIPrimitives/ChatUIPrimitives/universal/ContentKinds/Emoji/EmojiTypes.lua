-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local t = require(ChatUIPrimitivesParent.t)

return {
    isValid = t.interface(
        {
            emojiId = t.string,
            unicode = t.optional(t.string),
            name = t.optional(t.string),
            fallbackText = t.optional(t.string)
        }
    ),
    isValidDraft = t.strictInterface({ emojiId = t.string, unicode = t.string })
}
