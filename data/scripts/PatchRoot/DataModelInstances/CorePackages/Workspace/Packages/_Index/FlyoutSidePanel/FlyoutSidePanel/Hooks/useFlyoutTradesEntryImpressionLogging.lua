-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanel = script:FindFirstAncestor("FlyoutSidePanel")
local FlyoutSidePanelParent = FlyoutSidePanel.Parent

local React = require(FlyoutSidePanelParent.React)
local useDrawerVisible = require(FlyoutSidePanelParent.Drawer).Hooks.useDrawerVisible
local FlyoutAnalytics = require(FlyoutSidePanel.Analytics.FlyoutAnalytics)
local FlyoutContentSettings = require(FlyoutSidePanel.Config.FlyoutContentSettings)

local function useFlyoutTradesEntryImpressionLogging(tbl1)
    local var1 = useDrawerVisible()
    local var2 = React.useRef(false)

    local bool1 = false
    for _, value in tbl1 do
        if value.itemType == FlyoutContentSettings.ItemType.Trades then
            bool1 = true
            break
        end
    end

    React.useEffect(function()
        if not var1 then
            var2.current = false
            return
        end
        if not bool1 or var2.current then
            return
        end

        var2.current = true
        FlyoutAnalytics.onFlyoutContentItemImpressed(
            {
                integrationId = FlyoutContentSettings.ItemType.Trades,
                source = "impression"
            }
        )
    end, { var1, bool1 })
end

return useFlyoutTradesEntryImpressionLogging
