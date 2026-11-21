-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)

local CatalogItemCarouselSortView = require(script.Parent.CatalogItemCarouselSortView)
local useCatalogItemCarouselSortViewModel = require(script.Parent.useCatalogItemCarouselSortViewModel)

return React.forwardRef(function(arg1, arg2) -- name: CatalogItemCarouselSortContainer
    local var1 = useCatalogItemCarouselSortViewModel(arg1, arg2)
    return React.createElement(CatalogItemCarouselSortView, var1)
end)
