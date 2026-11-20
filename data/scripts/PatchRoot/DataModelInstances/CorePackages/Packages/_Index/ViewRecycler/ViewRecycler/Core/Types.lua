-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local _DataSourceChangeType = require(ViewRecycler.Core.Enums.DataSourceChangeType)

local module = {
    EMPTY_INDEX_RANGE = table.freeze({ firstIndex = 1, lastIndex = 0 }),
    INDEX_RANGE_KEYS = table.freeze({ "firstIndex", "lastIndex" }),
    ITEM_LAYOUT_KEYS = table.freeze({ "startOffset", "length" }),
    SCROLL_STATE_KEYS = table.freeze({ "scrollOffset", "viewportLength", "contentLength", "distanceFromEnd", "atStart", "atEnd" })
}
function module.isIndexRangeEmpty(tbl1): boolean
    return tbl1.lastIndex < tbl1.firstIndex
end

function module.getIndexRangeLength(tbl1): number
    return math.max(0, tbl1.lastIndex - tbl1.firstIndex + 1)
end

return module
