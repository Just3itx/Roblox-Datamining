-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommon = script:FindFirstAncestor("SocialCommon")
local SocialCommonParent = SocialCommon.Parent
local PresenceTypes = require(SocialCommon.Enums.PresenceTypes)

local Foundation = require(SocialCommonParent.Foundation)

local tbl1 = {
    [PresenceTypes.Offline] = Foundation.Enums.UserPresence.Away,
    [PresenceTypes.Online] = Foundation.Enums.UserPresence.Active,
    [PresenceTypes.InGame] = Foundation.Enums.UserPresence.InExperience,
    [PresenceTypes.InStudio] = Foundation.Enums.UserPresence.Active,
    Offline = Foundation.Enums.UserPresence.Away,
    Online = Foundation.Enums.UserPresence.Active,
    InGame = Foundation.Enums.UserPresence.InExperience,
    InStudio = Foundation.Enums.UserPresence.Active
}

return function(str1: string)
    return tbl1[str1] or Foundation.Enums.UserPresence.None
end
