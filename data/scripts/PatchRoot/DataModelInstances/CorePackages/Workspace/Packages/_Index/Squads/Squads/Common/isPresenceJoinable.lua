-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent
local PresenceType = require(Squads.dependencies).RoduxPresence.Enums.PresenceType

local FFlagSquadMemberJoinDialogAndOverflowMenu = require(Squads.Flags.FFlagSquadMemberJoinDialogAndOverflowMenu)
local FFlagSquadsPresenceStoreMigration = require(SquadsParent.SquadsCore.Flags).FFlagSquadsPresenceStoreMigration
local PresenceType2 = if FFlagSquadsPresenceStoreMigration then require(SquadsParent.DataHydration).Presence.PresenceEnums.PresenceType else nil

local function isPresenceJoinable(arg1): boolean
    if not arg1 then
        return false
    end

    local inGame = if FFlagSquadsPresenceStoreMigration then PresenceType2.InGame else PresenceType.InGame

    if arg1.userPresenceType ~= inGame or arg1.gameId == game.JobId then
        return false
    end
    if not FFlagSquadMemberJoinDialogAndOverflowMenu then
        return if FFlagSquadsPresenceStoreMigration then arg1.placeId ~= "" else arg1.placeId ~= nil
    end

    return not (arg1.placeId == nil) and arg1.placeId ~= ""
end

return isPresenceJoinable
