-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
local InExperienceSideSheetParent = script:FindFirstAncestor("InExperienceSideSheet").Parent
local SharedFlags = require(InExperienceSideSheetParent.SharedFlags)

return {
    FFlagClosePeoplePageWhenNoRoomBesideSideSheet = require(script.FFlagClosePeoplePageWhenNoRoomBesideSideSheet),
    FFlagMountUnmountSideSheet = require(script.FFlagMountUnmountSideSheet),
    FFlagSideSheetEmphasizeLeave = require(script.FFlagSideSheetEmphasizeLeave),
    FFlagSideSheetOpenPeoplePage = SharedFlags.FFlagSideSheetOpenPeoplePage,
    FFlagSideSheetOpenPeoplePageRestoreChat = game:DefineFastFlag("SideSheetOpenPeoplePageRestoreChat2", false),
    FFlagPioneerLogoutButtonLabel = game:DefineFastFlag("PioneerLogoutButtonLabel", false)
}
