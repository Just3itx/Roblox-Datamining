-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local Constants = require(AvatarExperienceCatalog.Sdui.Constants)
local normalizeScreenSizeForWire = require(AvatarExperienceCatalogParent.AvatarExperienceCommon).Utils.normalizeScreenSizeForWire

local function getCatalogConfigKey(str1: string, str2: string): string
    local var1 = normalizeScreenSizeForWire(str2)
    return `{Constants.CatalogSduiConfigKeyPrefix}-{str1}-{var1}`
end

return getCatalogConfigKey
