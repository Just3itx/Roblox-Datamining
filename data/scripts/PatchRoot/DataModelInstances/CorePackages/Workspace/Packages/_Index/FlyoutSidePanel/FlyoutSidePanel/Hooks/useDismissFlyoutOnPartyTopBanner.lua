-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent
local React = require(FlyoutSidePanelParent.React)
local useSelector = require(FlyoutSidePanelParent.RoactUtils).Hooks.RoactRodux.useSelector
local useSetDrawerVisible = require(FlyoutSidePanelParent.Drawer).Hooks.useSetDrawerVisible
local GetDrawerVisibleStore = require(FlyoutSidePanelParent.Drawer).Stores.GetDrawerVisibleStore
local FFlagUseSignalsForAppTopBanner = require(FlyoutSidePanelParent.SharedFlags).FFlagUseSignalsForAppTopBanner
local useSignalState = if FFlagUseSignalsForAppTopBanner then require(FlyoutSidePanelParent.SignalsReact).useSignalState else nil
local GetAppTopBannerStore = if FFlagUseSignalsForAppTopBanner then require(FlyoutSidePanelParent.AppTopBanner).GetAppTopBannerStore else nil

local function useDismissFlyoutOnPartyTopBanner()
    local var1 = useSetDrawerVisible()

    local current = if FFlagUseSignalsForAppTopBanner then useSignalState(GetAppTopBannerStore(false).getExpanded) else useSelector(function(arg1)
        return if arg1.AppTopBanner then arg1.AppTopBanner.expanded else false
    end)

    local var3 = React.useRef(current)

    React.useEffect(function()
        if GetDrawerVisibleStore(false).getDrawerVisible() and var3.current and not current then
            var1(false)
        end
        var3.current = current
    end, { current, var1 })
end

return useDismissFlyoutOnPartyTopBanner
