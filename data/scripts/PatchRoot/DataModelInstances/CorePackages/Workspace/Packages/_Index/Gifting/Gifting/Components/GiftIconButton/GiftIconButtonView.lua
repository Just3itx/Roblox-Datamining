-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GiftingParent = script:FindFirstAncestor("Gifting").Parent

local React = require(GiftingParent.React)
local Foundation = require(GiftingParent.Foundation)

local IconButton = Foundation.IconButton
local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize

return React.memo(function(tbl1) -- name: GiftIconButtonView
    return React.createElement(IconButton, {
        icon = IconName.GiftBox,
        onActivated = tbl1.onActivated,
        isCircular = tbl1.isCircular == true,
        isDisabled = tbl1.isDisabled,
        LayoutOrder = tbl1.LayoutOrder,
        size = InputSize.Medium,
        variant = ButtonVariant.Standard,
        testId = "gift-icon-button"
    })
end)
