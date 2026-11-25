-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)

local BannerContext = Foundation.BannerContext

return React.memo(function(tbl1) -- name: SduiBannerContext
    return React.createElement(BannerContext, {
        text = tbl1.text,
        variant = tbl1.variant,
        presentation = tbl1.presentation,
        icon = tbl1.icon,
        link = tbl1.link,
        onClose = tbl1.onClose,
        AnchorPoint = tbl1.anchorPoint,
        LayoutOrder = tbl1.layoutOrder,
        Position = tbl1.position,
        Visible = tbl1.visible,
        ZIndex = tbl1.zIndex,
        testId = tbl1.testId
    })
end)
