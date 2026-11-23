-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VideoUtils = script:FindFirstAncestor("VideoUtils")
local VideoUtilsParent = VideoUtils.Parent

local React = require(VideoUtilsParent.React)

local VideoEndReason = require(VideoUtils.Analytics.Enums).VideoEndReason

local function VideoHoverPlaybackDetector(tbl1)
    React.useEffect(function()
        if tbl1.isHovered then
            tbl1.requestVideoPlayback(false)
            return
        end
        tbl1.cancelVideoPlayback(VideoEndReason.Unhovered)
    end, { tbl1.isHovered, tbl1.requestVideoPlayback, tbl1.cancelVideoPlayback })

    return nil
end

return VideoHoverPlaybackDetector
