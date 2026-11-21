-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")

local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)
local AXCatalogStoreContext = require(AvatarExperienceCatalog.Context.AXCatalogStoreContext)

local Stores = require(AvatarExperienceCatalog.Stores)

local function useAXCatalogStoreContext()
    local var1 = React.useContext(AXCatalogStoreContext)
    if var1 then
        return var1
    end

    warn("useAXCatalogStoreContext must be used within an AXCatalogStoreContext provider")
    return Stores()
end

return useAXCatalogStoreContext
