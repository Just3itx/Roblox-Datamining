-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanel = script:FindFirstAncestor("FlyoutSidePanel")
local FlyoutSidePanelParent = FlyoutSidePanel.Parent

local React = require(FlyoutSidePanelParent.React)
local useDrawerVisible = require(FlyoutSidePanelParent.Drawer).Hooks.useDrawerVisible
local logFlyoutTradesEntryExposure = require(FlyoutSidePanel.Utils.logFlyoutTradesEntryExposure)

local function useFlyoutTradesEntryExposureLogging()
    local var1 = useDrawerVisible()
    React.useEffect(function()
        if var1 then
            logFlyoutTradesEntryExposure()
        end
    end, { var1 })
end

return useFlyoutTradesEntryExposureLogging
