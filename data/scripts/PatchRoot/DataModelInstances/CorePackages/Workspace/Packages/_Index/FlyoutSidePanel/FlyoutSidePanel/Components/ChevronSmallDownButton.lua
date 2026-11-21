-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent
local React = require(FlyoutSidePanelParent.React)
local Foundation = require(FlyoutSidePanelParent.Foundation)
local IconSize = Foundation.Enums.IconSize
local BuilderIcons = require(FlyoutSidePanelParent.BuilderIcons)

local FFlagEnableFlyoutUncheckedBadge = require(FlyoutSidePanelParent.SharedFlags).FFlagEnableFlyoutUncheckedBadge

local function ChevronSmallDownButton(tbl1)
    return React.createElement(Foundation.View, {
        tag = "position-center-right anchor-center-right auto-xy radius-circle bg-action-standard padding-xsmall",
        onActivated = tbl1.onActivated,
        testId = "--core-ui-flyout-switch-account-chevron",
        LayoutOrder = if FFlagEnableFlyoutUncheckedBadge then tbl1.layoutOrder else nil
    }, {
        Icon = React.createElement(Foundation.Icon, {
            tag = "position-center-center anchor-center-center auto-xy content-emphasis",
            name = BuilderIcons.Icon.ChevronSmallDown,
            size = IconSize.Medium
        })
    })
end

return ChevronSmallDownButton
