-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")

local InExperienceSideSheetParent = InExperienceSideSheet.Parent
local GetDrawerVisibleStore = require(InExperienceSideSheetParent.Drawer).Stores.GetDrawerVisibleStore

local Flags = require(InExperienceSideSheet.Flags)
local GetSideSheetConfigStore = require(InExperienceSideSheet.Stores.GetSideSheetConfigStore)
local getHasRoomForPeoplePage = require(InExperienceSideSheet.Utils.getHasRoomForPeoplePage)
local registerInGameMenuPeoplePageActions = require(InExperienceSideSheet.Utils.registerInGameMenuPeoplePageActions)

local FFlagSideSheetOpenPeoplePage = Flags.FFlagSideSheetOpenPeoplePage

return function(bool1: boolean)
    local drawerVisibleStore = GetDrawerVisibleStore(false)
    local hasRoomForPeoplePage = FFlagSideSheetOpenPeoplePage and bool1 and getHasRoomForPeoplePage()

    if FFlagSideSheetOpenPeoplePage and bool1 then
        GetSideSheetConfigStore(false).setDidSideSheetOpenWithPeoplePage(hasRoomForPeoplePage)
    end

    drawerVisibleStore.setDrawerVisible(bool1)

    if not hasRoomForPeoplePage then
        return
    end

    task.delay(0, function()
        if drawerVisibleStore.getDrawerVisible(false) then
            registerInGameMenuPeoplePageActions.openPeoplePage()
        end
    end)
end
