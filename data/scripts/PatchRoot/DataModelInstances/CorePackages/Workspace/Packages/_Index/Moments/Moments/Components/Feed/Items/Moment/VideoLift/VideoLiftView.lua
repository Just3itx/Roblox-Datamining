-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)

local View = Foundation.View
local MediaSurfaceContext = MomentsCommon.Media.MediaSurfaceContext

local vector2 = Vector2.new(0.5, 0.5)

local function VideoLiftView(tbl1)
    return React.createElement(View, {
        tag = "size-full",
        onAbsolutePositionChanged = tbl1.onItemRectChanged,
        onAbsoluteSizeChanged = tbl1.onItemRectChanged,
        testId = "--moments-item-video-lift"
    }, {
        Media = React.createElement(
            View,
            {
                AnchorPoint = vector2,
                Position = tbl1.position,
                Size = tbl1.size,
                testId = "--moments-item-video-lift-media"
            },
            {
                Surface = React.createElement(MediaSurfaceContext.Provider, { value = tbl1.mediaSurface }, tbl1.children)
            }
        )
    })
end
return VideoLiftView
