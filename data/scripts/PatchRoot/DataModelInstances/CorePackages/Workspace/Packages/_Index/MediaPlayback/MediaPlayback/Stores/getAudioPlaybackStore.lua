-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:01:36Z
-- Luau bytecode version: 14 | Luau type version: 3
local MediaPlayback = script:FindFirstAncestor("MediaPlayback")

local Signals = require(MediaPlayback.Parent.Signals)

local _types = require(script.types)
local createAudioPlaybackStore = require(script.createAudioPlaybackStore)

return Signals.createComputed(createAudioPlaybackStore)
