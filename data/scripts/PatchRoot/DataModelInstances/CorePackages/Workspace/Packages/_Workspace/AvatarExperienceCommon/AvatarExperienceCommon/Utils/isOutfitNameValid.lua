-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local AvatarExperienceFlags = require(AvatarExperienceCommonParent.AvatarExperienceFlags)
local AvatarExperienceFormValidation = require(AvatarExperienceCommonParent.AvatarExperienceFormValidation)

local FIntAXOutfitNameMaxLength = AvatarExperienceFlags.FIntAXOutfitNameMaxLength

return (AvatarExperienceFormValidation.buildFormValidator({ AvatarExperienceFormValidation.Validators.isNotNull, AvatarExperienceFormValidation.Validators.String.buildIsShorterThanOrEqualTo(FIntAXOutfitNameMaxLength), AvatarExperienceFormValidation.Validators.String.isNotWhitespace }))
