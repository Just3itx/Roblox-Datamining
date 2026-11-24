-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent
local t = require(DataHydrationParent.t)
local _Signals = require(DataHydrationParent.Signals)

local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

return {
    marketplaceCatalogCategoryResponseItemValidator = t.interface({
        id = t.string,
        title = t.string,
        name = t.string,
        taxonomyId = t.optional(t.string),
        buttonsEnabled = t.optional(t.table),
        subcategories = t.optional(t.table),
        defaultSubcategoryId = t.optional(t.string),
        assetTypes = t.optional(t.table),
        bundleTypes = t.optional(t.table),
        canAnimateCameraBasedMood = t.optional(t.boolean),
        cameraFocus = t.optional(t.string),
        cameraZoomRadius = t.optional(t.number),
        tileType = t.optional(t.string),
        timeToRefresh = t.optional(t.number),
        categoryId = t.optional(t.number),
        subcategoryId = t.optional(t.number),
        looksWidgetContextForOrganicContent = t.optional(t.string)
    })
}
