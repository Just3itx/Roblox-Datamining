-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local getAudioPlaybackStore = require(script.Stores.getAudioPlaybackStore)

return {
    useLazyFmod = require(script.Hooks.useLazyFmod),
    getAudioPlaybackStore = getAudioPlaybackStore,
    useAudioStore = require(script.Hooks.useAudioStore),
    useLastPlayedAudioStore = require(script.Hooks.useLastPlayedAudioStore),
    enableAudioPlaybackInApp = require(script.Common.enableAudioPlaybackInApp),
    getFFlagAudioPreviewLua = require(script.Flags.getFFlagAudioPreviewLua),
    ["jest.config"] = script["jest.config"]
}
