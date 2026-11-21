-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCardParent = script:FindFirstAncestor("GameJoinCard").Parent
local React = require(GameJoinCardParent.React)
local VideoPlayer = require(GameJoinCardParent.VideoUtils).VideoPlayer

local function JoinCardBannerVideoView(tbl1)
    return React.createElement("Frame", {
        [React.Tag] = "data-testid=JoinCardBannerVideoView",
        Size = tbl1.Size,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Visible = tbl1.isVisible,
        ZIndex = tbl1.ZIndex
    }, {
        VideoPlayer = React.createElement(VideoPlayer, {
            video = tbl1.video,
            shouldStartPlayback = tbl1.shouldStartPlayback,
            muted = true,
            looped = true,
            Size = UDim2.fromScale(1, 1),
            ScaleType = Enum.ScaleType.Crop,
            cornerRadius = tbl1.cornerRadius,
            hideCenterPlayButton = true,
            disableActivation = tbl1.onActivated == nil,
            onVideoPlayerActivated = tbl1.onActivated,
            videoAnalyticsContext = tbl1.videoAnalyticsContext,
            onVideoLoaded = tbl1.onVideoLoaded
        })
    })
end

return JoinCardBannerVideoView
