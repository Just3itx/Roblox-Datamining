-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceRoduxParent = script:FindFirstAncestor("AvatarExperienceRodux").Parent
local ArgCheck = require(AvatarExperienceRoduxParent.ArgCheck)
return require(AvatarExperienceRoduxParent.Rodux).makeActionCreator(script.Name, function(assetId: string?)
    if assetId ~= nil then
        ArgCheck.isType(assetId, "string", "SetSpawnEffectPreview: assetId")
    end

    return { assetId = assetId }
end)
