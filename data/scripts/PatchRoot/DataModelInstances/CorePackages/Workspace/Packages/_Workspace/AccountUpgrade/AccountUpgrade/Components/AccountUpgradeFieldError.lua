-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgradeParent = script:FindFirstAncestor("AccountUpgrade").Parent

local React = require(AccountUpgradeParent.React)
local FoundationText = require(AccountUpgradeParent.Foundation).Text

local function AccountUpgradeFieldError(tbl1)
    if tbl1.text == nil or tbl1.text == "" then
        return nil
    end

    return React.createElement(FoundationText, {
        Text = tbl1.text,
        tag = "size-full-0 auto-y text-body-small text-wrap text-align-x-left content-system-alert",
        LayoutOrder = tbl1.LayoutOrder,
        testId = tbl1.testId
    })
end

return AccountUpgradeFieldError
