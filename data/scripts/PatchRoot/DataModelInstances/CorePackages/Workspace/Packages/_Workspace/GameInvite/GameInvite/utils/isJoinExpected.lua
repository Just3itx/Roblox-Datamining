-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInviteParent = script:FindFirstAncestor("GameInvite").Parent

local DataHydration = require(GameInviteParent.DataHydration)
local UserModel = require(GameInviteParent.UserLib).Models.UserModel

local isInThisServer = require(script.Parent.isInThisServer)

local InGame = DataHydration.Presence.PresenceEnums.PresenceType.InGame

local function isJoinExpected(arg1, tbl1, str1: string): boolean
    if arg1 == nil then
        return tbl1 == nil or tbl1.presence == UserModel.PresenceType.IN_GAME
    end

    return arg1.userPresenceType == InGame and not isInThisServer(arg1, str1)
end

return isJoinExpected
