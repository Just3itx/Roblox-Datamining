-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent

local React = require(FlyoutSidePanelParent.React)

local useSetDrawerVisible = require(FlyoutSidePanelParent.Drawer).Hooks.useSetDrawerVisible
local useRoactService = require(FlyoutSidePanelParent.RobloxAppHooks).useRoactService

local AppEventIngestService = require(FlyoutSidePanelParent.RoactServiceTags).AppEventIngestService
local FlyoutAnalytics = require(script.Parent.Parent.Analytics.FlyoutAnalytics)
local FlyoutTooltipManager = require(script.Parent.Parent.FlyoutTooltipManager)

local function useOpenFlyoutSidePanel(str1: string?)
    local var1 = useSetDrawerVisible()
    local var2 = useRoactService(AppEventIngestService)

    return React.useCallback(function()
        FlyoutAnalytics.sendPageLoadEvent(var2, str1)
        var1(true)
        FlyoutTooltipManager:flyoutSidePanelOpened()
    end, { var1, var2, str1 })
end

return useOpenFlyoutSidePanel
