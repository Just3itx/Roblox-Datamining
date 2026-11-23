-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local LOOK_TYPE = require(AvatarExperienceCommon.Constants).LOOK_TYPE

local function selectTryOnsLookId(arg1)
    if arg1.AvatarExperience.AvatarScene.OutfitTryOn.LastToggledLookType == LOOK_TYPE.Makeup then
        return arg1.AvatarExperience.AvatarScene.OutfitTryOn.MakeupLookId
    end

    return arg1.AvatarExperience.AvatarScene.OutfitTryOn.LookId
end

return selectTryOnsLookId
