-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")

local getDidSideSheetOpenWithPeoplePage = require(InExperienceSideSheet.Utils.getDidSideSheetOpenWithPeoplePage)
local getHasRoomForPeoplePage = require(InExperienceSideSheet.Utils.getHasRoomForPeoplePage)
local getSideSheetVisibility = require(InExperienceSideSheet.Utils.getSideSheetVisibility)
local registerInGameMenuPeoplePageActions = require(InExperienceSideSheet.Utils.registerInGameMenuPeoplePageActions)

return function(num1: number): boolean
    local sideSheetVisibility = getSideSheetVisibility(false)
    local didSideSheetOpenWithPeoplePage = getDidSideSheetOpenWithPeoplePage(false)
    if not (sideSheetVisibility and didSideSheetOpenWithPeoplePage) then
        return false
    end

    if getHasRoomForPeoplePage(false, num1) then
        return false
    end

    registerInGameMenuPeoplePageActions.closePeoplePage(num1)
    return true
end
