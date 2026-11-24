-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagUseLocalTraversalHistory = game:DefineFastFlag("UseLocalTraversalHistory699v1", false)
local FFlagUseTeleportTraversalHistory = game:DefineFastFlag("UseTeleportTraversalHistory699v1", false)

local bool3 = FFlagUseLocalTraversalHistory or FFlagUseTeleportTraversalHistory

return {
    FFlagAddTraversalBackButton = game:DefineFastFlag("AddTraversalBackButton699v1", false) and bool3,
    FFlagAddTraversalBackButtonAnimation = game:DefineFastFlag("AddTraversalBackButtonAnimation699v1", false) and bool3,
    FFlagAddTraversalHistory = game:DefineFastFlag("AddTraversalHistory699v1", false) and bool3,
    FFlagUseLocalTraversalHistory = FFlagUseLocalTraversalHistory,
    FFlagUseTeleportTraversalHistory = FFlagUseTeleportTraversalHistory,
    FIntMaximumTraversalHistoryItemsFetch = game:DefineFastInt("MaximumTraversalHistoryItemsFetch", 20),
    FFlagTraversalExpPagePaddingFixes = game:DefineFastFlag("TraversalExpPagePaddingFixes709", false)
}
