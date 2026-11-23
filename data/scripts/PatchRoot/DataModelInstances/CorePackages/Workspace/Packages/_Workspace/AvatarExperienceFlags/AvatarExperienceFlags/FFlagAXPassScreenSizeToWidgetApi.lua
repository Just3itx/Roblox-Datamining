-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T15:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagAXRootRFYMigration = require(script.Parent.FFlagAXRootRFYMigration)
local FFlagAXUnifiedMarketplaceResultsFetcher = require(script.Parent.FFlagAXUnifiedMarketplaceResultsFetcher)
local FFlagAXResetFetchMarketplaceLogic = require(script.Parent.FFlagAXResetFetchMarketplaceLogic)

return FFlagAXRootRFYMigration
    and FFlagAXUnifiedMarketplaceResultsFetcher
    and FFlagAXResetFetchMarketplaceLogic
    and game:DefineFastFlag("AXPassScreenSizeToWidgetApi5", false)
