-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInvite = script:FindFirstAncestor("GameInvite")
local GameInviteConstants = require(GameInvite.GameInviteConstants)
local _gameInviteModalType = require(GameInvite.gameInviteModalType)

local getCustomizedInvitePromptUserId = require(script.Parent.getCustomizedInvitePromptUserId)

return function(arg1)
    return getCustomizedInvitePromptUserId(arg1) and GameInviteConstants.Triggers.DeveloperSingle
        or GameInviteConstants.Triggers.DeveloperMultiple
end
