-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
local Moments = script:FindFirstAncestor("Moments")

return game:DefineFastFlag("MomentsCommentTranslationShownByDefault", false)
    and require(Moments.Flags.FFlagMomentsCommentTranslation)
