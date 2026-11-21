-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local CentralOverlayType = require(AuthCommonParent.RobloxAppEnums).CentralOverlayType
local SetCentralOverlay = require(AuthCommonParent.CentralOverlay).Actions.SetCentralOverlay
local NavigateDown = require(AuthCommonParent.NavigationRodux).Thunks.NavigateDown
local AppPage = require(AuthCommonParent.RobloxAppEnums).AppPage
local FFlagSignalsNavP3Dispatch = require(AuthCommonParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(AuthCommonParent.RobloxAppNavigation).NavigationCommands else nil

return function(extraProps, arg1, arg2)
    return function(arg3)
        if not arg1 then
            arg3:dispatch(SetCentralOverlay(CentralOverlayType.AccountSelector, extraProps))

            return
        end

        if arg2 then
            arg3:dispatch(SetCentralOverlay(CentralOverlayType.AccountSwitcher, extraProps))
            return
        end
        local tbl1 = {
            name = AppPage.AccountSelectorPeekView,
            extraProps = extraProps
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
            return
        end
        arg3:dispatch(NavigateDown(tbl1))
    end
end
