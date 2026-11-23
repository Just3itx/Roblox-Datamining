-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgradeParent = script:FindFirstAncestor("AccountUpgrade").Parent

local React = require(AccountUpgradeParent.React)

local Foundation = require(AccountUpgradeParent.Foundation)
local ButtonGroup = Foundation.ButtonGroup
local _ButtonVariant = Foundation.Enums.ButtonVariant
local EnumsOrientation = Foundation.Enums.Orientation

local function AccountUpgradeDialogActions(tbl1)
    local buttons = {}
    for _, button in tbl1.buttons do
        table.insert(buttons, {
            text = button.text,
            variant = button.variant,
            onActivated = button.onActivated,
            isDisabled = button.isDisabled,
            isLoading = button.isLoading
        })
    end

    return React.createElement(ButtonGroup, {
        buttons = buttons,
        orientation = EnumsOrientation.Vertical,
        LayoutOrder = tbl1.LayoutOrder or 3,
        testId = tbl1.testId or "account-upgrade-dialog-actions"
    })
end

return AccountUpgradeDialogActions
