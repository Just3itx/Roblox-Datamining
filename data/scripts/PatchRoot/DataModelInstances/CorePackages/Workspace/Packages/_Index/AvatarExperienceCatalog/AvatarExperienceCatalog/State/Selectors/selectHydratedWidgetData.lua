-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local _AvatarExperienceRodux = require(AvatarExperienceCatalogParent.AvatarExperienceRodux)

local function selectHydratedWidgetData(arg1)
    return arg1
        and arg1.AvatarExperience
        and arg1.AvatarExperience.Common
        and arg1.AvatarExperience.Common.Widgets
        and arg1.AvatarExperience.Common.Widgets.HydratedWidgetData
end

return selectHydratedWidgetData
