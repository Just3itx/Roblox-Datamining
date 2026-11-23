-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local LibraryAudioPlayerContentView = require(script.Parent.LibraryAudioPlayerContentView)

local function LibraryAudioPlayerView(arg1)
    local var1 = Foundation.Hooks.useScaledValue(168)
    if arg1.status == "Failed" then
        return React.createElement(Foundation.Text, { Text = arg1.unavailableText, tag = "auto-xy text-body-medium content-default" })
    elseif arg1.status ~= "Ready" then
        return React.createElement(Foundation.Skeleton, {
            Size = UDim2.fromOffset(var1, var1),
            radius = Foundation.Enums.Radius.Medium,
            testId = "Library.Preview.SoundLoading"
        })
    end

    return React.createElement(LibraryAudioPlayerContentView, {
        isCompact = arg1.isCompact,
        title = arg1.title,
        artist = arg1.artist,
        isPlaying = arg1.isPlaying,
        elapsed = arg1.elapsed,
        duration = arg1.duration,
        onTogglePlayback = arg1.onTogglePlayback,
        onSeek = arg1.onSeek,
        onSeekStarted = arg1.onSeekStarted,
        onSeekEnded = arg1.onSeekEnded
    })
end

return LibraryAudioPlayerView
