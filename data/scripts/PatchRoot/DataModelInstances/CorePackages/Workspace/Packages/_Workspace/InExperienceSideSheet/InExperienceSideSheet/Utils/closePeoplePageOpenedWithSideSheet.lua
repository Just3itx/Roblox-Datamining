-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")

local getDidSideSheetOpenWithPeoplePage = require(InExperienceSideSheet.Utils.getDidSideSheetOpenWithPeoplePage)
local registerInGameMenuPeoplePageActions = require(InExperienceSideSheet.Utils.registerInGameMenuPeoplePageActions)

return function()
    if getDidSideSheetOpenWithPeoplePage() then
        registerInGameMenuPeoplePageActions.closePeoplePage()
    end
end
