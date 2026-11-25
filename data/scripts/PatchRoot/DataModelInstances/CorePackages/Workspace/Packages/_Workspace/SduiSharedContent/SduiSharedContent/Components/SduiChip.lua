-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)

local Chip = Foundation.Chip

local FFlagSduiChipAccessoryProps = require(SduiSharedContentParent.SharedFlags).FFlagSduiChipAccessoryProps
local FFlagSduiChipSizeAndVariant = require(SduiSharedContentParent.SharedFlags).FFlagSduiChipSizeAndVariant

return React.memo(function(tbl1) -- name: SduiChip
    local layoutOrder = tbl1.layoutOrder
    local anchorPoint = tbl1.anchorPoint
    local position = tbl1.position

    local leading = nil
    if FFlagSduiChipAccessoryProps and tbl1.leading then
        leading = tbl1.leading
    elseif tbl1.leadingIconName then
        leading = (tbl1.leadingIconVariant or tbl1.leadingIsCircular or tbl1.leadingOnActivated)
            and {
                iconName = tbl1.leadingIconName,
                iconVariant = tbl1.leadingIconVariant,
                isCircular = tbl1.leadingIsCircular,
                onActivated = tbl1.leadingOnActivated
            }
            or tbl1.leadingIconName
    end

    local trailing = nil
    if FFlagSduiChipAccessoryProps and tbl1.trailing then
        trailing = tbl1.trailing
    elseif tbl1.trailingIconName then
        trailing = (tbl1.trailingIconVariant or tbl1.trailingIsCircular or tbl1.trailingOnActivated)
            and {
                iconName = tbl1.trailingIconName,
                iconVariant = tbl1.trailingIconVariant,
                isCircular = tbl1.trailingIsCircular,
                onActivated = tbl1.trailingOnActivated
            }
            or tbl1.trailingIconName
    end

    return React.createElement(Chip, {
        text = tbl1.text,
        leading = leading,
        trailing = trailing,
        onActivated = tbl1.onActivated,
        isChecked = tbl1.isChecked,
        Selectable = tbl1.selectable,
        size = if FFlagSduiChipSizeAndVariant then tbl1.chipSize else tbl1.size,
        variant = if FFlagSduiChipSizeAndVariant then tbl1.variant else nil,
        LayoutOrder = layoutOrder,
        AnchorPoint = anchorPoint,
        Position = position
    })
end)
