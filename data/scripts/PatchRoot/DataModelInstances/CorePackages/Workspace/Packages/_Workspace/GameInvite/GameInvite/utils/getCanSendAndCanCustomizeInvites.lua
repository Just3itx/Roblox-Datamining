-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInvite = script:FindFirstAncestor("GameInvite")
local GameInviteParent = GameInvite.Parent

local networkImpl = require(GameInvite.GameInviteDependencies).networkImpl
local _gameInviteModalType = require(GameInvite.gameInviteModalType)

local GetCanSendAndCanCustomizeInvites = require(GameInvite.Requests.GetCanSendAndCanCustomizeInvites)

local FFlagGameInviteOpenModalWithoutBlockingOnCanPrompt = require(GameInviteParent.SharedFlags).FFlagGameInviteOpenModalWithoutBlockingOnCanPrompt

return function(arg1, num1: number?)
    local var1, var2 = GetCanSendAndCanCustomizeInvites(networkImpl, arg1, num1):await()

    if var1 and var2 and var2.responseBody then
        return var2.responseBody.canPrompt or false, var2.responseBody.canCustomize or false
    elseif FFlagGameInviteOpenModalWithoutBlockingOnCanPrompt then
        return true, false
    end

    return false, false
end
