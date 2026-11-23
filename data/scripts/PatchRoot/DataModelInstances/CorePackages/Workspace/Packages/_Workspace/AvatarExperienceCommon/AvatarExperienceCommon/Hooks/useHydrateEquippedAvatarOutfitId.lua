-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent

local React = require(AvatarExperienceCommonParent.React)

local getEquippedAvatarOutfitIdStore = require(AvatarExperienceCommon.Stores.EquippedAvatarOutfitIdStore.getEquippedAvatarOutfitIdStore)

local function useHydrateEquippedAvatarOutfitId()
    local equippedAvatarOutfitIdStore = getEquippedAvatarOutfitIdStore(false)

    React.useEffect(function()
        equippedAvatarOutfitIdStore.fetchCurrentlyWearingSavedOutfitId()
    end, { equippedAvatarOutfitIdStore })
end

return useHydrateEquippedAvatarOutfitId
