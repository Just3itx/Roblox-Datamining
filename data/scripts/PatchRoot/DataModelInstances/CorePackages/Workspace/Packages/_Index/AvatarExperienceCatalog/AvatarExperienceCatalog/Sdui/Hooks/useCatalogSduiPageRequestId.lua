-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)
local useSignalState = require(AvatarExperienceCatalogParent.SignalsReact).useSignalState

local CatalogSduiPageContext = require(AvatarExperienceCatalog.Sdui.CatalogSduiPageContext)
local GetCatalogPageRequestIdStore = require(AvatarExperienceCatalog.Stores.GetCatalogPageRequestIdStore)

local function useCatalogSduiPageRequestId()
    local var1 = React.useContext(CatalogSduiPageContext)
    local identifier = if var1 then var1.identifier else nil
    local catalogPageRequestIdStore = GetCatalogPageRequestIdStore(false)
    local var2 = useSignalState(catalogPageRequestIdStore.getPageRequestIdMap)[identifier or ""]

    React.useEffect(function()
        if identifier ~= nil then
            catalogPageRequestIdStore.getOrCreatePageRequestId(identifier)
        end
    end, { identifier, catalogPageRequestIdStore })

    return identifier, var2
end

return useCatalogSduiPageRequestId
