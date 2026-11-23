-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local CapturesCommon = require(scriptParentParentParentParent.CapturesCommon)
local Foundation = require(scriptParentParentParentParent.Foundation)
local React = require(scriptParentParentParentParent.React)

local _Types = require(scriptParentParentParent.Types)

local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local Image = Foundation.Image
local View = Foundation.View

local getContentFromObject = CapturesCommon.Utils.getContentFromObject

local function renderThumbnailSlot(arg1, tbl1, bool1: boolean)
    local createElement = React.createElement
    local var1 = View
    local tbl2 = {
        scale = tbl1.scale,
        ZIndex = if bool1 then 2 else 1,
        tag = "position-center-center anchor-center-center size-full"
    }
    local tbl3 = {
        Thumbnail = React.createElement(Image, {
            ImageContent = if arg1 then getContentFromObject(arg1) else nil,
            imageStyle = tbl1.style,
            ScaleType = Enum.ScaleType.Crop,
            tag = "position-center-center anchor-center-center size-600-600 radius-small"
        })
    }
    return createElement(var1, tbl2, tbl3)
end

local function GalleryButtonContentView(tbl1)
    return React.createElement(View, { tag = "size-1200-1200" }, {
        GalleryThumbnail1 = renderThumbnailSlot(tbl1.slotCaptures[1], tbl1.thumbnails[1], tbl1.activeSlot == 1),
        GalleryThumbnail2 = renderThumbnailSlot(tbl1.slotCaptures[2], tbl1.thumbnails[2], tbl1.activeSlot == 2),
        GalleryIcon = React.createElement(
            View,
            {
                scale = tbl1.iconScale,
                tag = "position-center-center anchor-center-center size-full"
            },
            {
                Icon = React.createElement(Icon, {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    name = IconName.ImageStacked,
                    size = IconSize.Large,
                    style = tbl1.iconStyle
                })
            }
        )
    })
end
return GalleryButtonContentView
