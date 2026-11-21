-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceRoduxParent = script:FindFirstAncestor("AvatarExperienceRodux").Parent
local Rodux = require(AvatarExperienceRoduxParent.Rodux)
local ArgCheck = require(AvatarExperienceRoduxParent.ArgCheck)
local _AvatarExperienceNavigation = require(AvatarExperienceRoduxParent.AvatarExperienceNavigation)

return Rodux.makeActionCreator(script.Name, function(avatarRoute)
    ArgCheck.isType(avatarRoute, "table", "avatarRoute")
    return { avatarRoute = avatarRoute }
end)
