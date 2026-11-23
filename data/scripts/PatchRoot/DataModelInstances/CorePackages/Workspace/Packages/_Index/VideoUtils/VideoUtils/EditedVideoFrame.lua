-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VideoUtilsParent = script:FindFirstAncestor("VideoUtils").Parent

local React = require(VideoUtilsParent.React)

local VideoFrameWrapper = require(script.Parent.VideoFrameWrapper)
local createVideoEditPlayback = require(script.Parent.createVideoEditPlayback)
local _getVideoEdits = require(script.Parent.getVideoEdits)

local function EditedVideoFrame(arg1)
    local var1 = React.useRef(nil)
    local videoFrameRef = arg1.videoFrameRef or var1
    local var3 = React.useRef(nil)
    local var4 = React.useRef(nil)
    var4.current = {
        onEnded = arg1.onEnded,
        onLooped = arg1.onLooped
    }
    local bool1 = arg1.volume == 0

    React.useLayoutEffect(function()
        local current = videoFrameRef.current
        if current == nil or not arg1.isPlaying then
            return nil
        end
        local videoEditPlayback = createVideoEditPlayback(current, arg1.edits, arg1.looped == true, function()
            return var4.current
        end)
        var3.current = videoEditPlayback
        return function()
            videoEditPlayback.destroy()
            var3.current = nil
        end
    end, {
        videoFrameRef,
        arg1.video,
        arg1.isPlaying,
        arg1.edits,
        arg1.looped
    })
    React.useLayoutEffect(function()
        if var3.current then
            var3.current.setMuted(bool1)
        end
    end, {
        bool1,
        arg1.video,
        arg1.isPlaying,
        arg1.edits,
        arg1.looped
    })
    return React.createElement(VideoFrameWrapper, {
        videoFrameRef = videoFrameRef,
        video = arg1.video,
        isPlaying = arg1.isPlaying,
        startPaused = true,
        looped = arg1.looped == true and arg1.edits.trim == nil,
        volume = if arg1.edits.music then 0 else arg1.volume,
        onLoaded = arg1.onLoaded,
        cornerRadius = arg1.cornerRadius,
        zIndex = arg1.zIndex
    })
end

return EditedVideoFrame
