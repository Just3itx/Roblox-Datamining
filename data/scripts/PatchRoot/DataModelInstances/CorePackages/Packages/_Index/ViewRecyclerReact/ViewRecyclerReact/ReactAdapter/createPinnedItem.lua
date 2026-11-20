-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact084
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")

local RecyclableViewRegistry = require(ViewRecyclerReact.ReactAdapter.Private.RecyclableViewRegistry)

local function createPinnedItem(tbl1)
    assert(tbl1.key ~= "", "createPinnedItem: `key` must not be empty")
    assert(
        RecyclableViewRegistry.isRegistered(tbl1.itemType),
        "createPinnedItem: `itemType` must be a Recyclable view type"
    )

    return table.freeze({
        key = tbl1.key,
        value = tbl1.value,
        itemType = tbl1.itemType,
        estimatedLength = if FFlagViewRecyclerReact084 then tbl1.estimatedLength else nil
    })
end

return createPinnedItem
