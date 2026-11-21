-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:10:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent
local React = require(AvatarExperienceCatalogParent.React)

local CatalogPageMonolithDependenciesContext = require(script.Parent.CatalogPageMonolithDependenciesContext)

local function useCatalogPageMonolithDependencies()
    local var1 = React.useContext(CatalogPageMonolithDependenciesContext)
    assert(var1, "useCatalogPageMonolithDependencies must be used within a CatalogPageMonolithDependenciesContext.Provider")

    return var1
end

return useCatalogPageMonolithDependencies
