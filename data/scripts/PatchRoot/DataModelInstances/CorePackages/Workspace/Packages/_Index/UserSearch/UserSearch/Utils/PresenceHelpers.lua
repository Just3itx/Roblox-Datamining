-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserSearch = script:FindFirstAncestor("UserSearch")
local UserSearchParent = UserSearch.Parent

local _LocalTypes = require(UserSearch.Common.LocalTypes)
local PresenceType = require(UserSearch.Rodux.RoduxPresence).Enums.PresenceType
local FFlagUserSearchPresenceStoreMigration = require(UserSearch.Flags.FFlagUserSearchPresenceStoreMigration)
local PresenceType2 = if FFlagUserSearchPresenceStoreMigration then require(UserSearchParent.DataHydration).Presence.PresenceEnums.PresenceType else nil

return {
    isUserOnline = function(arg1): boolean
        if FFlagUserSearchPresenceStoreMigration then
            return arg1 == PresenceType2.Online or arg1 == PresenceType2.InStudio or arg1 == PresenceType2.InGame
        end

        return arg1 == PresenceType.Online or arg1 == PresenceType.InStudio or arg1 == PresenceType.InGame
    end,
    isUserInGame = function(arg1): boolean
        return if arg1 and arg1.universeId then if FFlagUserSearchPresenceStoreMigration then arg1.userPresenceType == PresenceType2.InGame else arg1.userPresenceType == PresenceType.InGame else false
    end
}
