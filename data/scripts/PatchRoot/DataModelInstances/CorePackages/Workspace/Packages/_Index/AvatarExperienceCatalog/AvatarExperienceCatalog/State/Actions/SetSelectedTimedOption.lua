-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent
local _AvatarExperienceModel = require(AvatarExperienceCatalogParent.AvatarExperienceModel)
return require(AvatarExperienceCatalogParent.Rodux).makeActionCreator(script.Name, function(tbl1)
    return {
        itemId = tbl1.itemId,
        selectedTimedOptionIndex = tbl1.selectedTimedOptionIndex,
        itemType = tbl1.itemType
    }
end)
