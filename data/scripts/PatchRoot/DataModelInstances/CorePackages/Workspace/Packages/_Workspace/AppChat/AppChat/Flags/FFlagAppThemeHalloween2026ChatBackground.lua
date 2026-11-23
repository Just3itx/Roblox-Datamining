-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

return game:DefineFastFlag("AppThemeHalloween2026ChatBackground", false)
    and require(AppChatParent.SharedFlags).FFlagAppThemeHalloween2026HomeBackground
