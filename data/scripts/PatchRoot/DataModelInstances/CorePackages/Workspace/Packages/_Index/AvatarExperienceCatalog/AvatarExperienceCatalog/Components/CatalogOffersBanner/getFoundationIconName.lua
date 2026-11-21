-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local Foundation = require(AvatarExperienceCatalogParent.Foundation)
local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)

local IconName = Foundation.Enums.IconName

local FFlagAXRemoveOfferBannerIcon = AvatarExperienceFlags.FFlagAXRemoveOfferBannerIcon

local function getFoundationIconName(str1: string?)
    if str1 then
        local var1 = IconName[str1]
        if var1 then
            return var1
        end
    end
    return if FFlagAXRemoveOfferBannerIcon then nil else IconName.TagSparkle
end

return getFoundationIconName
