-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local React = require(SplitPaneParent.React)
local AppAppLifecycleObserverService = require(SplitPaneParent.RoactServiceTags).AppAppLifecycleObserverService
local useRoactService = require(SplitPaneParent.RobloxAppHooks).useRoactService
local VideoUtils = require(SplitPaneParent.VideoUtils)

local VideoPlayer = VideoUtils.VideoPlayer
local VideoPlaybackCoordinator = VideoUtils.VideoPlaybackCoordinator
local VideoPlaybackDetectionMethod = VideoUtils.VideoPlaybackDetectionMethod
local VideoPlaybackDetector = VideoUtils.VideoPlaybackDetector

local function SplitPaneEducationalTourVideo(tbl1)
    local itemFrameRef = React.useRef(nil)
    local shouldStartPlayback, onPlaybackChange = React.useState(false)
    local var4 = useRoactService(AppAppLifecycleObserverService)
    local var5, var6 = React.useState(true)

    React.useEffect(function()
        if var4 == nil then
            return
        end

        local connection = var4.OnHide:Connect(function()
            var6(false)
        end)
        local connection2 = var4.OnUnhide:Connect(function()
            var6(true)
        end)
        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, { var4 })

    local ref = React.useCallback(function(current)
        itemFrameRef.current = current
    end, {})

    local xOffset = tbl1.mediaWidth + 2

    local yOffset = math.ceil(xOffset / tbl1.videoAspectRatio)
    local yOffset2 = yOffset - 1 - tbl1.topRadius

    return React.createElement("Frame", {
        Name = "TourVideoPlayer",
        Size = UDim2.fromOffset(tbl1.mediaWidth, yOffset2),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ref = ref
    }, {
        Viewport = React.createElement("Frame", {
            Position = UDim2.fromOffset(-1, -1),
            Size = UDim2.fromOffset(xOffset, yOffset),
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }, {
            Player = React.createElement(VideoPlayer, {
                video = tbl1.videoAssetId,
                shouldStartPlayback = shouldStartPlayback,
                muted = true,
                looped = true,
                Size = UDim2.fromScale(1, 1),
                ScaleType = Enum.ScaleType.Crop,
                cornerRadius = tbl1.topRadius + 1,
                disableActivation = true,
                hideCenterPlayButton = true
            })
        }),
        PlaybackDetector = React.createElement(VideoPlaybackDetector, {
            videoKey = "SplitPaneEducationalTour",
            itemFrameRef = itemFrameRef,
            playbackDetectionMethod = VideoPlaybackDetectionMethod.Selection,
            isHoverSupported = true,
            isHovered = var5,
            isSelected = var5,
            videoPlaybackCoordinator = VideoPlaybackCoordinator.default,
            onPlaybackChange = onPlaybackChange,
            videoDwellTimeInSec = 0,
            videoVisiblePercent = 0,
            isVideoEligible = true
        })
    })
end

return SplitPaneEducationalTourVideo
