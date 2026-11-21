-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanel = script:FindFirstAncestor("FlyoutSidePanel")
local FlyoutSidePanelParent = FlyoutSidePanel.Parent

local React = require(FlyoutSidePanelParent.React)
local Foundation = require(FlyoutSidePanelParent.Foundation)
local useLocalization = require(FlyoutSidePanelParent.Localization).Hooks.useLocalization
local useAccountSwitcherTooltip = require(FlyoutSidePanel.Hooks.useAccountSwitcherTooltip)

local EducationalTooltip = Foundation.EducationalTooltip
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide

local function SwitchAccountTooltip(tbl1)
    local var1 = useLocalization({
        title = "Feature.FlyoutSidePanel.Title.AccountSwitcherMoved",
        text = "Feature.FlyoutSidePanel.Description.SwitchAccountsHere"
    })

    local isOpen, onClose, onPressedOutside = useAccountSwitcherTooltip(tbl1.anchorRef, tbl1.isEligible, tbl1.appStorage, tbl1.dismissRef)

    return React.createElement(EducationalTooltip, {
        title = var1.title,
        text = var1.text,
        isOpen = isOpen,
        anchorRef = tbl1.anchorRef,
        align = PopoverAlign.Center,
        side = PopoverSide.Bottom,
        onClose = onClose,
        onPressedOutside = onPressedOutside,
        testId = "--core-ui-flyout-account-switcher-tooltip"
    })
end

return SwitchAccountTooltip
