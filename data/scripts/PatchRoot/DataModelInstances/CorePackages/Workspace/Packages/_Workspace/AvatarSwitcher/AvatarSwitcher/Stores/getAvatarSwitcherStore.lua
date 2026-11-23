-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
local AvatarSwitcher = script:FindFirstAncestor("AvatarSwitcher")
local AvatarSwitcherParent = AvatarSwitcher.Parent

local Signals = require(AvatarSwitcherParent.Signals)

local createAvatarSwitcherStore = require(AvatarSwitcher.Stores.createAvatarSwitcherStore)

return Signals.createComputed(createAvatarSwitcherStore)
