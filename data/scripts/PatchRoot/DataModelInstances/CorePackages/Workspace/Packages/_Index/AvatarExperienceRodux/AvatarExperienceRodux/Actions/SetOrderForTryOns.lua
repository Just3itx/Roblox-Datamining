-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceRoduxParent = script:FindFirstAncestor("AvatarExperienceRodux").Parent
local Rodux = require(AvatarExperienceRoduxParent.Rodux)
local _AvatarExperienceCommon = require(AvatarExperienceRoduxParent.AvatarExperienceCommon)

return Rodux.makeActionCreator(script.Name, function(itemIdToOrderMap)
    return { itemIdToOrderMap = itemIdToOrderMap }
end)
