-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)

local CatalogItemGroupSortView = require(script.Parent.CatalogItemGroupSortView)
local useCatalogItemGroupSortViewModel = require(script.Parent.useCatalogItemGroupSortViewModel)

return React.forwardRef(function(arg1, ref) -- name: CatalogItemGroupSortContainer
    local var1 = useCatalogItemGroupSortViewModel(arg1)
    local var2 = table.clone(var1)
    var2.ref = ref
    return React.createElement(CatalogItemGroupSortView, var2)
end)
