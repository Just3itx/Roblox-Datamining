-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent
local _AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local var1 = require(AvatarExperienceCatalogParent.AvatarExperienceModel).Enums.CatalogCategories.Recommended:rawValue()

local function getShouldPageUseWidgetOnlyFetcher(arg1, num1: number?, str1: string?): boolean
    return if arg1 then not str1 and arg1.Id == var1 and not (num1 and num1 > 0) else false
end

return getShouldPageUseWidgetOnlyFetcher
