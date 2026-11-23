-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VideoPlayerParent = script:FindFirstAncestor("VideoPlayer").Parent

local React = require(VideoPlayerParent.React)
local ArgCheck = require(VideoPlayerParent.ArgCheck)

local function VideoPlayerWrapper(tbl1)
    local videoContent = React.useMemo(function(): Content
        return Content.fromUri(tbl1.video)
    end, { tbl1.video })

    local var2 = React.useCallback(function()
        if tbl1.onVideoLooped then
            tbl1.onVideoLooped()
        end
    end, { tbl1.onVideoLooped })

    local var3 = React.useCallback(function()
        if tbl1.onVideoEnded then
            tbl1.onVideoEnded()
        end
    end, { tbl1.onVideoEnded })

    React.useEffect(function()
        local current = tbl1.videoPlayerRef.current
        local current2 = tbl1.videoDisplayRef.current
        ArgCheck.assert(
            not (current == nil) and current2 ~= nil,
            "VideoPlayerWrapper expects videoPlayer and videoDisplay refs to be set before wiring"
        )
        local wire = Instance.new("Wire")
        wire.SourceInstance = current
        wire.TargetInstance = current2
        wire.Parent = current

        local videoAudioOutput = Instance.new("AudioDeviceOutput")
        videoAudioOutput.Name = "VideoAudioOutput"
        videoAudioOutput.Parent = current

        local wire2 = Instance.new("Wire")
        wire2.SourceInstance = current
        wire2.TargetInstance = videoAudioOutput
        wire2.Parent = current

        return function()
            wire2:Destroy()
            videoAudioOutput:Destroy()
            wire:Destroy()
        end
    end, { tbl1.videoPlayerRef, tbl1.videoDisplayRef })

    return React.createElement("VideoPlayer", {
        Name = "VideoPlayer",
        VideoContent = videoContent,
        Volume = if tbl1.muted then 0 else 1,
        Looping = tbl1.looped or false,
        [React.Event.DidLoop] = var2,
        [React.Event.DidEnd] = var3,
        ref = tbl1.videoPlayerRef
    })
end

return VideoPlayerWrapper
