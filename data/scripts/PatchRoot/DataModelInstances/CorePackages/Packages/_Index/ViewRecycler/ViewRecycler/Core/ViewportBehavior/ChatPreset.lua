-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local AutoScrollPolicy = require(ViewRecycler.Core.Enums.AutoScrollPolicy)
local ReachedThreshold = require(ViewRecycler.Core.ViewportBehavior.ReachedThreshold)
local ScrollAlignment = require(ViewRecycler.Core.Enums.ScrollAlignment)

return table.freeze({
    create = function(tbl1)
        local startReachedThreshold = if tbl1 == nil then 0 else tbl1.startReachedThreshold or 0
        local endReachedThreshold = if tbl1 == nil then 1 else tbl1.endReachedThreshold or 1
        ReachedThreshold.validate(startReachedThreshold, "ChatPreset: startReachedThreshold")
        local autoScrollThreshold = if tbl1 == nil then 1 else tbl1.autoScrollThreshold or 1
        ReachedThreshold.validate(endReachedThreshold, "ChatPreset: endReachedThreshold")
        ReachedThreshold.validate(autoScrollThreshold, "ChatPreset: autoScrollThreshold")
        return table.freeze({
            initialScrollAlignment = ScrollAlignment.End,
            contentAlignment = ScrollAlignment.End,
            autoScrollOnChange = AutoScrollPolicy.WhenAtEnd,
            autoScrollThreshold = autoScrollThreshold,
            preserveScrollPositionOnChange = true,
            startReachedThreshold = startReachedThreshold,
            endReachedThreshold = endReachedThreshold
        })
    end
})
