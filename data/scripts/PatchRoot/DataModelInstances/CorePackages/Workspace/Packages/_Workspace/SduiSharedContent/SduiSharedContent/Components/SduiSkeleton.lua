-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)

local Skeleton = Foundation.Skeleton

return React.memo(function(tbl1) -- name: SduiSkeleton
    return React.createElement(Skeleton, {
        radius = tbl1.radius,
        Size = tbl1.size,
        LayoutOrder = tbl1.layoutOrder,
        AnchorPoint = tbl1.anchorPoint,
        Position = tbl1.position,
        Visible = tbl1.visible,
        ZIndex = tbl1.zIndex,
        testId = tbl1.testId
    })
end)
