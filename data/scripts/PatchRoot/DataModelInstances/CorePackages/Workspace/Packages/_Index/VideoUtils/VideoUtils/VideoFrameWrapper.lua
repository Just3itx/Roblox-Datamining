-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VideoUtilsParent = script:FindFirstAncestor("VideoUtils").Parent

local React = require(VideoUtilsParent.React)

local FFlagLuaAppVideoPlayerTrimAndMusic = require(VideoUtilsParent.SharedFlags).FFlagLuaAppVideoPlayerTrimAndMusic

local function VideoFrameWrapper(tbl1)
    React.useEffect(function()
        local current = if tbl1.videoFrameRef then tbl1.videoFrameRef.current else nil

        return function()
            if current then
                current.Video = ""
            end
        end
    end, { tbl1.videoFrameRef })

    return React.createElement("VideoFrame", {
        Size = UDim2.fromScale(1, 1),
        Video = if tbl1.isPlaying then tbl1.video else "",
        Playing = not (FFlagLuaAppVideoPlayerTrimAndMusic and tbl1.startPaused) and tbl1.isPlaying,
        Looped = tbl1.looped,
        Volume = tbl1.volume,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = tbl1.zIndex or 1,
        ref = tbl1.videoFrameRef,
        [React.Event.Loaded] = tbl1.onLoaded,
        [React.Event.DidLoop] = tbl1.onLooped,
        [React.Event.Ended] = tbl1.onEnded
    }, {
        Corner = if tbl1.cornerRadius then React.createElement("UICorner", { CornerRadius = UDim.new(0, tbl1.cornerRadius) }) else nil
    })
end

return VideoFrameWrapper
