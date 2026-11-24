-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInvite = script:FindFirstAncestor("GameInvite")
local GameInviteConstants = require(GameInvite.GameInviteConstants)
local _gameInviteModalType = require(GameInvite.gameInviteModalType)

local tbl1 = {
    [GameInviteConstants.Triggers.GameMenu] = true
}

local function shouldShowJoinCta(arg1): boolean
    return tbl1[arg1.trigger] == true
end

return shouldShowJoinCta
