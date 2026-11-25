-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")

local PresenceType = require(ProfilePlatform.Rodux.Presence).Enums.PresenceType
local Enums = require(ProfilePlatform.Common.Enums)

local tbl1 = {
    [PresenceType.Offline] = Enums.PresenceTypes.Offline,
    [PresenceType.Online] = Enums.PresenceTypes.Online,
    [PresenceType.InGame] = Enums.PresenceTypes.InGame,
    [PresenceType.InStudio] = Enums.PresenceTypes.InStudio,
    Offline = Enums.PresenceTypes.Offline,
    Online = Enums.PresenceTypes.Online,
    InGame = Enums.PresenceTypes.InGame,
    InStudio = Enums.PresenceTypes.InStudio
}

return function(str1: string, num1: number?)
    local var1 = tbl1[str1] or Enums.PresenceTypes.Offline

    return if var1 == Enums.PresenceTypes.InGame and num1 == nil then Enums.PresenceTypes.Online else var1
end
