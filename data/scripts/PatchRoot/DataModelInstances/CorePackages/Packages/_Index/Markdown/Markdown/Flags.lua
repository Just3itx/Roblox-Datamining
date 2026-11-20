-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
local MarkdownParent = script:FindFirstAncestor("Markdown").Parent

local SafeFlags = require(MarkdownParent.SafeFlags)

return {
    FFlagMarkdownUseRobloxProfileParser = SafeFlags.createGetFFlag("MarkdownUseRobloxProfileParser")(),
    FFlagMarkdownDefaultRobloxProfile = SafeFlags.createGetFFlag("MarkdownDefaultRobloxProfile")(),
    FFlagMarkdownFormattingTags = SafeFlags.createGetFFlag("MarkdownFormattingTags")()
}
