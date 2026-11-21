-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceRoduxParent = script:FindFirstAncestor("AvatarExperienceRodux").Parent
local Rodux = require(AvatarExperienceRoduxParent.Rodux)
local _AvatarExperienceModel = require(AvatarExperienceRoduxParent.AvatarExperienceModel)

return Rodux.makeActionCreator(script.Name, function(itemId: string, selectedInTryOnManager: boolean, itemType)
    return { itemId = itemId, selectedInTryOnManager = selectedInTryOnManager, itemType = itemType }
end)
