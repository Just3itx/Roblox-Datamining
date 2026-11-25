-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)

local function SduiImage(tbl1)
    return React.createElement(Foundation.Image, {
        AnchorPoint = tbl1.anchorPoint,
        AutomaticSize = tbl1.automaticSize,
        ClipsDescendants = tbl1.clipsDescendants,
        Image = tbl1.image,
        LayoutOrder = tbl1.layoutOrder,
        Position = tbl1.position,
        ResampleMode = tbl1.resampleMode,
        ScaleType = tbl1.scaleType,
        Size = tbl1.size,
        SizeConstraint = tbl1.sizeConstraint,
        TileSize = tbl1.tileSize,
        Visible = tbl1.visible,
        ZIndex = tbl1.zIndex,
        aspectRatio = tbl1.aspectRatio,
        backgroundStyle = tbl1.backgroundStyle,
        cornerRadius = tbl1.cornerRadius,
        cursor = tbl1.cursorType,
        imageStyle = tbl1.imageStyle,
        onActivated = tbl1.onActivated,
        tag = tbl1.tag,
        testId = tbl1.testId
    })
end

return SduiImage
