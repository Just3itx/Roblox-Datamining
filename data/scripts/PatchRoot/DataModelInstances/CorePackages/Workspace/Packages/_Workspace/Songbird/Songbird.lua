-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local _types = require(script.types)

local sendAudioPlayerAnalytics = require(script.Analytics.sendAudioPlayerAnalytics)
local AnalyticActions = require(script.Analytics.AnalyticActions)

return {
    AudioPlaybackTimeline = require(script.Components.AudioPlaybackTimeline),
    AudioPlayer = require(script.Components.AudioPlayer),
    AudioPlayerActions = require(script.Components.AudioPlayerActions),
    ChromeWindowWrapper = require(script.Components.ChromeWindowWrapper),
    ReportSongDialog = require(script.Components.ReportSongDialog),
    DebugAudioEmitters = require(script.Components.DebugAudioEmitters),
    useCurrentSong = require(script.Hooks.useCurrentSong),
    useSongAlbumArt = require(script.Hooks.useSongAlbumArt),
    useAudioMetadata = require(script.Hooks.useAudioMetadata),
    Analytics = {
        sendAudioPlayerAnalytics = sendAudioPlayerAnalytics,
        AnalyticActions = AnalyticActions
    },
    ["jest.config"] = script["jest.config"]
}
