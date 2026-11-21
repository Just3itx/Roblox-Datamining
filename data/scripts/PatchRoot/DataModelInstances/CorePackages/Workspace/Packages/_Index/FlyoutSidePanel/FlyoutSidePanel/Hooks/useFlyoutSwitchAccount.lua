-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanel = script:FindFirstAncestor("FlyoutSidePanel")
local FlyoutSidePanelParent = FlyoutSidePanel.Parent

local React = require(FlyoutSidePanelParent.React)
local FlyoutAccountSwitcherIXP = require(FlyoutSidePanelParent.SharedExperimentDefinition).FlyoutAccountSwitcherIXP
local FlyoutAnalytics = require(FlyoutSidePanel.Analytics.FlyoutAnalytics)

local function useFlyoutSwitchAccount<T>(callback: ((...any) -> (...any))?, callback2: (...any) -> (...any))
    local dismissRef = React.useRef(nil)

    local var2 = React.useCallback(function()
        local current = dismissRef.current
        if current then
            current()
        end
        callback2()
        FlyoutAnalytics.onFlyoutSwitchAccountClicked({ source = FlyoutAccountSwitcherIXP.getClickSource() })

        if callback then
            callback()
        end
    end, { callback2, callback })

    local anchorRef = React.useRef(nil)

    local tbl1 = { onActivated = 0, anchorRef = 0, dismissRef = 0 }
    if not callback then
        var2 = nil
    end

    tbl1.onActivated = var2
    tbl1.anchorRef = anchorRef
    tbl1.dismissRef = dismissRef
    return tbl1
end

return useFlyoutSwitchAccount
