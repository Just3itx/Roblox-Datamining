-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:40:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInvite = script:FindFirstAncestor("GameInvite")
local GameInviteParent = GameInvite.Parent

local DataHydration = require(GameInviteParent.DataHydration)
local _UserList = require(GameInviteParent.UserList)
local UserModel = require(GameInviteParent.UserLib).Models.UserModel

local escapeRichText = require(GameInvite.utils.escapeRichText)

local PresenceType = DataHydration.Presence.PresenceEnums.PresenceType

return {
    getContextText = function(tbl1, tbl2)
        local lastLocation = tbl1.lastLocation
        if tbl1.presence == UserModel.PresenceType.IN_STUDIO then
            return tbl2.inStudio
        elseif tbl1.presence == UserModel.PresenceType.IN_GAME and lastLocation ~= nil and lastLocation ~= "" then
            return escapeRichText(lastLocation)
        end
        return nil
    end,
    getContextTextForPresence = function(arg1, str1: string?, tbl1)
        if arg1 == PresenceType.InStudio then
            return tbl1.inStudio
        elseif arg1 == PresenceType.InGame and str1 ~= nil and str1 ~= "" then
            return escapeRichText(str1)
        end

        return if arg1 == PresenceType.Online then tbl1.online else nil
    end,
    getLivePresenceType = function(arg1)
        return if arg1.userPresenceType == PresenceType.InGame and arg1.universeId == "" then PresenceType.Online else arg1.userPresenceType
    end
}
