-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local t = require(ChatUIPrimitivesParent.t)

return {
    isValid = t.interface(
        {
            fallbackText = t.string,
            presetId = t.string,
            presetVersion = t.optional(t.string),
            displayText = t.string
        }
    ),
    isValidDraft = t.strictInterface({ presetId = t.string, displayText = t.string })
}
