-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local t = require(ChatUIPrimitivesParent.t)

local displayText = t.interface({ text = t.string, locale = t.optional(t.string) })

return {
    isValid = t.interface({
        fallbackText = t.string,
        displayText = displayText,
        translatedText = t.optional(displayText),
        originalText = t.optional(displayText),
        wasRewritten = t.boolean
    }),
    isValidDraft = t.strictInterface({ text = t.string })
}
