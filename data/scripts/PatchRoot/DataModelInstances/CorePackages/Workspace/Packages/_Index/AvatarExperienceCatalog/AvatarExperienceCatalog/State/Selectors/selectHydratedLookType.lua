-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local _AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local ItemTypeEnum = require(AvatarExperienceCatalogParent.AvatarExperienceModel).Enums.ItemTypeEnum

local selectHydratedWidgetData = require(script.Parent.selectHydratedWidgetData)

local function selectHydratedLookType(arg1, str1: string)
    local var1 = selectHydratedWidgetData(arg1)
    local var2 = var1 and var1[ItemTypeEnum.Look]
    local var3 = var2 and var2[str1]
    return var3 and var3.lookType or nil
end

return selectHydratedLookType
