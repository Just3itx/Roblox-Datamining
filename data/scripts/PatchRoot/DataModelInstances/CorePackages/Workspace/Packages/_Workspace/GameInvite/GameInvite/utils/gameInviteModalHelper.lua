-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInvite = script:FindFirstAncestor("GameInvite")
local GameInviteConstants = require(GameInvite.GameInviteConstants)
local _gameInviteModalType = require(GameInvite.gameInviteModalType)

function isTriggerDDI(arg1): boolean
    return arg1 == GameInviteConstants.Triggers.DeveloperSingle or arg1 == GameInviteConstants.Triggers.DeveloperMultiple
end

function isTriggerGameMenu(gameMenu): boolean
    return gameMenu == GameInviteConstants.Triggers.GameMenu
end

return {
    isTriggerDDI = isTriggerDDI,
    isTriggerGameMenu = isTriggerGameMenu
}
