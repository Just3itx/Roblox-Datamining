-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)

local Badge = Foundation.Badge

local FFlagSduiBadgeShape = require(SduiSharedContentParent.SharedFlags).FFlagSduiBadgeShape

return React.memo(function(tbl1) -- name: SduiBadge
    return React.createElement(Badge, {
        text = tbl1.text,
        icon = tbl1.icon,
        variant = tbl1.variant,
        shape = if FFlagSduiBadgeShape then tbl1.shape else nil,
        testId = tbl1.testId,
        onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged,
        onAbsolutePositionChanged = tbl1.onAbsolutePositionChanged,
        AnchorPoint = tbl1.anchorPoint,
        LayoutOrder = tbl1.layoutOrder,
        Position = tbl1.position,
        Visible = tbl1.visible,
        ZIndex = tbl1.zIndex
    })
end)
