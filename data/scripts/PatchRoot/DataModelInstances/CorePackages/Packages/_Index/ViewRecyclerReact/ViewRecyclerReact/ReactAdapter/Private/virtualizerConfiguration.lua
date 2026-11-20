-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact084
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")
local _ViewRecyclerRoblox = require(ViewRecyclerReact.Parent.ViewRecyclerRoblox)

local function toCorePinnedItem(arg1): {estimatedLength: number, itemViewType: any, key: any, value: any}? -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1 == nil then
        return nil
    end
    return {
        key = arg1.key,
        value = arg1.value,
        itemViewType = arg1.itemType,
        estimatedLength = if FFlagViewRecyclerReact084 then arg1.estimatedLength else nil
    }
end

local function virtualizerConfiguration(arg1, tbl1)
    local var1 = table.clone(arg1)
    var1.scrollingFrame = tbl1.scrollingFrame
    var1.viewportOverlay = tbl1.viewportOverlay
    var1.pinnedStartItem = toCorePinnedItem(arg1.pinnedStartItem)
    var1.pinnedEndItem = toCorePinnedItem(arg1.pinnedEndItem)
    return var1
end

return virtualizerConfiguration
