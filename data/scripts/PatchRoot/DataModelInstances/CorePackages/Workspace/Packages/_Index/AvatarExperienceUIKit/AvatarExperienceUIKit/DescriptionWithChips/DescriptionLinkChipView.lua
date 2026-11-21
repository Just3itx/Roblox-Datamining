-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:01:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local React = require(AvatarExperienceUIKitParent.React)
local Foundation = require(AvatarExperienceUIKitParent.Foundation)

local Chip = Foundation.Chip
local ChipSize = Foundation.Enums.ChipSize

return React.forwardRef(function(tbl1, ref) -- name: DescriptionLinkChipView
    local createElement = React.createElement
    local var1 = Chip
    local tbl2 = {
        text = tbl1.text,
        leading = tbl1.icon,
        size = ChipSize.Small,
        onActivated = tbl1.onActivated,
        isDisabled = tbl1.isInvalid,
        LayoutOrder = tbl1.LayoutOrder,
        testId = if tbl1.isInvalid then "--item-description-link-chip-invalid" else "--item-description-link-chip",
        ref = 0
    }

    if tbl1.isInvalid then
        ref = nil
    end

    tbl2.ref = ref
    return createElement(var1, tbl2)
end)
