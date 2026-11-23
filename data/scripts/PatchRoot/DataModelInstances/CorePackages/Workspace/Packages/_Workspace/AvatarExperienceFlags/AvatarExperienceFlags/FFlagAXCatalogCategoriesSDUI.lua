-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagAXCatalogSupportDisableFilters = require(script.Parent.FFlagAXCatalogSupportDisableFilters)
local FFlagAXMigrateCategoryTooltip = require(script.Parent.FFlagAXMigrateCategoryTooltip)
local FFlagAXFixHydratedWidgetsParams = require(script.Parent.FFlagAXFixHydratedWidgetsParams)
local FFlagAXUnifiedMarketplaceResultsFetcher = require(script.Parent.FFlagAXUnifiedMarketplaceResultsFetcher)

return FFlagAXCatalogSupportDisableFilters
    and FFlagAXMigrateCategoryTooltip
    and FFlagAXFixHydratedWidgetsParams
    and FFlagAXUnifiedMarketplaceResultsFetcher
    and game:DefineFastFlag("AXCatalogCategoriesSDUI14", false)
