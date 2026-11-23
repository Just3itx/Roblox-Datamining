-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local SPAWN_EFFECT_ASSET_TYPE_ID_STRING = require(AvatarExperienceCommon.Constants).SPAWN_EFFECT_ASSET_TYPE_ID_STRING

local function setAvatarEffectDescriptions(arg1, tbl1)
    for _, child in arg1:GetChildren() do
        if child:IsA("AvatarEffectDescription") then
            child:Destroy()
        end
    end

    for value in tbl1[SPAWN_EFFECT_ASSET_TYPE_ID_STRING] or {} do
        local avatarEffectDescription = Instance.new("AvatarEffectDescription")
        avatarEffectDescription.AssetId = tonumber(value)

        avatarEffectDescription.EffectType = Enum.AvatarEffectType.Spawn
        avatarEffectDescription.Parent = arg1
    end
end

return setAvatarEffectDescriptions
