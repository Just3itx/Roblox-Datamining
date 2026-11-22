-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)

local VideoLiftView = require(script.Parent.VideoLiftView)
local useVideoLiftViewModel = require(script.Parent.useVideoLiftViewModel)

local function VideoLiftContainer(tbl1)
    local var1 = useVideoLiftViewModel(tbl1.feedItemId)
    return React.createElement(VideoLiftView, {
        size = var1.size,
        position = var1.position,
        mediaSurface = var1.mediaSurface,
        onItemRectChanged = var1.onItemRectChanged
    }, tbl1.children)
end

return VideoLiftContainer
