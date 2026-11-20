-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
local MarkdownCoreParent = script:FindFirstAncestor("MarkdownCore").Parent

local SafeFlags = require(MarkdownCoreParent.SafeFlags)

return {
    FFlagMarkdownAssistantParity = SafeFlags.createGetFFlag("MarkdownAssistantParity")(),
    FFlagMarkdownTables = SafeFlags.createGetFFlag("MarkdownTables")(),
    FFlagMarkdownTagFallbacks = SafeFlags.createGetFFlag("MarkdownTagFallbacks")()
}
