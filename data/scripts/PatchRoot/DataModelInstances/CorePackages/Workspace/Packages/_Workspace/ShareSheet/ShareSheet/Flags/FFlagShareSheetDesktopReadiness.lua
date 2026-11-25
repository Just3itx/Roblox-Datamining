-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
local ShareSheetParent = script:FindFirstAncestor("ShareSheet").Parent

return game:DefineFastFlag("ShareSheetDesktopReadiness3", false)
    and require(ShareSheetParent.SharedFlags).FFlagAppCompositionContainerWidth
    and require(script.Parent.FFlagShareSheetOmitsEmptyActions)
    and require(ShareSheetParent.Foundation).Utility.Flags.FoundationBottomSheetClearsActionsHeight
