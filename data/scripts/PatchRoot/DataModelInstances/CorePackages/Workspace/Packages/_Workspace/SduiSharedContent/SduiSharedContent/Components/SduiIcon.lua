-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)

return React.memo(function(tbl1) -- name: SduiIcon
    return React.createElement(Foundation.Icon, {
        name = tbl1.name,
        style = tbl1.style,
        size = tbl1.size,
        variant = tbl1.variant,
        Rotation = tbl1.rotation,
        AnchorPoint = tbl1.anchorPoint,
        LayoutOrder = tbl1.layoutOrder,
        Position = tbl1.position,
        Visible = tbl1.visible,
        ZIndex = tbl1.zIndex,
        testId = tbl1.testId
    }, tbl1.children)
end)
