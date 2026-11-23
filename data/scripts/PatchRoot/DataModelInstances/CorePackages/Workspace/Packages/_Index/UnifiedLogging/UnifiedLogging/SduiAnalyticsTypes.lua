-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
local UnifiedLoggingParent = script:FindFirstAncestor("UnifiedLogging").Parent
local t = require(UnifiedLoggingParent.t)

return {
    CollectionAnalyticsDataInterface = {
        collectionId = t.union(t.number, t.string),
        contentType = t.string,
        itemsPerRow = t.number,
        collectionPosition = t.number,
        startRowNumber = t.optional(t.number),
        totalNumberOfItems = t.number,
        refId = t.optional(t.string)
    },
    ItemAnalyticsDataInterface = {
        id = t.union(t.number, t.string),
        itemPosition = t.optional(t.number)
    }
}
