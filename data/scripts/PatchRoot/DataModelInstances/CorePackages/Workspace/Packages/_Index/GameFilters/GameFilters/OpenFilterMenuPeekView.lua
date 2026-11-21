-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameFiltersParent = script:FindFirstAncestor("GameFilters").Parent
local AppPage = require(GameFiltersParent.RobloxAppEnums).AppPage
local NavigateDown = require(GameFiltersParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(GameFiltersParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(GameFiltersParent.RobloxAppNavigation).NavigationCommands else nil

local function OpenFilterMenuPeekView(filter, onFilterApplied, onFilterMenuClosed, sendFilterClick)
    return function(arg1)
        local tbl1 = {
            name = AppPage.GameFilterMenuPeekView,
            extraProps = {
                filter = filter,
                onFilterApplied = onFilterApplied,
                onFilterMenuClosed = onFilterMenuClosed,
                sendFilterClick = sendFilterClick
            }
        }

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
            return
        end
        arg1:dispatch(NavigateDown(tbl1))
    end
end

return OpenFilterMenuPeekView
