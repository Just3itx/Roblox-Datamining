-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent
local React = require(FlyoutSidePanelParent.React)
local useLocalization = require(FlyoutSidePanelParent.Localization).Hooks.useLocalization
local Foundation = require(FlyoutSidePanelParent.Foundation)
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local ButtonSize = Foundation.Enums.ButtonSize

local FlyoutAccountSwitcherIXP = require(FlyoutSidePanelParent.SharedExperimentDefinition).FlyoutAccountSwitcherIXP

local FFlagCTAChangeMorePageFlyoutButtonText = require(FlyoutSidePanelParent.SharedFlags).FFlagCTAChangeMorePageFlyoutButtonText

local function FlyoutSwitchAccountButton(tbl1)
    local onActivated = React.useCallback(function()
        if not FlyoutAccountSwitcherIXP.isUsernameAccountSwitcherEnabled() then
            tbl1.closeDrawer()
        end
        if tbl1.onSwitchAccountActivated then
            tbl1.onSwitchAccountActivated()
        end
    end, { tbl1.onSwitchAccountActivated, if FlyoutAccountSwitcherIXP.isUsernameAccountSwitcherEnabled() then nil else tbl1.closeDrawer })

    local var2 = useLocalization({
        title = if FFlagCTAChangeMorePageFlyoutButtonText then "Authentication.AccountSwitch.Header.SwitchAccountSentenceCase" else "Authentication.AccountSwitch.Action.SwitchAccount"
    })

    return React.createElement(Button, {
        testId = "--core-ui-flyout-button-switch-account",
        text = var2.title,
        variant = ButtonVariant.Standard,
        LayoutOrder = tbl1.layoutOrder,
        onActivated = onActivated,
        isDisabled = false,
        size = ButtonSize.Large,
        width = UDim.new(1, 0)
    })
end

return FlyoutSwitchAccountButton
