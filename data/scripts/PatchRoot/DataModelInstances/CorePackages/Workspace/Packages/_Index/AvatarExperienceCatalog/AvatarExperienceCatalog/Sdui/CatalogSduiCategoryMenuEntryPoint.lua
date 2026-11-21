-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local React = require(AvatarExperienceCatalogParent.React)
local _Foundation = require(AvatarExperienceCatalogParent.Foundation)
local _SduiLoadTimer = require(AvatarExperienceCatalogParent.SduiSharedUtilities).SduiLoadTimer
local Constants = require(script.Parent.Constants)
local CatalogSduiEntryPoint = require(script.Parent.CatalogSduiEntryPoint)

local MarketplaceCategoryMenuSkeleton = require(AvatarExperienceCatalog.Components.MarketplaceCategoryMenuSkeleton.MarketplaceCategoryMenuSkeleton)

local FFlagAXMarketplaceLoadingSkeleton = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXMarketplaceLoadingSkeleton

local function CatalogSduiCategoryMenuEntryPoint(tbl1)
    local loadingSlot = if FFlagAXMarketplaceLoadingSkeleton then React.createElement(MarketplaceCategoryMenuSkeleton) else nil
    return React.createElement(CatalogSduiEntryPoint, {
        context = tbl1.context,
        identifier = Constants.CatalogCategoryMenuIdentifier,
        appPage = tbl1.appPage,
        loadTimer = tbl1.loadTimer,
        Size = tbl1.Size,
        Position = tbl1.Position,
        shouldDisplayError = tbl1.shouldDisplayError,
        shouldDisplayLoading = not not FFlagAXMarketplaceLoadingSkeleton,
        loadingSlot = loadingSlot
    })
end

return CatalogSduiCategoryMenuEntryPoint
