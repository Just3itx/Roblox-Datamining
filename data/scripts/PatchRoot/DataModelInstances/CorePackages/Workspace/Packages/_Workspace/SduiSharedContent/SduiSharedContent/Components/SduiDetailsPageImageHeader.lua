-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)

local View = Foundation.View
local Image = Foundation.Image

return React.memo(function(tbl1) -- name: SduiDetailsPageImageHeader
    return React.createElement(View, {
        tag = "col align-x-center align-y-center",
        Size = tbl1.size,
        Position = tbl1.position,
        AnchorPoint = tbl1.anchorPoint,
        LayoutOrder = tbl1.layoutOrder,
        Visible = tbl1.visible,
        ZIndex = tbl1.zIndex,
        backgroundStyle = tbl1.backgroundStyle,
        AutomaticSize = tbl1.automaticSize,
        testId = tbl1.testId
    }, {
        Image = React.createElement(Image, {
            Image = tbl1.image,
            Size = tbl1.imageSize,
            TileSize = tbl1.tileSize,
            ScaleType = tbl1.scaleType,
            ResampleMode = tbl1.resampleMode,
            imageStyle = tbl1.imageStyle,
            tag = tbl1.imageTag,
            SizeConstraint = tbl1.imageSizeConstraint
        })
    })
end)
