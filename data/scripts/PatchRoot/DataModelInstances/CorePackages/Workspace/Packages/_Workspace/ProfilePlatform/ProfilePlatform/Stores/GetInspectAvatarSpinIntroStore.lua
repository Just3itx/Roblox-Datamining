-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent
local Signals = require(ProfilePlatformParent.Signals)

local createInspectAvatarSpinIntroStore = require(script.createInspectAvatarSpinIntroStore)

return Signals.createComputed(createInspectAvatarSpinIntroStore)
