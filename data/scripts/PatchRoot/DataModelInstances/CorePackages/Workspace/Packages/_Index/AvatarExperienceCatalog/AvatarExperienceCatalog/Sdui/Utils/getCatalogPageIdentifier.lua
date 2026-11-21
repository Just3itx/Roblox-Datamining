-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")

local Constants = require(AvatarExperienceCatalog.Sdui.Constants)

local tbl1 = { ["catalog-tab:all"] = "catalog-tab:recommended" }

local function getCatalogPageIdentifier(str1: string): string
    local var1 = tbl1[str1] or str1
    return `{Constants.CatalogContentIdentifierPrefix}:{var1}`
end

return getCatalogPageIdentifier
