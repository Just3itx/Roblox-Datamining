-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTileParent = script:FindFirstAncestor("GameTile").Parent

local RobloxAppEnums = require(GameTileParent.RobloxAppEnums)
local CentralOverlayType = RobloxAppEnums.CentralOverlayType
local AppPage = RobloxAppEnums.AppPage
local SetCentralOverlay = require(GameTileParent.CentralOverlay).Actions.SetCentralOverlay
local NavigateDown = require(GameTileParent.NavigationRodux).Thunks.NavigateDown
local Responsive = require(GameTileParent.Responsive)
local FFlagSignalsNavP3Dispatch = require(GameTileParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(GameTileParent.RobloxAppNavigation).NavigationCommands else nil

return function(touch)
    return function(arg1)
        if touch ~= Responsive.Input.Touch then
            arg1:dispatch(SetCentralOverlay(CentralOverlayType.SponsoredTooltip))

            return
        end

        local tbl1 = {
            name = AppPage.SponsoredTooltipPeekView
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
            return
        end
        arg1:dispatch(NavigateDown(tbl1))
    end
end
