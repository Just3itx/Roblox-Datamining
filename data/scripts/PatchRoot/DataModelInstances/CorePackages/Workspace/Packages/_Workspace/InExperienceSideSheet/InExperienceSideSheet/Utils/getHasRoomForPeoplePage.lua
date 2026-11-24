-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")
local InExperienceSideSheetParent = InExperienceSideSheet.Parent
local Display = require(InExperienceSideSheetParent.Display)
local _Signals = require(InExperienceSideSheetParent.Signals)

local Constants = require(InExperienceSideSheet.Common.Constants)
local Flags = require(InExperienceSideSheet.Flags)
local getSideSheetDrawerWidth = require(script.Parent.getSideSheetDrawerWidth)
local hasRoomForPeoplePage = require(script.Parent.hasRoomForPeoplePage)

local FFlagClosePeoplePageWhenNoRoomBesideSideSheet = Flags.FFlagClosePeoplePageWhenNoRoomBesideSideSheet

return function(arg1, num1: number?)
    if arg1 == nil then
        arg1 = false
    end
    if not FFlagClosePeoplePageWhenNoRoomBesideSideSheet or num1 == nil then
        local displayStore = Display.GetDisplayStore(arg1)
        local deviceSafePadding = displayStore.getDeviceSafePadding(arg1)
        num1 = displayStore.getViewportSize(arg1).X - deviceSafePadding.left - deviceSafePadding.right
    end

    local sideSheetDrawerWidth = getSideSheetDrawerWidth(arg1)
    if sideSheetDrawerWidth <= 0 then
        sideSheetDrawerWidth = Constants.NominalSideSheetWidth
    end

    return hasRoomForPeoplePage(num1, sideSheetDrawerWidth)
end
