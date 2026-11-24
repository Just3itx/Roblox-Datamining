-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent
local t = require(DataHydrationParent.t)
local _Signals = require(DataHydrationParent.Signals)

local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

return {
    marketplaceCatalogSortResponseItemValidator = t.interface({
        id = t.string,
        type = t.string,
        hydrationPriority = t.number,
        hydrationCount = t.number,
        content = t.table,
        previewColumns = t.optional(t.number),
        title = t.optional(t.string),
        description = t.optional(t.string),
        cardStyle = t.optional(t.table),
        cardFooters = t.optional(t.table),
        tagId = t.optional(t.string)
    })
}
