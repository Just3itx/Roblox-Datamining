-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
local GameInviteParent = script:FindFirstAncestor("GameInvite").Parent

local SharedFlags = require(GameInviteParent.SharedFlags)
local FFlagGameInviteInExpUserListRenderer = require(script.Parent.FFlagGameInviteInExpUserListRenderer)

return SharedFlags.FFlagGameInviteInExpJoinCta3
    and FFlagGameInviteInExpUserListRenderer
    and SharedFlags.FFlagUserListCtaIntegrationEnabled
    and SharedFlags.FFlagGameJoinCardOptionalActions
