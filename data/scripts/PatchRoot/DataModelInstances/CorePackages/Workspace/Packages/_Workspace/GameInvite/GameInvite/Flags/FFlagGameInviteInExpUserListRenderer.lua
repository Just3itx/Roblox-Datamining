-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
local GameInviteParent = script:FindFirstAncestor("GameInvite").Parent

local SharedFlags = require(GameInviteParent.SharedFlags)

return game:DefineFastFlag("GameInviteInExpUserListRenderer_v3", false) and SharedFlags.FFlagUserListSurfaceExtensions
